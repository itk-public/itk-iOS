//
//  OrderDetailViewContoller.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderDetailViewContoller.h"
#import "OrderDetailDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"

@interface OrderDetailViewContoller ()<WTNetWorkDataConstructorDelegate>
@property (strong,nonatomic) OrderDetailDataConstructor *dataConstructor;

@end

@implementation OrderDetailViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"订单详情"];
    
//    [self constructData];
//    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataConstructor loadData];
}


//-(void)constructData
//{
//    if (self.dataConstructor == nil) {
//        self.dataConstructor = [[OrderListDataConstructor alloc]init];
//        self.dataConstructor.delegate = self;
//    }
//    self.tableViewAdaptor.items = self.dataConstructor.items;
//}


- (void)constructData
{
    if (_dataConstructor == nil) {
        _dataConstructor          = [[OrderDetailDataConstructor alloc] init];
        _dataConstructor.delegate = self;
    }
    [self.dataConstructor constructData];
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
