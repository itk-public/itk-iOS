//
//  LoginViewController.m
//  PR
//
//  Created by 黄小雪 on 09/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "LoginViewController.h"
#import "ThemeButton.h"
#import "TextFiledView.h"
#import "RegisterFirstViewController.h"
#import "UserDataManager.h"
#import "QuickBtn.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"

@interface LoginViewController()<UserDataManagerDelegate,TextFiledViewDelegate>
@property (strong,nonatomic) TextFiledView *phoneView;
@property (strong,nonatomic) TextFiledView *pwdView;
@property (strong,nonatomic) TextFiledView *codeView;
@property (strong,nonatomic) QuickBtn *phoneQuickLogin;
@property (strong,nonatomic) QuickBtn *accountLogin;
@property (strong,nonatomic) UIButton *forgePwdBtn;
@property (strong,nonatomic) ThemeButton *loginBtn;
@property (strong,nonatomic) ThemeButton *registerBtn;
@property (strong,nonatomic) QuickBtn *seletedQuickBtn;
@property (strong,nonatomic) UIView   *grayView;
@property (strong,nonatomic) RegisterFirstViewController *registerVC;
@property (strong,nonatomic) RegisterFirstViewController *forgetPwdVC;
@property (strong,nonatomic) UserDataManager *userManager;

@end
@implementation LoginViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.navTitle = @"登录";
    [self initView];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat phoneQuickLoginH   = 40;
    self.phoneQuickLogin.frame = CGRectMake(0, 0, self.view.width/2.0, phoneQuickLoginH);
    self.accountLogin.frame    = CGRectMake(self.phoneQuickLogin.right, 0, self.view.width/2.0, phoneQuickLoginH);
    
    self.grayView.frame        = CGRectMake(0, self.phoneQuickLogin.bottom, self.view.width, 15);

    CGFloat textFiledViewH     = 45;
    self.phoneView.frame       = CGRectMake(0, self.grayView.bottom, self.view.width, textFiledViewH);
    self.pwdView.frame         = CGRectMake(0, self.phoneView.bottom, self.view.width, textFiledViewH);
    
    self.codeView.frame        = self.pwdView.frame;

    CGFloat leftMargin         = 20;
    CGFloat loginBtnTop        = 45;
    self.loginBtn.frame        = CGRectMake(leftMargin, self.pwdView.bottom + loginBtnTop, self.view.width - 2*leftMargin, textFiledViewH);
    
    CGFloat forgetBtnW         = 80;
    CGFloat forgetBtnH         = 40;
    self.forgePwdBtn.frame     = CGRectMake(0, self.pwdView.bottom, forgetBtnW, forgetBtnH);
    self.forgePwdBtn.right     = self.view.width - leftMargin;
    
    CGFloat registerBtnTop     = 10;
    self.registerBtn.frame     = CGRectMake(self.loginBtn.left, self.loginBtn.bottom + registerBtnTop, self.loginBtn.width, self.loginBtn.height);
}


-(void)initView
{
    self.phoneQuickLogin   = [[QuickBtn alloc]init];
    [self.phoneQuickLogin setTitle:@"手机快捷登录" forState:UIControlStateNormal];
    self.phoneQuickLogin.tag = CustomBtnTypePhoneQuickLogin;
    [self.phoneQuickLogin addTarget:self action:@selector(quickLoginbtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.phoneQuickLogin];
    
    self.accountLogin      = [[QuickBtn alloc]init];
    [self.accountLogin setTitle:@"账号密码登录" forState:UIControlStateNormal];
    self.accountLogin.tag  = CustomBtnTypeAccountLogin;
    [self.accountLogin addTarget:self action:@selector(quickLoginbtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.accountLogin];
    
    InputModel *phoneModel = [InputModel inputModelWithIconName:@"icon_account" placeStr:@"请输入手机号" textFiledType:TextFiledTypeInputPhone hiddenBottomLine:NO];
    self.phoneView         = [TextFiledView textFiledViewWithInputModel:phoneModel];
    [self.view addSubview:self.phoneView];
    
    InputModel *pwdModel   = [InputModel inputModelWithIconName:@"icon_pwd" placeStr:@"请输入密码" textFiledType:TextFiledTypeInputPwd hiddenBottomLine:YES];
    self.pwdView           = [TextFiledView textFiledViewWithInputModel:pwdModel];
    [self.view addSubview:self.pwdView];
    
    InputModel *codeModel  = [InputModel inputModelWithIconName:@"icon_safety_code" placeStr:@"请输入验证码" textFiledType:TextFiledTypeInputCode hiddenBottomLine:YES];
    self.codeView          = [TextFiledView textFiledViewWithInputModel:codeModel];
    self.codeView.delegate = self;
    [self.view addSubview:self.codeView];
    
    self.loginBtn          = [ThemeButton buttonWithType:UIButtonTypeSystem];
    [self.loginBtn setType:CustomBtnTypeGreenBg];
    [self.loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    
    self.registerBtn          = [ThemeButton buttonWithType:UIButtonTypeSystem];
    [self.registerBtn setType:CustomBtnTypeWhiteBg];
    [self.registerBtn addTarget:self action:@selector(registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:self.registerBtn];
    
    
    self.forgePwdBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.forgePwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    self.forgePwdBtn.titleLabel.font = KFontNormal(14);
    self.forgePwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.forgePwdBtn setTitleColor:UIColorFromRGB(0x959595) forState:UIControlStateNormal];
    [self.forgePwdBtn addTarget:self action:@selector(forgePwdBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgePwdBtn];
    
    [self quickLoginbtnOnClicked:self.phoneQuickLogin];
    
    self.grayView = [[UIView alloc]init];
    [self.grayView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.grayView];
}


#pragma mark 按钮事件
/**
 *  点击快捷登录登录
*/
-(void)quickLoginbtnOnClicked:(QuickBtn *)sender
{
    if (self.seletedQuickBtn == nil) {
        self.seletedQuickBtn = self.accountLogin;
    }
    self.seletedQuickBtn.selected = NO;
    self.seletedQuickBtn          = sender;
    self.seletedQuickBtn.selected = YES;
    if (sender.tag == CustomBtnTypePhoneQuickLogin) {
        self.codeView.hidden    = NO;
        self.pwdView.hidden     = YES;
        self.forgePwdBtn.hidden = YES;
    }else{
        self.codeView.hidden    = YES;
        self.pwdView.hidden     = NO;
        self.forgePwdBtn.hidden = NO;
    }
}

/**
 *  忘记密码
 */
-(void)forgePwdBtnOnClicked
{
    if (self.forgetPwdVC == nil) {
        self.forgetPwdVC = [[RegisterFirstViewController alloc]init];
        self.forgetPwdVC.type = LoginViewControllerTypeForgotPwd;
    }
    [self.navigationController pushViewController:self.forgetPwdVC animated:YES];
}

/**
 *  登录
 */
-(void)loginBtnClicked
{
    [self.view endEditing:YES];
    if (self.seletedQuickBtn.tag == CustomBtnTypePhoneQuickLogin) {
        if ([self.phoneView checkInputInfo]) {
            if ([self.codeView checkInputInfo]) {
                [[PRLoadingAnimation sharedInstance] addLoadingAnimationOnView:self.view];
                [self.userManager loginWithPhoneNum:[self.phoneView getContentString] safetyCode:[self.codeView getContentString]];
            }
        }
    }else if (self.seletedQuickBtn.tag == CustomBtnTypeAccountLogin){
        if ([self.phoneView checkInputInfo]) {
            if ([self.pwdView checkInputInfo]) {
                [[PRLoadingAnimation sharedInstance] addLoadingAnimationOnView:self.view];
                [self.userManager loginWithAccout:[self.phoneView getContentString] pwd:[self.pwdView getContentString]];
            }
        }
    }
}

/**
 *  注册
 */
-(void)registerBtnClicked
{
    if (self.registerVC == nil) {
        self.registerVC = [[RegisterFirstViewController alloc]init];
        self.registerVC.type = LoginViewControllerTypeRegister;
    }
    [self.navigationController pushViewController:self.registerVC animated:YES];
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

#pragma mark  TextFiledViewDelegate
-(void)securityCodeBtnOnClicked
{
    if ([self.phoneView checkInputInfo]) {
        [self.codeView timeOut];
        [[PRLoadingAnimation sharedInstance] addLoadingAnimationOnView:self.view];
        [self.userManager securityCodeWithPhoneNum:[self.phoneView getContentString]];
    }
}
#pragma mark userDataManger
-(void)loadDataSuccessful:(UserDataManager *)manager dataType:(UserDataManangerType)dataType  data:(id)data  isCache:(BOOL)isCache
{
     [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    if (dataType == UserDataManangerTypePhoneQuickLogin || dataType == UserDataManangerTypeAccoutLogin) {
        NSLog(@"登录成功");
    }else if (dataType == UserDataManangerTypeSafetyCode){
        [PRShowToastUtil showNotice:@"获取验证码成功"];
    }
}

-(void)loadDataFailed:(UserDataManager *)manager dataType:(UserDataManangerType)dataType error:(NSError*)error
{
    [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    NSLog(@"登录失败");
}
@end
