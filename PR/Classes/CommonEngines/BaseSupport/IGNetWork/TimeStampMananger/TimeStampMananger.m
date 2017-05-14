//
//  TimeStampMananger.m
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "TimeStampMananger.h"
#import "WTPersistenceCenter.h"
#define AppStore_LatestLostFoucse_Key       @"AppLatestLostFoucse"

@implementation TimeStampMananger

+ (instancetype)shareManager
{
    static TimeStampMananger * __tsManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __tsManager = [TimeStampMananger new];
    });
    return __tsManager;
}

- (NSTimeInterval)timeStamp
{
    return [[NSDate date] timeIntervalSince1970] + self.deltaTime;
}

- (void)storeAppLostFoucedTimeStamp
{
    [WTPersistenceCenter storeInfo:[NSNumber numberWithDouble:[self timeStamp]]
                               key:AppStore_LatestLostFoucse_Key
                              type:PersistenceLocal];
    
}

- (NSTimeInterval)lastAppLostFoucedTimeStamp
{
    return [[WTPersistenceCenter getInfo:AppStore_LatestLostFoucse_Key type:PersistenceLocal] doubleValue];
}
@end


@implementation TimeStampMananger(RestrictedInterface)

- (void)updateDeltaTime:(NSTimeInterval)deltaTime
{
    _deltaTime = deltaTime;
}
@end
