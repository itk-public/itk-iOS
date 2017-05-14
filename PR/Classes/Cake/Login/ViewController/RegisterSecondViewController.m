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

@interface RegisterSecondViewController()
@property (strong,nonatomic) TextFiledView *setPwdTextFiled;
@property (strong,nonatomic) TextFiledView *inputPwdTextFiled;
@property (strong,nonatomic) ThemeButton   *finishBtn;
@property (strong,nonatomic) AgreementProtocolView *protocolView;



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

-(void)finishBtnOnClicked
{
    
}
@end
