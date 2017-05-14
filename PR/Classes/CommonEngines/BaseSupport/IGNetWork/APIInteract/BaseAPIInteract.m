//
//  BaseAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "BaseAPIInteract.h"
#import "IGNetwork.h"
#import "APIInteractCenter.h"

typedef void (^APISucessHandle)(BaseAPIInteract *interact,id modelData);
typedef void (^APIFailedHandle)(BaseAPIInteract *interact, NSError *error, id modelData);

@interface BaseAPIInteract()<IGHttpTaskTaskDelegate>
@property (strong,nonatomic) APISucessHandle sucessHandle;
@property (strong,nonatomic) APIFailedHandle failedHandle;
@property (strong,nonatomic) IGHttpTask     *httpTask;
@end

@implementation BaseAPIInteract

#pragma mark -interface
-(OSStatus)interactScuess:(void (^)(BaseAPIInteract *, id))success failed:(void (^)(BaseAPIInteract *, NSError *, id))failed
{
    if (_repeatPolicy == APIInteractPolicy_PreventRepeat) {
        if ([[APIInteractCenter sharedInstance]checkAPIIncall:[self apiIdentity]]) {
            return kAPIErrRepeatReq;
        }else if (_repeatPolicy == APIInteractPolicy_CancelPrevious){
            [[APIInteractCenter sharedInstance] cancelAllIdentifyAPICall:[self apiIdentity]];
        }
    }
    self.sucessHandle  = success;
    self.failedHandle  = failed;
    if (self.httpTask) {
        [self.httpTask cancel];
        self.httpTask = nil;
    }
    
    BaseRequest *request = [self networkRequest];
    if (request == nil) {
        if (self.failedHandle) {
            NSError *error = [NSError errorWithDomain:@"Wrong respond"
                                                 code:NSMatchingInternalError
                                             userInfo:@{NSLocalizedDescriptionKey:@"App内部错误"}];
            self.failedHandle(self,error,nil);
        }
        NSAssert(false, @"理论上不应该出现构建不出request的情况，应该在外部就应该保护住的");
        return kAPIErrReqestGenerateFailed;
    }
    
    IGHttpTask *httpTask = [[IGHttpTask alloc]init];
    httpTask.delegate    = self;
    httpTask.modelParser = [self modelParser];
    self.httpTask        = httpTask;
    
    //发送之前，先到api管理中心注册下
    [[APIInteractCenter sharedInstance] registerAPICall:[self apiIdentity] interactor:self];
    
    //发起请求
    BOOL isSend = [httpTask startTaskWithReq:request];
    if (isSend) {
        return noErr;
    }
    return kAPIErrNetworkSendFailed;
}

-(void)cancelInteract
{
    [self.httpTask cancel];
    self.httpTask = nil;
   [[APIInteractCenter sharedInstance] cancelAPICall:[self apiIdentity] interactor:self];
}

#pragma mark - Inherit interface

-(BaseRequest *)networkRequest
{
    return nil;
}
-(NSString *)apiIdentity
{
    return NSStringFromClass([self class]);
}

-(id<IGParserInterface>)modelParser
{
    return nil;
}

#pragma mark - IGHttpTaskTaskDelegate
-(void)requestFailed:(IGHttpTask *)task
{
    if (self.failedHandle) {
        self.failedHandle(self,task.respond.error,task.respond.parsedModel);
    }
}

-(void)requestFinished:(IGHttpTask *)task
{
    if (self.sucessHandle) {
        self.sucessHandle(self,task.respond.parsedModel);
    }
}
@end
