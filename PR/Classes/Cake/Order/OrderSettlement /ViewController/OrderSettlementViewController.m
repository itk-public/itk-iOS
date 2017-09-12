//
//  OrderSettlementViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/8/23.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderSettlementViewController.h"
#import "OrderSettlementDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"
#import "ShopCartTableHeaderView.h"
#import "OrderManager.h"

@interface OrderSettlementViewController ()<WTNetWorkDataConstructorDelegate,OrderMangerDelegate>
@property (strong,nonatomic) OrderSettlementDataConstructor  *dataConstructor;
@property (strong,nonatomic) ShopCartTableHeaderView         *headerView;
@property (strong,nonatomic) OrderManager                    *manager;
@end

@implementation OrderSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerView   = [[ShopCartTableHeaderView alloc]init];
    _headerView.hidden        = YES;
    self.navTitle = @"订单结算";
    [self loadData];
}

-(void)loadData
{
    [self.dataConstructor loadData];
}

#pragma mark WTNetWorkDataConstructorDelegate
- (void)dataConstructor:(id)dataConstructor didFinishLoad:(id)dataModel
{
    [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    [self.dataConstructor constructData];
    [self.tableView reloadData];
     [self.headerView update];
     self.headerView.frame         = CGRectMake(0, 0, 0, [self.headerView height]);
     self.headerView.hidden = NO;
     [self.tableView setTableHeaderView:_headerView];
}

- (void)dataConstructorDidFailLoadData:(id)dataConstructor withError:(NSError *)errorDataModel
{
    [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    [PRShowToastUtil showNotice:[errorDataModel localizedDescription] inView:self.view];
    
}

-(void)constructData
{
    if (self.dataConstructor == nil) {
        self.dataConstructor = [[OrderSettlementDataConstructor alloc]init];
        self.dataConstructor.delegate = self;
        self.dataConstructor.responder = self;
    }
    self.tableViewAdaptor.items = self.dataConstructor.items;
}


#pragma mark OrderMangerDelegate
-(void)loadDataSuccessful:(OrderManager *)manager dataType:(OrderManagerType)dataType  data:(id)data  isCache:(BOOL)isCache
{
    
}
-(void)loadDataFailed:(OrderManager *)manager dataType:(OrderManagerType )dataType error:(NSError*)error
{
    
}

#pragma mark OrderSettlementSaveBtnCellDelegate
-(void)orderSettlementSaveBtnOnClicked
{
    if (self.manager == nil) {
        self.manager = [[OrderManager alloc]init];
        self.manager.delegate = self;
    }
    [self.manager orderSubmit:nil];
}

@end
