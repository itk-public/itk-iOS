//
//  IGHttpTask.m
//  PR
//
//  Created by 黄小雪 on 23/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "IGHttpTask.h"
#import "JSON.h"
#import "IGURL.h"
#import "IGNetworkConfig.h"
#import "IGErrorHandler.h"
#import "IGUtilties.h"
#import "IGSecurityPolicy.h"
#import "AFHTTPRequestOperationManager.h"

#if DEBUG
#define InNetworkMock   1
#endif

@interface IGHttpTask()
{
    BaseRequest *                           m_reqObj;
    BaseRespond *                           m_rspObj;
    AFHTTPRequestOperationManager *         m_requstManager;
    NSInteger                               m_retryedTime;
}

@property (nonatomic,strong)    BaseRequest                   * request;
@property (nonatomic,strong)    BaseRespond                   * respond;
@property (nonatomic,readwrite) AFHTTPRequestOperationManager * requestMananger;
@property (strong,nonatomic) id obje;
@end

@implementation IGHttpTask
@synthesize request         = m_reqObj;
@synthesize requestMananger = m_requstManager;

-(BOOL)startTaskWithReq:(BaseRequest *)request
{
    self.request = request;
    [self runTask];
    return YES;
}


//取消请求
-(void)cancel
{
    self.delegate = nil;
    [m_requstManager.operationQueue cancelAllOperations];
}


//发起实际的网络请求
-(void)runTask
{
#if InNetworkMock 
    //做数据mock
    IGURL *reqBaseURL = self.request.baseURL;
    NSString *path = [reqBaseURL.path lastPathComponent];
    NSString *jsonfile = [[NSBundle mainBundle]pathForResource:path ofType:@"json"];
    if ([jsonfile length]) {
        __block NSString * content = [NSString stringWithContentsOfFile:jsonfile
                                                               encoding:NSUTF8StringEncoding
                                                                  error:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            [self disposeFailedResp:nil error:nil respond:[content JSONValue]];
            [self disposeSuccessResp:nil respond:[content JSONValue]];
        });
        return;
    }
#endif
    
    if (m_requstManager) {
        //取消上一个请求
        [m_requstManager.operationQueue cancelAllOperations];
    }
    m_requstManager = [AFHTTPRequestOperationManager manager];
    AFSecurityPolicy *securityPolicy = [IGSecurityPolicy customSecurityPolicy];
    m_requstManager.securityPolicy    = securityPolicy;
    m_requstManager.requestSerializer = [AFJSONRequestSerializer serializer];
    if (m_reqObj.isString) {
        m_requstManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    m_requstManager.responseSerializer  = [AFJSONResponseSerializer serializer];
    m_requstManager.requestSerializer.timeoutInterval = 10.0f;
    if ([[IGNetworkConfig sharedInstance] userAgent]) {
        [m_requstManager.requestSerializer setValue:[[IGNetworkConfig sharedInstance] userAgent] forHTTPHeaderField:@"User-Agent"];
    }
    if ([[[IGNetworkConfig sharedInstance] professionalParamStr] length]) {
        [m_requstManager.requestSerializer setValue:[[IGNetworkConfig sharedInstance] professionalParamStr]
                                 forHTTPHeaderField:@"X-YH-Biz-Params"];
    }
   // 做网络请求，并且将成功或者失败的内容告知 delegate进行处理。
    AFHTTPRequestOperation *operation = nil;
    switch (self.request.httpMethod) {
        case kHttpMethodPost:
        {
            id paramters = m_reqObj.isString?self.request.paramStr:self.request.postJSONDict;
            operation = [m_requstManager POST:self.request.requestURL parameters:paramters
                                      success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
            {
                [self disposeSuccessResp:operation respond:responseObject];
                
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error)
            {
                [self disposeFailedResp:operation error:error respond:operation.responseObject];
            }];
             break;
        }
        case kHttpMethodGet:
        {
            operation = [m_requstManager GET:self.request.requestURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                [self disposeSuccessResp:operation respond:responseObject];
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                [self disposeFailedResp:operation error:error respond:operation.responseObject];
            }];
            break;
        }
        default:
            break;
    }
    
    if (operation) {
        [operation start];
    }
}
-(void)disposeSuccessResp:(AFHTTPRequestOperation *)operation respond:(id)respondObj
{
    self.respond = [BaseRespond objWithRespondJson:respondObj
                                           taskTag:self.tag
                                       modelParser:self.modelParser
                                    isOutsideVisit:self.request.isOutsideVisit];
    self.respond.httpCode  = operation.response.statusCode;
    if (IGOKRespondStatus == self.respond.status) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestFinished:)]) {
            [self.delegate requestFinished:self];
        }
    }else if (self.delegate && [self.delegate respondsToSelector:@selector(requestFailed:)]){
        [self.delegate requestFailed:self];
    }else if(self.respond.error && NO == [self.respond.error isErrorDisposed]){
        [[[IGNetworkConfig sharedInstance] errorHandler]defaultErrorHandle:self.respond.error];
    }
}

-(void)disposeFailedResp:(AFHTTPRequestOperation *)operation error:(NSError *)error respond:(id)respondObj
{
    //超时重试
    if (error.code == -1001) {
        if (self.retryTimes && (self.retryTimes == NSIntegerMax || m_retryedTime < self.retryTimes)) {
            m_retryedTime ++;
            [self startTaskWithReq:self.request];
            return;
        }
    }
    
    self.respond = [BaseRespond objWithError:error respondInfo:respondObj];
    self.respond.httpCode = operation.response.statusCode;
    if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
        [self.delegate requestFailed:self];
    }
    
    if (error && NO == [error isErrorDisposed]) {
        [[[IGNetworkConfig sharedInstance] errorHandler]defaultErrorHandle:error];
    }
}

-(void)lastRespond:(IGHttpTask *)task
{
    if([self.delegate respondsToSelector:@selector(requestFailed:)]){
        [self.delegate requestFailed:task];
    }
    
    if(task.respond.error && NO == [task.respond.error isErrorDisposed]) {
        [[[IGNetworkConfig sharedInstance] errorHandler] defaultErrorHandle:task.respond.error];
    }
    
}

@end
