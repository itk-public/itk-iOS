//
//  CartViewController.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//   购物车

#import "CartViewController.h"
#import "CartDataConstructor.h"
#import "ShopCartFooterView.h"
#import "ShopCartInfo.h"
#import "CartProductInfo.h"
#import "ShopDescInfo.h"

@interface CartViewController ()<WTNetWorkDataConstructorDelegate>

@property (strong,nonatomic) CartDataConstructor *dataConstructor;
@property (strong,nonatomic) ShopCartFooterView  *footerView;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"购物车";
    [self setUpUI];
   
}

-(void)setUpUI
{
    self.footerView = [[ShopCartFooterView alloc]init];
    [self.view addSubview:self.footerView];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat kSubmitViewH = 46;
    self.footerView.frame = CGRectMake(0, self.view.height - kSubmitViewH, self.view.width, kSubmitViewH);
    self.tableView.bottom  = self.footerView.top - 10;
    self.tableView.top     = 0;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataConstructor loadData];
}
- (void)constructData
{
    if (_dataConstructor == nil) {
        _dataConstructor          = [[CartDataConstructor alloc] init];
        _dataConstructor.delegate = self;
       _dataConstructor.responder = self;
    }
    [self.dataConstructor constructData];
    self.tableViewAdaptor.items = self.dataConstructor.items;
}


#pragma mark - WTNetWorkDataConstructorDelegate
- (void)dataConstructor:(id)dataConstructor didFinishLoad:(NSObject *)dataModel
{
    //    [self asynDataArrived];
    [self.dataConstructor constructData];
    [self.tableView reloadData];
    //    if (dataModel && [dataModel isKindOfClass:[DynamicUIModel class]]) {
    //        DynamicUIModel *tModel = (DynamicUIModel *)dataModel;
    //        self.innerShopAddressStr = tModel.shopAddress?:@"";
    //        self.lbsTypeStr          = tModel.lbsTypeStr;
    //        [[NSNotificationCenter defaultCenter] postNotificationName:HomePageAddressHeadViewNeedSetDataNotification object:nil];
    //    }
    
}

- (void)dataConstructorDidFailLoadData:(id)dataConstructor withError:(NSObject *)errorDataModel
{
    //    [self reqDataError:(id)errorDataModel showTip:YES];
}

- (void)handleSignal:(MSignal *)signal
{
    if ([signal is:ShopCardEditSignal]) {
        PRLOG(@"ShopCardEditSignal");
        ShopDescInfo *shopinfo = signal.param;
        CONDITION_CHECK_RETURN([shopinfo isKindOfClass:[ShopDescInfo class]]);
        for (CartProductInfo *product in self.tableViewAdaptor.items) {
            if ([product isKindOfClass:[CartProductInfo class]]) {
                if ([product.shopid isEqualToString:shopinfo.cid]) {
                    product.isEdit = !product.isEdit;
                }
            }
        }
        [self.tableView reloadData];
    }
}
@end
