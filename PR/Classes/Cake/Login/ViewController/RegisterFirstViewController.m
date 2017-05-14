//
//  RegisterViewController.m
//  PR
//
//  Created by 黄小雪 on 12/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "RegisterFirstViewController.h"
#import "ThemeButton.h"
#import "TextFiledView.h"
#import "RegisterSecondViewController.h"
#import "AgreementProtocolView.h"

@interface RegisterFirstViewController()
@property (strong,nonatomic) TextFiledView *phoneTextFiled;
@property (strong,nonatomic) TextFiledView *codeTextFiled;
@property (strong,nonatomic) ThemeButton   *nextBtn;
@property (strong,nonatomic) AgreementProtocolView *protocolView;
@property (strong,nonatomic) RegisterSecondViewController *registerSecondVC;


@end
@implementation RegisterFirstViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

-(void)initView
{
    InputModel *phoneModel = [InputModel inputModelWithIconName:@"icon_account" placeStr:@"请输入手机号" textFiledType:TextFiledTypeInputPhone hiddenBottomLine:NO];
    self.phoneTextFiled = [TextFiledView textFiledViewWithInputModel:phoneModel];
    [self.view addSubview:self.phoneTextFiled];
    
    InputModel *codeModel = [InputModel inputModelWithIconName:@"icon_safety_code" placeStr:@"请输入验证码" textFiledType:TextFiledTypeInputCode hiddenBottomLine:YES];
    self.codeTextFiled = [TextFiledView textFiledViewWithInputModel:codeModel];
    [self.view addSubview:self.codeTextFiled];
    
    self.nextBtn = [ThemeButton buttonWithType:UIButtonTypeSystem];
    [self.nextBtn setType:CustomBtnTypeGreenBg];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    
    if (self.type == LoginViewControllerTypeRegister) {
        self.navTitle = @"注册";
        self.protocolView  = [[AgreementProtocolView alloc]init];
        [self.view addSubview:self.protocolView];
    }else if (self.type == LoginViewControllerTypeForgotPwd){
        self.navTitle = @"忘记密码";
    }
    
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGFloat kTopMargin = 15;
    CGFloat kTextFiledViewH = 45;
    self.phoneTextFiled.frame = CGRectMake(0, kTopMargin, self.view.width, kTextFiledViewH);
    self.codeTextFiled.frame  = CGRectMake(0, self.phoneTextFiled.bottom, self.view.width, kTextFiledViewH);
    
    CGFloat kLeftMargin       = 20;
    self.nextBtn.frame        = CGRectMake(kLeftMargin, self.codeTextFiled.bottom + 35,self.view.width - 2*kLeftMargin ,kTextFiledViewH);
    if (self.protocolView) {
        self.protocolView.frame   = CGRectMake(kLeftMargin, self.nextBtn.bottom + 15, self.view.width - 2*kLeftMargin, 20);
    }
}

-(void)nextBtnOnClicked
{
    if (self.registerSecondVC == nil) {
        self.registerSecondVC = [[RegisterSecondViewController alloc]init];
        self.registerSecondVC.type = self.type;
    }
    [self.navigationController pushViewController:self.registerSecondVC animated:YES];
    
}
@end
