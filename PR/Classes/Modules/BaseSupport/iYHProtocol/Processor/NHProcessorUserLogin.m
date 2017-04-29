//
//  NHProcessorUserLogin.m
//  YHClouds
//
//  Created by biqiang.lai on 15/11/11.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "NHProcessorUserLogin.h"
#import "SceneMananger.h"
#import "NSString+Category.h"
#import "UserManager.h"

@implementation NHProcessorUserLogin
+ (BOOL)matchCMDPath:(NSString *)path inCMDURL:(NSString *)url
{
    return [path isEqualToString:URL_PATH_LOGIN];
}

- (void)ourUserDidLogin:(NSString *)callback
{
    UserInfoData * userInfo = [[UserManager shareMananger] userData];
    NSString * jsStr = [NSString stringWithFormat:@"%@(1,'%@','%@')",callback,userInfo.uid,userInfo.uToken];
    [self notifyJSONResult:jsStr];
}

- (void)disposeCommand
{
    NSDictionary * params     = [self.cmdURL getURLParams];
    __block NSString * callbackFunction = [params safeObjectForKey:URL_QUERY_KEY_CB hintClass:[NSString class]];
    
    // 已经登录了
    if ([[UserManager shareMananger] isUserLogin]) {
        [self ourUserDidLogin:callbackFunction];
    }
    
    // 未登录，进行登录
    [[SceneMananger shareMananger] showLoginViewWithCallback:^(BOOL suc) {
        NSString * jsStr = nil;
        if (suc) {
            [self ourUserDidLogin:callbackFunction];
        }else{
            jsStr = [NSString stringWithFormat:@"%@(0,null,null)",callbackFunction];
            [self notifyJSONResult:jsStr];
        }
    }];
}


@end
