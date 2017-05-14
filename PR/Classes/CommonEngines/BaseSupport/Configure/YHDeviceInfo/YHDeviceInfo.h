//
//  YHDeviceInfo.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHDeviceInfo : NSObject
@property (readonly,nonatomic) NSString *deviceID;
DEF_SINGLETON(YHDeviceInfo)
@end
