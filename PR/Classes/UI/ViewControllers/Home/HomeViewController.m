//
//  HomeViewController.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDataConstructor.h"

@interface HomeViewController ()<WTNetWorkDataConstructorDelegate>
@property (nonatomic, strong) HomeDataConstructor       * dataConstructor;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"首页";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataConstructor loadData];
}
- (void)constructData
{
    if (_dataConstructor == nil) {
        _dataConstructor          = [[HomeDataConstructor alloc] init];
        _dataConstructor.delegate = self;
        _dataConstructor.responder = self;
    }
    self.tableViewAdaptor.items = self.dataConstructor.items;
}

#pragma mark - WTNetWorkDataConstructorDelegate
- (void)dataConstructor:(id)dataConstructor didFinishLoad:(NSObject *)dataModel
{
//    [self asynDataArrived];
    [self.dataConstructor constructData];
//    [self constructData];
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

@end
