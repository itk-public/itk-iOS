//
//  IGHttpTask.h
//  PR
//
//  Created by 黄小雪 on 23/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "BaseRequest.h"
#import "BaseRespond.h"

// 一个实际的网络请求，类似 NSURLConnection 的作用。
// 主要负责发起实际的请求。
// 目前将所有的网络请求都约束到这个类，或者它的子类。
// 后续视情况可以扩展网络调度，优先级等问题。

@class IGHttpTask;
@protocol IGHttpTaskTaskDelegate <NSObject>

@optional
- (void)requestFinished:(IGHttpTask*)request;
- (void)requestFailed:(IGHttpTask *)request;

@end

@interface IGHttpTask : NSObject

@property (weak,nonatomic) id<IGHttpTaskTaskDelegate> delegate;
@property (weak,nonatomic) id<IGParserInterface> modelParser;
@property (readonly,nonatomic) BaseRespond *respond;
@property (assign,nonatomic) NSInteger tag;
@property (assign,nonatomic) NSInteger retryTimes;

-(BOOL)startTaskWithReq:(BaseRequest *)request;

/**
 *  取消请求
 */
-(void)cancel;

-(void)lastRespond:(IGHttpTask *)task;

@end

@interface IGHttpTask(protocolInterface)
-(BaseRequest *)requset;
-(void)disposeSuccessResp:(AFHTTPRequestOperation *)operation respond:(id)respondObj;
- (void)disposeFailedResp:(AFHTTPRequestOperation *)operation error:(NSError *)error respond:(id)respondObj;
@end
