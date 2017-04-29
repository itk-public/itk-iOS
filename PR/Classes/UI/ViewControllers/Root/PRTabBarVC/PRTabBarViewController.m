//
//  PRTabBarViewController.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PRTabBarViewController.h"
#import "PRTabbarItem.h"
#import "PRTabbarView.h"
#import "WTTabbarNotifyInterface.h"

@interface PRTabBarViewController()<UITabBarControllerDelegate>
@property (strong,nonatomic)PRTabbarView  *prTabbarView;
@end

@implementation PRTabBarViewController

-(instancetype)init{
    if (self = [super init]) {
        self.delegate = self;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    NSArray * selectedTabImgArr = @[@"tabbar_one_selected", @"tabbar_two_selected", @"tabbar_three_selected", @"tabbar_four_selected"];
    NSArray * unSelectedTabImgArr = @[@"tabbar_one_unselected", @"tabbar_two_unselected", @"tabbar_three_unselected", @"tabbar_four_unselected"];
    NSDictionary * tabImgDic = @{@"selected": selectedTabImgArr, @"unSelected": unSelectedTabImgArr};
    self.prTabbarView = [[PRTabbarView alloc] initWithSelectedImgDic:tabImgDic];
    self.prTabbarView.tag = 500001;
    [self.tabBar addSubview:self.prTabbarView];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    [self.prTabbarView setSelectedIndex:selectedIndex];
}


#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([self.prTabbarView curSeletedIndex] == item.tag) {
        UIViewController * topSeriesVC = [self.viewControllers safeObjectAtIndex:item.tag];
        if ([topSeriesVC conformsToProtocol:@protocol(WTTabbarNotifyInterface)]) {
            __weak id<WTTabbarNotifyInterface> theVC = (id)topSeriesVC;
            if ([theVC respondsToSelector:@selector(refreshActionTriggerByTabbar)]) {
                [theVC refreshActionTriggerByTabbar];
            }
        }
    }
    [self.prTabbarView setSelectedIndex:item.tag];
}
@end
