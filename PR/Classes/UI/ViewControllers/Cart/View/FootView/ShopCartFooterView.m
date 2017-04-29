//
//  ShopCartFooterView.m
//  PR
//
//  Created by 黄小雪 on 19/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ShopCartFooterView.h"
#import "ThemeButton.h"

@interface ShopCartFooterView()
@property (strong,nonatomic) UIButton      *seletedBtn;
@property (strong,nonatomic) UILabel       *promptLabel;
@property (strong,nonatomic) UILabel       *priceLabel;
@property (strong,nonatomic) ThemeButton   *submitBtn;


@end
@implementation ShopCartFooterView
-(instancetype)init{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _seletedBtn         = [UIButton  buttonWithType:UIButtonTypeCustom];
        [_seletedBtn setImage:[UIImage imageNamed:@"icon_radio_normal"]forState:UIControlStateNormal];
        [_seletedBtn setImage:[UIImage imageNamed:@"icon_radio_selected"] forState:UIControlStateSelected];
        [_seletedBtn setImage: [UIImage imageNamed:@"icon_radio_disable"] forState:UIControlStateDisabled];
        [_seletedBtn addTarget:self action:@selector(seletedBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_seletedBtn];
        
        _promptLabel = [[UILabel alloc]init];
        [_promptLabel setTextColor:kColorNormal];
        [_promptLabel setFont:KFontNormal(14)];
        [_promptLabel setText:@"全选"];
        [_promptLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_promptLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_priceLabel];
        
        _submitBtn = [ThemeButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setType:CustomBtnTypeGreenBg];
        [_submitBtn setTitle:@"结算" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_submitBtn];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat seletedBtnW      = 25;
    self.seletedBtn.frame    = CGRectMake(15, 0, seletedBtnW, self.height);
    
    self.promptLabel.frame   = CGRectMake(self.seletedBtn.right + 5, 0, 40, self.height);
    
    CGFloat kSubmitBtnW      = 80;
    self.submitBtn.frame     = CGRectMake(self.width - kSubmitBtnW, 0, kSubmitBtnW, self.height);
    CGFloat kPriceLabelW     = self.submitBtn.left - self.promptLabel.right - 10;
    self.priceLabel.frame    = CGRectMake(self.promptLabel.right + 5, 0, kPriceLabelW, self.height);
}

-(void)seletedBtnOnClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

-(void)submitBtnOnClick
{
    
}
@end
