//
//  BaseAPIInteract.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGNetwork.h"


#define kAPIErrRepeatReq            -19923
#define kAPIErrNetworkSendFailed    -19924
#define kAPIErrReqestGenerateFailed -19925

typedef NS_ENUM(char,APIInteractPolicy)
{
    APIInteractPolicy_PreventRepeat,     //阻止当前的请求
    APIInteractPolicy_CancelPrevious,    //取消上一个请求
    APIInteractPolicy_Sequence,          //串行请求
};

/**
 *  对外使用的接口
 */
@interface BaseAPIInteract : NSObject
{
@protected
    APIInteractPolicy    _repeatPolicy;
}

- (OSStatus)interactScuess:(void (^)(BaseAPIInteract *interact, id modelData))success
                    failed:(void (^)(BaseAPIInteract *interact, NSError * error , id modelData))failed;

- (void)cancelInteract;

// 糖调用，这个是精简化的API请求，包含了一些
// 通用的基础的网络请求功能，节省重复构建 API 子类的工作
+ (instancetype)sugarSimpleAPI:(NSString *)path
                         param:(NSDictionary *)param
                          http:(HttpMethodType)method
                      modelCls:(Class)modelClass;

+ (instancetype)sugarSimpleURLReq:(NSString *)url
                            param:(NSDictionary *)param
                             http:(HttpMethodType)method
                         modelCls:(Class)modelClass;

//- (void)adjustAPIPolicy:(APIInteractPolicy)policy;
//
//- (void)configPageRespondParser:(NSString *)pageKey;
@end

@class BaseRequest;
@protocol  IGParserInterface;
/**
 *  继承用的接口
 */
@interface BaseAPIInteract(Inherit)
-(BaseRequest *)networkRequest;
-(id<IGParserInterface>)modelParser;

@end

/**
 *  阻塞唤醒使用
 */
@interface BaseAPIInteract(blockWake)
- (void)continueFaildDispose;
- (void)restoreFailedTask;
@end

