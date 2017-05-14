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

@interface UserCenterViewController ()
@property (strong,nonatomic) UserCenterDataConstructor *dataConstructor;

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"个人中心";
    
    [self constructData];
    [self.tableView reloadData];
}

- (void)constructData
{
    if (_dataConstructor == nil) {
        _dataConstructor          = [[UserCenterDataConstructor alloc] init];
//        _dataConstructor.delegate = self;
//        _dataConstructor.responder = self;
    }
    [self.dataConstructor constructData];
    self.tableViewAdaptor.items = self.dataConstructor.items;
}

-(void)test
{
//    [PRMBWantedOffice nativeArrestWarrant:APPURL_VIEW_IDENTIFIER_MEMBER_LOGIN param:nil];

}
@end
