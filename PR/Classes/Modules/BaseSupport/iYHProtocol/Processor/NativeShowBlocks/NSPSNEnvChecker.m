//
//  NSPSNEnvChecker.m
//  YHClouds
//
//  Created by biqiang.lai on 16/11/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "NSPSNEnvChecker.h"
#import "SceneMananger.h"

@implementation NSPSNEnvChecker

- (void)disposeNativePageURL:(NSString *)url
{
    [super disposeNativePageURL:url];
    // login
    IGURL * urlObj = [IGURL urlWithString:url];
    NSString * loginStr = [urlObj queryForKey:URL_QUERY_KEY_NEEDLOGIN isCaseSensitive:NO];
    if (loginStr && [loginStr boolValue] == YES) {
        [[SceneMananger shareMananger] showLoginViewWithCallback:^(BOOL suc) {
            if (suc) {
                [self.outPut disposeNativePageURL:url];
            }
        }];
    }else{
        [self.outPut disposeNativePageURL:url];
    }
}
@end
