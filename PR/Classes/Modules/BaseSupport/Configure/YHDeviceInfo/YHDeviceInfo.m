//
//  YHDeviceInfo.m
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDeviceInfo.h"
#import "WTPersistenceCenter.h"

NSString * const KeyForDeviceID = @"pr.did";
@interface YHDeviceInfo()
{
     NSString * m_deviceID;
}
@end

@implementation YHDeviceInfo
@synthesize deviceID = m_deviceID;
IMP_SINGLETON
@end
