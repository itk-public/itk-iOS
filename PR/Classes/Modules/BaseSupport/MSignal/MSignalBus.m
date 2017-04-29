//
//  MSignalBus.m
//  PR
//
//  Created by 黄小雪 on 25/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "MSignalBus.h"
#import "MSStrongResponder.h"

@interface MSignalBus()
{
    NSMutableDictionary *_handlers;
}
@end

@implementation MSignalBus
IMP_SINGLETON

-(void)routes:(MSignal *)signal to:(NSObject *)target
{
    if ([target respondsToSelector:@selector(handleSignal:)]) {
        [(id<MSignalInterface>)target handleSignal:signal];
        [signal changeState:SignalState_Arrived];
    }
}

/**
 *  通过响应链的方式寻找要响应的函数
 *
 *  @param signal 信号内容
 *
 *  @return 处理的返回结果
 */

-(void)forward:(MSignal *)signal
{
    UIResponder *responder = nil;
    if ([signal.source isKindOfClass:[UIResponder class]]) {
        responder = signal.source;
    }
    
    if (responder == nil) {
        return;
    }
    
    //基于响应链进行消息转发
    while (TRUE) {
        if (responder) {
            [self routes:signal to:responder];
            if (signal.state == SignalState_Arrived) {
                break;
            }
        }else{
            break;
        }
        
        responder = [responder nextResponder];
    }
}

-(void)toHell:(MSignal *)signal
{
    [signal changeState:SignalState_Dead];
}

-(void)send:(MSignal *)signal
{
    MSStrongResponder *strongHandler = [signal.source querySignalStrongHandler];
    [signal changeState:SignalState_Sending];
    if (strongHandler) {
        BOOL isHandle = [strongHandler queryExistSignleObserve:signal.type];
        if (isHandle) {
            [self routes:signal to:(id)strongHandler.signalHandler];
        }
    }
    if (SignalState_Arrived != signal.state) {
        [self forward:signal];
    }
    
    if (SignalState_Arrived != signal.state) {
        [self toHell:signal];
    }
}
@end
