//
//  ConsumptionDetailViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/9/12.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ConsumptionDetailViewController.h"
#import "ConsumptionDetailDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"

@interface ConsumptionDetailViewController ()<WTNetWorkDataConstructorDelegate>
@property (strong,nonatomic) ConsumptionDetailDataConstructor *dataConstructor;

@end

@implementation ConsumptionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"明细";
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)loadData
{
    [[PRLoadingAnimation sharedInstance]addLoadingAnimationOnView:self.view];
    [self.dataConstructor loadData];
}


-(void)constructData
{
    if (self.dataConstructor == nil) {
        self.dataConstructor = [[ConsumptionDetailDataConstructor alloc]init];
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
