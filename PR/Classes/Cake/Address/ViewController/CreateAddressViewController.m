//
//  CreateAddressViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CreateAddressViewController.h"
#import "InPutView.h"
#import "SelectBtnView.h"
#import "DetailAddressView.h"

@interface CreateAddressViewController ()
@property (strong,nonatomic) InPutView *nameInputView;
@property (strong,nonatomic) InPutView *phoneInputView;
@property (strong,nonatomic) SelectBtnView *addressView;
@property (strong,nonatomic) SelectBtnView *streetView;
@property (strong,nonatomic) DetailAddressView    *detailView;

@end

@implementation CreateAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"新建收货地址";
    self.nameInputView = [[InPutView alloc]init];
    [self.nameInputView updatePrompt:@"收货人" placeholder:@"请填写收货人"];
    [self.view addSubview:self.nameInputView];
    self.phoneInputView = [[InPutView alloc]init];
    [self.phoneInputView updatePrompt:@"联系电话" placeholder:@"请填写联系电话"];
    [self.view addSubview:self.phoneInputView];
    
    __weak typeof(self)weakSelf = self;
    self.addressView    = [[SelectBtnView alloc]init];
    [self.addressView updatePrompt:@"所在地区" type:SelectBtnViewArea];
    self.addressView.returnBlock = ^(SelectBtnViewType type) {
        [weakSelf.view endEditing:YES];
    };
    [self.view addSubview:self.addressView];
    self.streetView     = [[SelectBtnView alloc]init];
    self.streetView.returnBlock = ^(SelectBtnViewType type) {
        [weakSelf.view endEditing:YES];
    };
    [self.streetView updatePrompt:@"街道" type:SelectBtnViewStreet];
    [self.view addSubview:self.streetView];
    
    self.detailView = [[DetailAddressView alloc]init];
    [self.view addSubview:self.detailView];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat kInputViewH   = 46;
    self.nameInputView.frame = CGRectMake(0, 15, self.view.width, kInputViewH);
    self.phoneInputView.frame = CGRectMake(0, self.nameInputView.bottom, self.view.width, kInputViewH);
    self.addressView.frame   = CGRectMake(0, self.phoneInputView.bottom, self.view.width, kInputViewH);
    self.streetView.frame   = CGRectMake(0, self.addressView.bottom, self.view.width, kInputViewH);
    self.detailView.frame   = CGRectMake(0, self.streetView.bottom, self.view.width, 99);
}

@end
