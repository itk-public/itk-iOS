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

@interface RegisterFirstViewController()
@property (strong,nonatomic) TextFiledView *phoneTextFiled;
@property (strong,nonatomic) TextFiledView *codeTextFiled;
@property (strong,nonatomic) ThemeButton   *nextBtn;


@end
@implementation RegisterFirstViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

-(void)initView
{
    self.navTitle = @"注册";
    
    InputModel *phoneModel = [InputModel inputModelWithIconName:nil placeStr:@"请输入手机号" textFiledType:TextFiledTypeInputPhone hiddenBottomLine:NO];
    self.phoneTextFiled = [TextFiledView textFiledViewWithInputModel:phoneModel];
    [self.view addSubview:self.phoneTextFiled];
    
    InputModel *codeModel = [InputModel inputModelWithIconName:nil placeStr:@"请输入验证码" textFiledType:TextFiledTypeInputCode hiddenBottomLine:YES];
    self.codeTextFiled = [TextFiledView textFiledViewWithInputModel:codeModel];
    [self.view addSubview:self.codeTextFiled];
    
    self.nextBtn = [ThemeButton buttonWithType:UIButtonTypeSystem];
    [self.nextBtn setType:CustomBtnTypeGreenBg];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGFloat kTopMargin = 10;
    CGFloat kTextFiledViewH = 40;
    self.phoneTextFiled.frame = CGRectMake(0, kTopMargin, self.view.width, kTextFiledViewH);
    self.codeTextFiled.frame  = CGRectMake(0, self.phoneTextFiled.bottom, self.view.width, kTextFiledViewH);
    
    CGFloat kLeftMargin       = 15;
    self.nextBtn.frame        = CGRectMake(kLeftMargin, self.codeTextFiled.bottom + 2*kTopMargin,self.view.width - 2*kLeftMargin ,36);
}

-(void)nextBtnOnClicked
{
    RegisterSecondViewController *vc = [[RegisterSecondViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
