//
//  OrderListViewController.m
//  PR
//
//  Created by 黄小雪 on 02/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderListViewController.h"
#import "MutiTitleHeaderView.h"
#import "ProductViewCell.h"
#import "OrderListSectionHeaderView.h"
#import "OrderListSectionFooterView.h"


@interface OrderListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak,nonatomic) MutiTitleHeaderView     *statusView;
@property (assign,nonatomic) OrderFilterType     filterType;
@property (strong,nonatomic) UITableView *tableView;
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.type = 1;
    [self setStateView];
    [self setTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.type > 0) {
        self.filterType = self.type;
//        [self loadModelData];
        [self.statusView setSeletedIndex:[self headIndexWithType:self.filterType]];
        self.type = 0;
    }
}


-(void)setStateView
{
    MutiTitleHeaderView *statusView    = [[MutiTitleHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 46)];
    statusView.autoresizingMask        = UIViewAutoresizingFlexibleWidth;
    statusView.statusBtnTitles         = [[NSArray alloc]initWithObjects:
                                         @"全部",
                                          @"待配送",
                                          @"待自提",
                                          @"待评价",
                                          @"退款中",
                                          nil];
    statusView.fontSize                = 15.0f;
    __weak typeof(self)weakSelf        = self;
    statusView.buttonBlock = ^(NSInteger titleBtnIndex){
        OrderFilterType type = OrderFilterTypeAllOrders;
        switch (titleBtnIndex) {
            case 0:
                type =  OrderFilterTypeAllOrders; break;
            case 1:
                type =  OrderFilterTypeUnDelivery; break;
            case 2:
                type =  OrderFilterTypeUnPickUpSelf; break;
            case 3:
                type = OrderFilterTypeUnEvaluate; break;
            case 4:
                type = OrderFilterTypeRefunding; break;
            default:
                break;
        }
        // 相同的type啥都不做处理
        if (type == weakSelf.filterType) {
            return;
        }
               weakSelf.filterType = type;
//        [weakSelf loadModelData];
    };
    [statusView setSeletedIndex:[self headIndexWithType:self.filterType]];
    self.statusView = statusView;
    [self.view addSubview:self.statusView];
}

-(void)setTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.statusView.bottom, ScreenWidth, self.view.height - self.statusView.bottom) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = [ProductViewCell tableView:nil rowHeightForObject:nil];
    [self.view addSubview:self.tableView];
    
}

#pragma index operate
- (NSInteger)headIndexWithType:(OrderFilterType)filterType
{
    switch (filterType) {
        case OrderFilterTypeAllOrders:
            return 0;
        case OrderFilterTypeUnPickUpSelf:
            return 2;
        case OrderFilterTypeUnDelivery:
            return 1;
        case OrderFilterTypeUnEvaluate:
            return 3;
        case OrderFilterTypeRefunding:
            return 4;
        default:
            break;
    }
    return MAXFLOAT;
}

#pragma mark tableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ProductViewCell";
    ProductViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ProductViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerViewId = @"orderlistsectionheaderview";
    OrderListSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
    if (headerView == nil) {
        headerView = [[OrderListSectionHeaderView alloc]initWithReuseIdentifier:headerViewId];
    }
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 46;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    static NSString *footerViewId = @"orderlistsectionfooterview";
    OrderListSectionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerViewId];
    if (footerView == nil) {
        footerView = [[OrderListSectionFooterView alloc]initWithReuseIdentifier:footerViewId];
    }
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [OrderListSectionFooterView getHeight];
}
@end
