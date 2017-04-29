//
//  PublicParamCenter.m
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PublicParamCenter.h"
#import "PRCAppConfig.h"
#import "UserManager.h"

@implementation PublicParamCenter
IMP_SINGLETON

-(NSDictionary *)networkPublicParam
{
#define kNetworkPlatformiOS         @"ios"
    NSMutableDictionary *pbParams = [NSMutableDictionary dictionary];
    [pbParams safeSetObject:kNetworkPlatformiOS forKey:@"platform"];
    [pbParams safeSetObject:[NSString stringWithFormat:@"%ld",(long)[PRCAppConfig appChannel]] forKey:@"channel"];
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *curVer      = [infoDic objectForKey:(NSString *)kCFBundleVersionKey];
    [pbParams safeSetObject:curVer forKey:@"v"];
    
    //用户处于登录状态，则传递
    if ([[UserManager shareMananger] isUserLogin]) {
        [pbParams safeSetObject:[[[UserManager shareMananger] userData] uid] forKey:@"uid"];
        [pbParams safeSetObject:[[[UserManager shareMananger] userData] uToken] forKey:@"access_token"];
    }
    
    return pbParams;
}
@end
