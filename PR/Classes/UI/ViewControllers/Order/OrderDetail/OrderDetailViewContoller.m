//
//  OrderDetailViewContoller.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderDetailViewContoller.h"
#import "OrderDetailDataConstructor.h"

@interface OrderDetailViewContoller ()
@property (strong,nonatomic) OrderDetailDataConstructor *dataConstructor;

@end

@implementation OrderDetailViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"订单详情"];
    
    [self constructData];
    [self.tableView reloadData];
}

- (void)constructData
{
    if (_dataConstructor == nil) {
        _dataConstructor          = [[OrderDetailDataConstructor alloc] init];
    }
    [self.dataConstructor constructData];
    self.tableViewAdaptor.items = self.dataConstructor.items;
}

@end
