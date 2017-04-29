//
//  Utilities.h
//  PR
//
//  Created by 黄小雪 on 10/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CONDITION_CHECK_RETURN_VAULE(x,returnValue) if(!(x)) {return returnValue;}

#define CONDITION_CHECK_RETURN(x) if(!(x)) {return ;}

BOOL check2ObjIsEqual(id x,id y);

@interface Utilities : NSObject

+(NSString *)curOSVersion;

+(NSArray *)transformCoordinateToStrWithLatitude:(double)lat longitude:(double)log;

+ (void)doFrameworkAdjust;

/**
 *  显示console log信息，通过两个手指滑动来显示
 */
+ (void)setUpSwipeToShowLoggingView;


//获取设备型号
+ (NSString *)currentDeviceModel;
@end
