//
//  MSignal.m
//  PR
//
//  Created by 黄小雪 on 25/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "MSignal.h"

BOOL MSignalTypeEqual(MSignalType origin,MSignalType compare)
{
    return [origin isEqualToString:compare];
}

@implementation MSignal
+(instancetype)signalWithSource:(id)source type:(MSignalType)type param:(id)param
{
    MSignal *signalObj = [[MSignal alloc]init];
    signalObj.source   = source;
    signalObj.type     = type;
    signalObj.param    = param;
    signalObj.state    = SignalState_Inited;
    return signalObj;
}

-(BOOL)changeState:(SignalState)newState
{
    self.state = newState;
    return YES;
}

-(BOOL)is:(MSignalType)name
{
    return MSignalTypeEqual(self.type, name);
}

-(NSString *)description
{
    NSString *superDes = [super description];
    return [NSString stringWithFormat:@"%@\ntype:%@\nstate:%ld\nsource%@\nparam:%@",superDes,self.type,(long)self.state,self.source,self.param];
}
@end
