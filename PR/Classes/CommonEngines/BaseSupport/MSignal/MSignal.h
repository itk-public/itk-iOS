//
//  MSignal.h
//  PR
//
//  Created by 黄小雪 on 25/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString *MSignalType;

#undef	msignal
#define msignal( name ) \
FOUNDATION_EXTERN MSignalType name;

#undef	def_msignal
#define def_msignal( name ) \
MSignalType name = @#name;

typedef NS_ENUM(NSInteger,SignalState){
    SignalState_Inited   = 0,     //信号构建
    SignalState_Sending,          //信号进行尝试直接发送
    SignalState_Searching,        //无法直接送达，准备基于响应链寻找Responder
    SignalState_Arrived,          //信号处理成功
    SignalState_Dead,             //没有人接受信号，挂了
};

@interface MSignal : NSObject
@property (weak,nonatomic  ) MSignalType type;
@property (weak,nonatomic  ) id          source;
@property (weak,nonatomic  ) id          target;
@property(nonatomic,strong) id param;
@property (assign,nonatomic) SignalState state;

+(instancetype)signalWithSource:(id)source
                           type:(MSignalType)type
                          param:(id)param;

-(BOOL)changeState:(SignalState)newState;
-(BOOL)is:(MSignalType)name;
@end
