//
//  TimeStampMananger.h
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeStampMananger : NSObject

@property (readonly,nonatomic) NSTimeInterval deltaTime;         // 与服务器进行的增量时间

+(instancetype)shareManager;

//获取当前校正过的时间戳
-(NSTimeInterval)timeStamp;

//上一次app离开焦点的时间
-(void)storeAppLostFoucedTimeStamp;
- (NSTimeInterval)lastAppLostFoucedTimeStamp;

@end

@interface TimeStampMananger (RestrictedInterface)
- (void)updateDeltaTime:(NSTimeInterval)deltaTime;
@end
