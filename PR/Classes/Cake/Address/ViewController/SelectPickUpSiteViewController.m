//
//  SelectPickUpSiteViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/5/31.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SelectPickUpSiteViewController.h"
#import "PickSelfSiteListDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"

@interface SelectPickUpSiteViewController ()<WTNetWorkDataConstructorDelegate>
@property (strong,nonatomic) PickSelfSiteListDataConstructor *dataConstructor;
@end

@implementation SelectPickUpSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 10)];
    [headerView setBackgroundColor:kVCViewBGColor];
    [self.tableView setTableHeaderView:headerView];
}
-(void)loadData
{
    [[PRLoadingAnimation sharedInstance]addLoadingAnimationOnView:self.view];
    [self.dataConstructor loadData];
}


-(void)constructData
{
    if (self.dataConstructor == nil) {
        self.dataConstructor = [[PickSelfSiteListDataConstructor alloc]init];
        self.dataConstructor.delegate = self;
    }
     self.tableViewAdaptor.items = self.dataConstructor.items;
}

#pragma mark WTNetWorkDataConstructorDelegate
- (void)dataConstructor:(id)dataConstructor didFinishLoad:(id)dataModel
{
    [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    [self.dataConstructor constructData];
    [self.tableView reloadData];
}

- (void)dataConstructorDidFailLoadData:(id)dataConstructor withError:(NSError *)errorDataModel
{
    [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    [PRShowToastUtil showNotice:[errorDataModel localizedDescription] inView:self.view];
    
}
@end
