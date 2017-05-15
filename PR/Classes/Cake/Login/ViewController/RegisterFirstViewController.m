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
#import "UserDataManager.h"
#import "PRShowToastUtil.h"
#import "PRLoadingAnimation.h"

@interface RegisterFirstViewController()<UserDataManagerDelegate,TextFiledViewDelegate>
@property (strong,nonatomic) TextFiledView *phoneTextFiled;
@property (strong,nonatomic) TextFiledView *codeTextFiled;
@property (strong,nonatomic) ThemeButton   *nextBtn;
@property (strong,nonatomic) AgreementProtocolView *protocolView;
@property (strong,nonatomic) RegisterSecondViewController *registerSecondVC;
@property (strong,nonatomic) UserDataManager *userManager;


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
    self.codeTextFiled.delegate = self;
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
    if ([self.phoneTextFiled checkInputInfo] && [self.codeTextFiled checkInputInfo]) {
        if (self.registerSecondVC == nil) {
            self.registerSecondVC = [[RegisterSecondViewController alloc]init];
            self.registerSecondVC.type = self.type;
        }
        self.registerSecondVC.phoneNum = [self.phoneTextFiled getContentString];
        self.registerSecondVC.safetyCode = [self.codeTextFiled getContentString];
        [self.navigationController pushViewController:self.registerSecondVC animated:YES];
    }
}

#pragma mark --getter
-(UserDataManager *)userManager
{
    if (_userManager == nil) {
        _userManager = [[UserDataManager alloc]init];
        _userManager.delegate = self;
    }
    return _userManager;
}

-(void)securityCodeBtnOnClicked
{
    if ([self.phoneTextFiled checkInputInfo]) {
        [self.codeTextFiled timeOut];
        [[PRLoadingAnimation sharedInstance] addLoadingAnimationOnView:self.view];
        [self.userManager securityCodeWithPhoneNum:[self.phoneTextFiled getContentString]];
    }
}
#pragma mark UserDataManager的代理
-(void)loadDataSuccessful:(UserDataManager *)manager dataType:(UserDataManangerType)dataType  data:(id)data  isCache:(BOOL)isCache;
{
    [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    [PRShowToastUtil showNotice:@"获取验证码成功"];

}
-(void)loadDataFailed:(UserDataManager *)manager dataType:(UserDataManangerType)dataType error:(NSError*)error
{
    [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    [PRShowToastUtil showNotice:error.localizedDescription];
}

@end
