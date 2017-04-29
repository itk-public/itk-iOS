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
#import "AgreementProtocolView.h"

#import "RegisterFirstViewController.h"

@interface QuickBtn : UIButton

@end

@implementation QuickBtn
-(instancetype)init{
    if (self = [super init]) {
        [self setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [self.titleLabel setFont:KFontNormal(12)];
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (!selected) {
        [self setBackgroundColor:UIColorFromRGB(0xdddddd)];
    }else{
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}
@end


@interface LoginViewController()
/**
 *  输入手机号码
 */
@property (strong,nonatomic) TextFiledView *phoneView;
/**
 *  密码
 */
@property (strong,nonatomic) TextFiledView *pwdView;
/**
 *  验证码
 */
@property (strong,nonatomic) TextFiledView *codeView;

/**
 *  手机快捷登录
 */
@property (strong,nonatomic) QuickBtn *phoneQuickLogin;
/**
 *  账号密码登录
 */
@property (strong,nonatomic) QuickBtn *accountLogin;

/**
 *  忘记密码
 */
@property (strong,nonatomic) UIButton *forgePwdBtn;

/**
 *  登录
 */
@property (strong,nonatomic) ThemeButton *loginBtn;
/**
 *  注册
 */
@property (strong,nonatomic) ThemeButton *registerBtn;

@property (strong,nonatomic) QuickBtn *seletedQuickBtn;
@property (strong,nonatomic) AgreementProtocolView *protocolView;



@end
@implementation LoginViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.navTitle = @"登录";
    [self initView];
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

    InputModel *phoneModel = [InputModel inputModelWithIconName:nil placeStr:@"请输入手机号" textFiledType:TextFiledTypeInputPhone hiddenBottomLine:NO];
    self.phoneView         = [TextFiledView textFiledViewWithInputModel:phoneModel];
    [self.view addSubview:self.phoneView];

    InputModel *pwdModel   = [InputModel inputModelWithIconName:nil placeStr:@"请输入密码" textFiledType:TextFiledTypeInputPwd hiddenBottomLine:YES];
    self.pwdView           = [TextFiledView textFiledViewWithInputModel:pwdModel];
    [self.view addSubview:self.pwdView];

    InputModel *codeModel  = [InputModel inputModelWithIconName:nil placeStr:@"请输入验证码" textFiledType:TextFiledTypeInputCode hiddenBottomLine:YES];
    self.codeView          = [TextFiledView textFiledViewWithInputModel:codeModel];
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
    self.forgePwdBtn.titleLabel.font = KFontNormal(12);
    [self.forgePwdBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.forgePwdBtn addTarget:self action:@selector(forgePwdBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgePwdBtn];
    
    [self quickLoginbtnOnClicked:self.phoneQuickLogin];
    self.protocolView  = [[AgreementProtocolView alloc]init];
    [self.view addSubview:self.protocolView];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat phoneQuickLoginH   = 40;
    self.phoneQuickLogin.frame = CGRectMake(0, 0, self.view.width/2.0, phoneQuickLoginH);
    self.accountLogin.frame    = CGRectMake(self.phoneQuickLogin.right, 0, self.view.width/2.0, phoneQuickLoginH);

    CGFloat textFiledViewH     = 46;
    self.phoneView.frame       = CGRectMake(0, self.phoneQuickLogin.bottom, self.view.width, textFiledViewH);
    self.pwdView.frame         = CGRectMake(0, self.phoneView.bottom, self.view.width, textFiledViewH);
    
    self.codeView.frame        = self.pwdView.frame;

    CGFloat leftMargin         = 20;
    CGFloat loginBtnTop        = 40;
    self.loginBtn.frame        = CGRectMake(leftMargin, self.pwdView.bottom + loginBtnTop, self.view.width - 2*leftMargin, textFiledViewH);
    
    CGFloat forgetBtnW         = 60;
    CGFloat forgetBtnH         = 40;
    self.forgePwdBtn.frame     = CGRectMake(0, self.pwdView.bottom, forgetBtnW, forgetBtnH);
    self.forgePwdBtn.right     = self.view.width - 15;
    
    CGFloat registerBtnTop     = 10;
    self.registerBtn.frame     = CGRectMake(self.loginBtn.left, self.loginBtn.bottom + registerBtnTop, self.loginBtn.width, self.loginBtn.height);
    
    self.protocolView.frame   = CGRectMake(15, self.registerBtn.bottom + registerBtnTop, self.view.width - 2*15, 40);
}


#pragma mark 按钮事件
/**
 *  点击快捷登录登录
*/
-(void)quickLoginbtnOnClicked:(QuickBtn *)sender
{
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
                if ([self.protocolView isSeletedProtocol]) {
                    PRLOG(@"====手机快捷登录===");
                }
            }
        }
    }else if (self.seletedQuickBtn.tag == CustomBtnTypeAccountLogin)
    if ([self.phoneView checkInputInfo]) {
        if ([self.pwdView checkInputInfo]) {
            if ([self.protocolView isSeletedProtocol]) {
                 PRLOG(@" ===账号密码登录请求===");
            }
        }
    }
}

/**
 *  注册
 */
-(void)registerBtnClicked
{
    RegisterFirstViewController *vc = [[RegisterFirstViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
