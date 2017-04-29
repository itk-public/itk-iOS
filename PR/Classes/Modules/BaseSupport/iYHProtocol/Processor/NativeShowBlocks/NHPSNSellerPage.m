//
//  NHPSNSellerPage.m
//  YHClouds
//
//  Created by biqiang.lai on 16/11/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "NHPSNSellerPage.h"
#import "SellerMainPageViewController.h"
#import "SceneMananger.h"
#import "PRMBureau.h"


@implementation NHPSNSellerPage
- (void)tabbarViewControllerDisplay:(SellerMainPageViewController *)mainPage
{
//    NSDictionary * params     = [self.cmdURL getURLParams];
//    NSString * viewIdentifier = [params safeObjectForKey:URL_QUERY_KEY_NAME hintClass:[NSString class]];
//    if ([viewIdentifier isEqualToString:APPURL_VIEW_IDENTIFIER_SELLER_MAIN]){
//        [mainPage setSelectedIndex:0];
//    }else if ([viewIdentifier isEqualToString:APPURL_VIEW_IDENTIFIER_SELLER_CATEGORY] || [viewIdentifier isEqualToString:APPURL_VIEW_IDENTIFIER_SELLER_INNER_SEARCH]){
//        [PRMBPostOffice postParam:params];
//        [mainPage setSelectedIndex:1];
//    }
}


- (void)disposeNativePageURL:(NSString *)url
{
    [super disposeNativePageURL:url];
    
    BOOL didToSeller = NO;
#if 0
    UIViewController * curVCInNav = [[SceneMananger shareMananger] currentViewController];
    NSArray <UIViewController *> * stackVC = [curVCInNav.navigationController viewControllers];
    for (NSInteger index = 0; index < [stackVC count]; index ++ ) {
        UIViewController * vcInStack = [stackVC objectAtIndex:index];
        if ([vcInStack isKindOfClass:[SellerMainPageViewController class]]) {
            if (index < ([stackVC count] - 1)) {
               [[SceneMananger shareMananger] popToTargetViewController:[SellerMainPageViewController class]];
            }
            [self tabbarViewControllerDisplay:(SellerMainPageViewController *)vcInStack];
            didToSeller = YES;
        }
    }
#endif
    
    if (NO == didToSeller) {
        [self.outPut disposeNativePageURL:url];
    }
}
@end
