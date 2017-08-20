//
//  FarmSearchProudctHeaderView.m
//  PR
//
//  Created by 黄小雪 on 2017/8/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "FarmSearchProudctHeaderView.h"

@interface FarmSearchProudctHeaderView()
//综合
@property (strong,nonatomic)  UIButton *comprehensiveBtn;
//销量优先
@property (strong,nonatomic)  UIButton *salesBtn;
//价格
@property (strong,nonatomic)  UIButton *priceBtn;

//选中的按钮
@property (strong,nonatomic)  UIButton *seletedBtn;

@end

@implementation FarmSearchProudctHeaderView
-(instancetype)init
{
    if (self = [super init]) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        _comprehensiveBtn = [[UIButton alloc]init];
        [_comprehensiveBtn setTitle:@"综合" forState:UIControlStateNormal];
        [_comprehensiveBtn setTitleColor:UIColorFromRGB(0x1ad2c5) forState:UIControlStateSelected];
        [_comprehensiveBtn setTitleColor:UIColorFromRGB(0x959595) forState:UIControlStateNormal];
        [_comprehensiveBtn.titleLabel setFont:KFontNormal(14)];
        _comprehensiveBtn.tag = FarmSearchBtnTypeComprehensive;
        [_comprehensiveBtn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _comprehensiveBtn.selected = YES;
        [self addSubview:_comprehensiveBtn];
        
        _salesBtn = [[UIButton alloc]init];
        [_salesBtn setTitle:@"销量优先" forState:UIControlStateNormal];
        [_salesBtn setTitleColor:UIColorFromRGB(0x1ad2c5) forState:UIControlStateSelected];
        [_salesBtn setTitleColor:UIColorFromRGB(0x959595) forState:UIControlStateNormal];
        [_salesBtn.titleLabel setFont:KFontNormal(14)];
        _salesBtn.selected = NO;
        _salesBtn.tag = FarmSearchBtnTypeSales;
        [_salesBtn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_salesBtn];
        
        _priceBtn = [[UIButton alloc]init];
        [_priceBtn setTitle:@"价格" forState:UIControlStateNormal];
        [_priceBtn setTitleColor:UIColorFromRGB(0x1ad2c5) forState:UIControlStateSelected];
        [_priceBtn setTitleColor:UIColorFromRGB(0x959595) forState:UIControlStateNormal];
        [_priceBtn.titleLabel setFont:KFontNormal(14)];
        _priceBtn.selected = NO;
        [_priceBtn addTarget:self action:@selector(priceBtnBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_priceBtn];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kBtnW = self.width/3.0;
    self.comprehensiveBtn.frame = CGRectMake(0, 0, kBtnW, self.height);
    self.salesBtn.frame         = CGRectMake(self.comprehensiveBtn.right, 0, kBtnW, self.height);
    self.priceBtn.frame         = CGRectMake(self.salesBtn.right, 0, kBtnW, self.height);
    
}
-(void)setComprehensiveHighlighted
{
    [self btnOnClicked:self.comprehensiveBtn];
}

+(CGFloat)getHeight
{
    return 46;
}


-(void)btnOnClicked:(UIButton *)sender
{
    if (sender == self.seletedBtn) {
        return;
    }
    self.seletedBtn.selected = NO;
    sender.selected          = YES;
    self.seletedBtn          = sender;
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(farmSearchProudctHeaderViewDidSelectedBtnType:)]) {
        [self.delegate farmSearchProudctHeaderViewDidSelectedBtnType:sender.tag];
    }
}


-(void)priceBtnBtnOnClicked:(UIButton *)sender
{
    if(sender != self.seletedBtn){
        self.seletedBtn.selected = NO;
    }
    sender.selected          = !sender.isSelected;
    self.seletedBtn          = sender;
    FarmSearchBtnType type   = sender.isSelected?FarmSearchBtnTypePriceRise: FarmSearchBtnTypePriceReduce;
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(farmSearchProudctHeaderViewDidSelectedBtnType:)]) {
        [self.delegate farmSearchProudctHeaderViewDidSelectedBtnType:type];
    }
    
}
@end
