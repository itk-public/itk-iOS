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

@interface RegisterSecondViewController()
@property (strong,nonatomic) TextFiledView *setPwdTextFiled;
@property (strong,nonatomic) TextFiledView *inputPwdTextFiled;
@property (strong,nonatomic) ThemeButton   *finishBtn;


@end
@implementation RegisterSecondViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

-(void)initView
{
    self.navTitle = @"注册";
    
    InputModel *setPwdModel = [InputModel inputModelWithIconName:nil placeStr:@"请设置密码" textFiledType:TextFiledTypeSetPwd hiddenBottomLine:NO];
    self.setPwdTextFiled = [TextFiledView textFiledViewWithInputModel:setPwdModel];
    [self.view addSubview:self.setPwdTextFiled];
    
    InputModel *inputPwdModel = [InputModel inputModelWithIconName:nil placeStr:@"确认密码" textFiledType:TextFiledTypeInputPwd hiddenBottomLine:YES];
    self.inputPwdTextFiled = [TextFiledView textFiledViewWithInputModel:inputPwdModel];
    [self.view addSubview:self.inputPwdTextFiled];
    
    self.finishBtn = [ThemeButton buttonWithType:UIButtonTypeSystem];
    [self.finishBtn setType:CustomBtnTypeGreenBg];
    [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishBtn addTarget:self action:@selector(finishBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.finishBtn];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGFloat kTopMargin = 10;
    CGFloat kTextFiledViewH = 40;
    self.setPwdTextFiled.frame = CGRectMake(0, kTopMargin, self.view.width, kTextFiledViewH);
    self.inputPwdTextFiled.frame  = CGRectMake(0, self.setPwdTextFiled.bottom, self.view.width, kTextFiledViewH);
    
    CGFloat kLeftMargin       = 15;
    self.finishBtn.frame        = CGRectMake(kLeftMargin, self.inputPwdTextFiled.bottom + 2*kTopMargin,self.view.width - 2*kLeftMargin ,36);
}

-(void)finishBtnOnClicked
{
    
}
@end
