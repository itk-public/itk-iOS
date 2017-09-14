//
//  AccountBalanceViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/9/12.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "AccountBalanceViewController.h"
#import "ConsumptionDetailViewController.h"
#import "SceneMananger.h"

@interface AccountBalanceViewController ()
@property (strong,nonatomic) UIView *blueView;
@property (strong,nonatomic) UILabel *balanceLabel;
@property (strong,nonatomic) UIButton *cashBtn;
@property (strong,nonatomic) UIButton *rechargeBtn;
@property (strong,nonatomic) UILabel *promptLabel;
@property (strong,nonatomic) ConsumptionDetailViewController *detailVC;

@end

@implementation AccountBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"账户余额";
    [self addRightBtn];
    [self.view setBackgroundColor:kVCViewBGColor];
    [self.view addSubview:self.blueView];
    [self.view addSubview:self.cashBtn];
    [self.view addSubview:self.rechargeBtn];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x169ae3);
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.blueView.frame = CGRectMake(0, 0, self.view.width, 160);
    CGFloat kLeftMargin = 15;
    [self.promptLabel sizeToFit];
    self.promptLabel.frame = CGRectMake(kLeftMargin, kLeftMargin,self.promptLabel.width,self.promptLabel.height);
    [self.balanceLabel sizeToFit];
    self.balanceLabel.frame = CGRectMake(kLeftMargin, self.promptLabel.bottom + 35, self.balanceLabel.width, self.balanceLabel.height);
    
    self.cashBtn.frame = CGRectMake(20, self.blueView.bottom + 35, self.view.width - 40, 45);
    self.rechargeBtn.frame = CGRectMake(20, self.cashBtn.bottom + 15, self.cashBtn.width, 45);
}
-(UIView *)blueView
{
    if (_blueView == nil) {
        _blueView = [[UIView alloc]init];
        [_blueView setBackgroundColor:UIColorFromRGB(0x169ae3)];
        
        UILabel *promptLabel = [[UILabel alloc]init];
        [promptLabel setText:@"当前余额（元）"];
        [promptLabel setFont:KFontNormal(12)];
        [promptLabel setTextColor:[UIColor whiteColor]];
        [promptLabel setTextAlignment:NSTextAlignmentLeft];
        [_blueView addSubview:promptLabel];
        self.promptLabel = promptLabel;
        
        _balanceLabel = [[UILabel alloc]init];
        [_balanceLabel  setTextAlignment:NSTextAlignmentLeft];
        [_balanceLabel setFont:KFontBold(60)];
        [_balanceLabel setTextColor:[UIColor whiteColor]];
        [_balanceLabel setText:@"102.50"];
        [_blueView addSubview:_balanceLabel];
        
    }
    return _blueView;
}

-(UIButton *)cashBtn{
    if (_cashBtn == nil) {
        _cashBtn = [[UIButton alloc]init];
        [_cashBtn setBackgroundColor:kColorTheme];
        [_cashBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_cashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cashBtn.layer.borderColor = kColorTheme.CGColor;
        _cashBtn.layer.borderWidth = OnePoint;
        _cashBtn.layer.cornerRadius = 4.0;
        [_cashBtn addTarget:self action:@selector(cashBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cashBtn];
    }
    return _cashBtn;
}

-(UIButton *)rechargeBtn
{
    if (_rechargeBtn == nil) {
        _rechargeBtn = [[UIButton alloc]init];
        [_rechargeBtn setBackgroundColor:[UIColor whiteColor]];
        [_rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:UIColorFromRGB(0x4c4c4c) forState:UIControlStateNormal];
        _rechargeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _rechargeBtn.layer.borderWidth = OnePoint;
        _rechargeBtn.layer.cornerRadius = 4.0;
        [_rechargeBtn addTarget:self action:@selector(rechargeBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_rechargeBtn];
    }
    return _rechargeBtn;
}

-(void)addRightBtn
{
    UIButton *rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitle:@"明细" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:KFontNormal(16)];
    [rightBtn addTarget:self action:@selector(rightBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

-(void)rightBtnOnClicked
{
    if (self.detailVC == nil) {
        self.detailVC = [[ConsumptionDetailViewController alloc]init];
    }
    [[SceneMananger sharedInstance]showViewController:self.detailVC withStyle:U_SCENE_SHOW_PUSH];
}

-(void)cashBtnOnClicked
{
    
}

-(void)rechargeBtnOnClicked
{
    
}
@end
