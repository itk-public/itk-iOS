//
//  PRControlCenter.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PRControlCenter.h"
#import "PRTabBarViewController.h"
#import "PRTabbarItem.h"
#import "UIImage+Category.h"

@interface PRControlCenter()
@property (strong,nonatomic) UIViewController *rootViewController;

@end
@implementation PRControlCenter
IMP_SINGLETON

- (UIViewController *)rootViewController
{
    if (!_rootViewController) {
        _rootViewController  = [self getTabBarController];
    }
    return _rootViewController;
}


//获取navigationcontroller
-(PRTabBarViewController *)getTabBarController{
    PRTabBarViewController *tabBarController = [[PRTabBarViewController alloc]init];
    tabBarController.tabBar.translucent = YES;
    
    //构建tabbar config
    NSArray *tabConfigs = nil;
    tabConfigs = @[[PRTabbarItem mainPage],
                   [PRTabbarItem categoryPage],
                   [PRTabbarItem cartPage],
                   [PRTabbarItem userCenterPage]];
    
     NSMutableArray * allTabbarVCs = [NSMutableArray arrayWithCapacity:[tabConfigs count]];
    //创建tabbar的子视图控制器
    for (NSInteger i = 0; i < [tabConfigs count] ; i ++) {
        PRTabbarItem *aTabbarConfig = [tabConfigs safeObjectAtIndex:i];
        UITabBarItem *tabbartItem = [[UITabBarItem alloc]init];
        tabbartItem.image = [[aTabbarConfig.image changeImageWithColor:[UIColor clearColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabbartItem.selectedImage = [ [aTabbarConfig.selectedImage changeImageWithColor:[UIColor clearColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tabbartItem.title = @"";//aTabbarConfig.tabbarTitle;
        tabbartItem.tag = i;
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x606060), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorReferenceTawnyColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        
        // 这里做下调整，防止隐藏了tabbar
        [aTabbarConfig.rootvc setHidesBottomBarWhenPushed:NO];
        
        UIViewController * navVc = [aTabbarConfig vcInNavViewController];
        navVc.tabBarItem = tabbartItem;
        [allTabbarVCs addObject:navVc];
    }
    tabBarController.viewControllers = allTabbarVCs;
    return tabBarController;
}


//处理tabbarItem,获取对应的UIViewController
- (UIViewController *)handleTabbarItem:(PRTabbarItem *)aTabbarConfig itemTag:(NSInteger)tag {
    
    UITabBarItem * tabbarItem = [[UITabBarItem alloc] init];
    tabbarItem.image = [[aTabbarConfig.image changeImageWithColor:[UIColor clearColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbarItem.selectedImage = [ [aTabbarConfig.selectedImage changeImageWithColor:[UIColor clearColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    tabbarItem.title = @"";//aTabbarConfig.tabbarTitle;
    tabbarItem.tag = tag;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x606060), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorReferenceTawnyColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    // 这里做下调整，防止隐藏了tabbar
    [aTabbarConfig.rootvc setHidesBottomBarWhenPushed:NO];
    
    UIViewController * navVc = [aTabbarConfig vcInNavViewController];
    navVc.tabBarItem = tabbarItem;
    
    return navVc;
}

- (NSArray *)tabbarVCsIdentify
{
    return @[APPURL_VIEW_IDENTIFIER_MAIN,
             APPURL_VIEW_IDENTIFIER_CATEGORRY,
             APPURL_VIEW_IDENTIFIER_SHOPCART,
             APPURL_VIEW_IDENTIFIER_USERINFO];
}
@end
