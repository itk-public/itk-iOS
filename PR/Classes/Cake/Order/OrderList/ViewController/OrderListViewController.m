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
#import "OrderListDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"


@interface OrderListViewController () <WTNetWorkDataConstructorDelegate>
@property (weak,nonatomic) MutiTitleHeaderView         *statusView;
@property (assign,nonatomic) OrderFilterType           filterType;
@property (strong,nonatomic) OrderListDataConstructor  *dataConstructor;
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.type = 1;
    [self setStateView];
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
    [self.dataConstructor loadData];
}

-(void)constructData
{
    if (self.dataConstructor == nil) {
        self.dataConstructor = [[OrderListDataConstructor alloc]init];
        self.dataConstructor.delegate = self;
    }
     self.tableViewAdaptor.items = self.dataConstructor.items;
}
-(void)setStateView
{
    [self.view setBackgroundColor:kVCViewBGColor];
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
