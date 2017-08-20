//
//  FarmSearchResultViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/8/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "FarmSearchResultViewController.h"
#import "FarmSearchReustDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"
#import "FarmSearchProudctHeaderView.h"

@interface FarmSearchResultViewController ()<WTNetWorkDataConstructorDelegate,FarmSearchProudctHeaderViewDelegate>
@property (strong,nonatomic) FarmSearchReustDataConstructor *dataConstructor;
@property (strong,nonatomic) FarmSearchProudctHeaderView *headerView;
@end

@implementation FarmSearchResultViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addHeaderView];
}

-(void)addHeaderView
{
    self.headerView = [[FarmSearchProudctHeaderView alloc]init];
    self.headerView.delegate = self;
    self.headerView.frame    = CGRectMake(0, 0, self.view.width, [FarmSearchProudctHeaderView getHeight]);
    [self.view addSubview:self.headerView];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.headerView.frame = CGRectMake(0, 0, self.view.width, [FarmSearchProudctHeaderView getHeight]);
    self.tableView.frame  = CGRectMake(0, self.headerView.bottom, self.view.width, self.view.height - self.headerView.height);
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataConstructor loadData];
    [self.headerView setComprehensiveHighlighted];
}

-(void)constructData
{
    if (self.dataConstructor == nil) {
        self.dataConstructor = [[FarmSearchReustDataConstructor alloc]init];
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

#pragma mark FarmSearchProudctHeaderViewDelegate
-(void)farmSearchProudctHeaderViewDidSelectedBtnType:(FarmSearchBtnType)type
{
    PRLOG(@"======选中的状态====%zd",type);
     [self.dataConstructor loadData];
    
}

@end
