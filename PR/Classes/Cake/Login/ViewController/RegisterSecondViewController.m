//
//  RegisterSecondViewController.m
//  PR
//
//  Created by 黄小雪 on 12/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "RegisterSecondViewController.h"
#import "ThemeButton.h"
#import "TextFiledView.h"
#import "AgreementProtocolView.h"
#import "PRShowToastUtil.h"
#import "PRLoadingAnimation.h"
#import "UserDataManager.h"


@interface RegisterSecondViewController()<UserDataManagerDelegate>
@property (strong,nonatomic) TextFiledView *setPwdTextFiled;
@property (strong,nonatomic) TextFiledView *inputPwdTextFiled;
@property (strong,nonatomic) ThemeButton   *finishBtn;
@property (strong,nonatomic) AgreementProtocolView *protocolView;
@property (strong,nonatomic) UserDataManager *userManager;

@end
@implementation RegisterSecondViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

-(void)initView
{
    InputModel *setPwdModel = [InputModel inputModelWithIconName:@"icon_pwd" placeStr:@"请设置密码" textFiledType:TextFiledTypeSetPwd hiddenBottomLine:NO];
    self.setPwdTextFiled = [TextFiledView textFiledViewWithInputModel:setPwdModel];
    [self.view addSubview:self.setPwdTextFiled];
    
    InputModel *inputPwdModel = [InputModel inputModelWithIconName:@"icon_pwd" placeStr:@"请确认密码" textFiledType:TextFiledTypeSetPwd hiddenBottomLine:YES];
    self.inputPwdTextFiled = [TextFiledView textFiledViewWithInputModel:inputPwdModel];
    [self.view addSubview:self.inputPwdTextFiled];
    
    self.finishBtn = [ThemeButton buttonWithType:UIButtonTypeSystem];
    [self.finishBtn setType:CustomBtnTypeGreenBg];
    [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishBtn addTarget:self action:@selector(finishBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.finishBtn];
    
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
    self.setPwdTextFiled.frame = CGRectMake(0, kTopMargin, self.view.width, kTextFiledViewH);
    self.inputPwdTextFiled.frame  = CGRectMake(0, self.setPwdTextFiled.bottom, self.view.width, kTextFiledViewH);
    
    CGFloat kLeftMargin       = 20;
    self.finishBtn.frame        = CGRectMake(kLeftMargin, self.inputPwdTextFiled.bottom + 35,self.view.width - 2*kLeftMargin ,kTextFiledViewH);
    if (self.protocolView) {
         self.protocolView.frame   = CGRectMake(kLeftMargin, self.finishBtn.bottom + 15, self.view.width - 2*kLeftMargin, 20);
    }
}

-(UserDataManager *)userManager
{
    if (_userManager == nil) {
        _userManager = [[UserDataManager alloc]init];
        _userManager.delegate = self;
    }
    return _userManager;
}
-(void)finishBtnOnClicked
{
    if ([self.setPwdTextFiled checkInputInfo] && [self.inputPwdTextFiled checkInputInfo]) {
        if ([[self.setPwdTextFiled getContentString] isEqualToString:[self.inputPwdTextFiled getContentString]]) {
            if ([self.protocolView isSeletedProtocol]) {
                [self goRequest];
            }
        }else{
            [PRShowToastUtil showNotice:@"两次密码输入不一致，请重新输入"];
        }
    }
}

-(void)goRequest
{
     [[PRLoadingAnimation sharedInstance]addLoadingAnimationOnView:self.view];
    if (self.type == LoginViewControllerTypeRegister) {
        [self.userManager registerWithPhoneNum:self.phoneNum safetyCode:self.safetyCode pwd:[self.setPwdTextFiled getContentString]];
    }else if (self.type == LoginViewControllerTypeForgotPwd){
       [self.userManager forgetPwdWithPhoneNum:self.phoneNum safetyCode:self.safetyCode pwd:[self.setPwdTextFiled getContentString]];
    }
}
#pragma mark UserDataManagerDelegate
-(void)loadDataSuccessful:(UserDataManager *)manager dataType:(UserDataManangerType)dataType  data:(id)data  isCache:(BOOL)isCache
{
     [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    if (dataType == UserDataManangerTypeRegister) {
        [PRShowToastUtil showNotice:@"注册成功"];
    }else if (dataType == UserDataManangerTypeForgetPwd){
         [PRShowToastUtil showNotice:@"修改密码成功"];
    }
}

-(void)loadDataFailed:(UserDataManager *)manager dataType:(UserDataManangerType)dataType error:(NSError*)error
{
     [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    [PRShowToastUtil showNotice:error.localizedDescription];
}
@end
