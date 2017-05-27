//
//  UserCenterViewController.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "UserCenterViewController.h"
#import "LoginViewController.h"
#import "PRMBWantedOffice.h"
#import "UserCenterDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"

@interface UserCenterViewController ()<WTNetWorkDataConstructorDelegate>
@property (strong,nonatomic) UserCenterDataConstructor *dataConstructor;

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"个人中心";
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataConstructor loadData];
    [self.tableView reloadData];
}


- (void)constructData
{
    if (_dataConstructor == nil) {
        _dataConstructor          = [[UserCenterDataConstructor alloc] init];
        _dataConstructor.delegate = self;
    }
    self.tableViewAdaptor.items = self.dataConstructor.items;
}
#pragma mark - WTNetWorkDataConstructorDelegate
- (void)dataConstructor:(id)dataConstructor didFinishLoad:(id)dataModel
{
    [[PRLoadingAnimation sharedInstance] removeLoadingAnimation:self.view];
    [self.dataConstructor constructData];
    [self.tableView reloadData];
}


- (void)dataConstructorDidFailLoadData:(id)dataConstructor withError:(NSError *)errorDataModel
{
    [[PRLoadingAnimation sharedInstance] removeLoadingAnimation:self.view];
    [PRShowToastUtil showNotice:errorDataModel.localizedDescription];
}


@end
