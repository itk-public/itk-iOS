//
//  NHPShowWeb.m
//  YHClouds
//
//  Created by biqiang.lai on 15/11/4.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "NHPShowWeb.h"
#import "NSString+Category.h"
#import "IGURL.h"
#import "IGUtilties.h"
#import "WTBrowseViewController.h"
#import "SceneMananger.h"
#import "UserManager.h"
#import "InternalSchemeHandler.h"

@implementation NHPShowWeb
+ (BOOL)matchCMDPath:(NSString *)path inCMDURL:(NSString *)url
{
    return [path isEqualToString:URL_PATH_WEB];
}


- (void)disposeCommand
{
    IGURL * url = [IGURL urlWithString:self.cmdURL];
    
     BOOL needLogin = NO;
    __block NSString* targetWebURL = nil;
    __block NSString * title = nil;
    
    //url
    NSString * loadedEncodedURL = [url queryForKey:URL_QUERY_KEY_URL isCaseSensitive:NO];
    if (loadedEncodedURL) {
        targetWebURL = [IGUtilties decodeURL:loadedEncodedURL];
    }
    
    // 由于目前后端会把native的协议配置在showweb 里面，所以这里添加特殊处理
    if (YES == [InternalSchemeHandler isInternalScheme:targetWebURL]) {
        [[InternalSchemeHandler defaultHandler] handleURL:targetWebURL];
        return;
    }
    
    // title
   title = [url queryForKey:URL_QUERY_KEY_TITLE isCaseSensitive:NO];
    
    // login
    NSString * loginStr = [url queryForKey:URL_QUERY_KEY_NEEDLOGIN isCaseSensitive:NO];
    if (loginStr) {
        needLogin = [loginStr boolValue];
    }
    
    //URL_QUERY_KEY_BACK_LEAP 判断是否要跳过前面的页面
    BOOL leap = NO;
    NSString * backLeap = [url queryForKey:URL_QUERY_KEY_BACK isCaseSensitive:NO];
    if (backLeap && [backLeap isEqualToString:URL_QUERY_KEY_BACK_LEAP_STRING]) {
        leap = YES;
    }
    
    WTBrowseViewController * browse = [[WTBrowseViewController alloc] init];
    browse.urlString = targetWebURL;
    browse.defaultTitle = title;
    browse.needLogin = needLogin;
    if (leap) {
        [browse outOfNavigationStack];
    }
    [[SceneMananger shareMananger] showViewController:browse withStyle:U_SCENE_SHOW_PUSH];
}
@end
