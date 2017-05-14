//
//  PRTabbarItem.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PRTabbarItem.h"
#import "CartViewController.h"
#import "CategoryViewController.h"
#import "HomeViewController.h"
#import "UserCenterViewController.h"
#import "BaseNavigationController.h"


@implementation PRTabbarItem

+ (instancetype)mainPage
{
    PRTabbarItem *item = [[PRTabbarItem alloc]init];
    item.rootvc        = [[HomeViewController alloc]initWithNibName:nil bundle:nil];
    item.tabbarTitle   = @"首页";
    item.image = [UIImage imageNamed:@"tabbar_one_unselected"];
    item.selectedImage = [UIImage imageNamed:@"tabbar_one_selected"];
    return item;
}

+(instancetype)categoryPage
{
    PRTabbarItem *item = [[PRTabbarItem alloc]init];
    item.rootvc        = [[CategoryViewController alloc]initWithNibName:nil bundle:nil];
    item.tabbarTitle   = @"分类";
    item.image = [UIImage imageNamed:@"tabbar_two_unselected"];
    item.selectedImage = [UIImage imageNamed:@"tabbar_two_selected"];
    return item;
}

+ (instancetype)cartPage
{
    PRTabbarItem * item = [[PRTabbarItem alloc] init];
    item.rootvc = [[CartViewController alloc] initWithNibName:nil bundle:nil];
    item.tabbarTitle = @"购物车";
    item.image = [UIImage imageNamed:@"tabbar_three_unselected"];
    item.selectedImage = [UIImage imageNamed:@"tabbar_three_selected"];
    return item;
}

+ (instancetype)userCenterPage
{
    PRTabbarItem * item = [[PRTabbarItem alloc] init];
    
    UserCenterViewController * browser = [[UserCenterViewController alloc]initWithNibName:nil bundle:nil];
    item.rootvc = browser;
    item.tabbarTitle = @"会员中心";
    item.image = [UIImage imageNamed:@"tabbar_four_unselected"];
    item.selectedImage = [UIImage imageNamed:@"tabbar_four_selected"];
    return item;
}

- (UINavigationController *) vcInNavViewController
{
    return [[BaseNavigationController alloc] initWithRootViewController:self.rootvc];
}

@end
