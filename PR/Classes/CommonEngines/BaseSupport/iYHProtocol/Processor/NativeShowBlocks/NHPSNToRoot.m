//
//  NHPSNToRoot.m
//  YHClouds
//
//  Created by biqiang.lai on 16/11/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "NHPSNToRoot.h"
#import "PRControlCenter.h"
#import "SceneMananger.h"
#import "PRTabBarViewController.h"

@implementation NHPSNToRoot

- (void)disposeNativePageURL:(NSString *)url
{
    [super disposeNativePageURL:url];
    
    NSDictionary * params = [url getURLParams];
    NSString * identifier = [params safeObjectForKey:URL_QUERY_KEY_NAME hintClass:[NSString class]];
    NSArray * allTopVCIdentifys = [[PRControlCenter sharedInstance] tabbarVCsIdentify];
    
    BOOL isToRoot = NO;
    NSInteger rootNavIndex = 0;
    for (NSString * aIdentify in allTopVCIdentifys) {
        if ([identifier isEqualToString:aIdentify]) {
            rootNavIndex = [allTopVCIdentifys safeIndexOfObject:aIdentify];
            isToRoot = YES;
            break;
        }
    }
    
    if (YES == isToRoot) {
        SceneMananger * sManager = [SceneMananger shareMananger];
        UIViewController * topVC = [sManager topViewController];
        BOOL didPopToRoot = NO;
        if (topVC.navigationController && [topVC.navigationController isKindOfClass:[UINavigationController class]])
        {
            if ([[topVC.navigationController viewControllers] count] > 1) {
                didPopToRoot = YES;
                [(UINavigationController *)topVC.navigationController popToRootViewControllerAnimated:NO];
                
            }
        }else{
            NSAssert(false, @"topVC获取错误");
        }
        
        if (didPopToRoot) {
            // 之所以需要添加延时处理，是由于8.0系统下 同时做 pop to root  & tabbar
            // 会导致系统展示保存 navi 的 top view ,从而会应发一系列问题
            // 这样修改只是降低的crash 率，后续还是需要找到具体的引起的原因
            dispatch_async(dispatch_get_main_queue(), ^{
                [self toTabbar:rootNavIndex];
            });
        }else{
            [self toTabbar:rootNavIndex];
        }
    }else{
        [self.outPut disposeNativePageURL:self.cmdURL];
    }
}

- (BOOL)toTabbar:(NSInteger)index
{
    UIViewController * tempVC = [[SceneMananger shareMananger] rootViewController];
    if (tempVC && [tempVC isKindOfClass:[PRTabBarViewController
                                         class]]) {
        PRTabBarViewController * tRootVC = (PRTabBarViewController *)tempVC;
        tRootVC.selectedIndex = index;
        tRootVC.tabBar.hidden = NO;
        return YES;
    }else{
        NSAssert(false, @"rootVC获取错误");
    }
    return NO;
}

@end
