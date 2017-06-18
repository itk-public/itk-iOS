//
//  ShopHomeShopInfoView.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeShopInfoView.h"
#import "AutoImageView.h"
#import "SoyScoreView.h"

@interface ShopHomeShopInfoView()
@property (strong,nonatomic) AutoImageView *shopIcon;
@property (strong,nonatomic) UILabel *shopNameLabel;
@property (strong,nonatomic) UILabel *scorePromptLabel;
@property (strong,nonatomic) SoyScoreView *scoreView;
@property (strong,nonatomic) UIImageView *arrowImage;
//关注按钮
@property (strong,nonatomic) UIButton *attentionBtn;
//关注数
@property (strong,nonatomic) UILabel *attentionNumLabel;
@end

@implementation ShopHomeShopInfoView
-(instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor grayColor]];
        _shopIcon = [[AutoImageView alloc]init];
        [_shopIcon setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:_shopIcon];
        
        _shopNameLabel = [[UILabel alloc]init];
        [_shopNameLabel setTextColor:[UIColor whiteColor]];
        [_shopNameLabel setFont:KFontNormal(16)];
        [_shopNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_shopNameLabel];
        
        _scorePromptLabel = [[UILabel alloc]init];
        [_scorePromptLabel setTextColor:[UIColor whiteColor]];
        [_scorePromptLabel setFont:KFontNormal(12)];
        [_scorePromptLabel setText:@"综合评分"];
        [_scorePromptLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_scorePromptLabel];
        
        _scoreView = [[SoyScoreView alloc]init];
        [self addSubview:_scoreView];
        
        _arrowImage = [[UIImageView alloc]init];
        [_arrowImage setImage:[UIImage imageNamed:@"icon_arrow_right"]];
        [self addSubview:_arrowImage];
        
        _attentionBtn = [[UIButton alloc]init];
        [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_attentionBtn.titleLabel setFont:KFontNormal(12)];
        [_attentionBtn setBackgroundColor:kColorTheme];
        _attentionBtn.layer.borderColor = kColorTheme.CGColor;
        _attentionBtn.layer.borderWidth = OnePoint;
        _attentionBtn.layer.cornerRadius = 4.0;
        [_attentionBtn addTarget:self action:@selector(attentionBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_attentionBtn];
        
        _attentionNumLabel = [[UILabel alloc]init];
        [_attentionNumLabel setTextColor:[UIColor whiteColor]];
        [_attentionNumLabel setTextAlignment:NSTextAlignmentCenter];
        [_attentionNumLabel setFont:KFontNormal(12)];
        [self addSubview:_attentionNumLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShopHomeShopInfoView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    CGFloat kShopIconW  = 50;
    self.shopIcon.frame = CGRectMake(kLeftMargin, self.height - kLeftMargin - kShopIconW, kShopIconW, kShopIconW);
    
    CGFloat kAttentionBtnW = 50;
    CGFloat kAttentionBtnH = 30;
    [self.attentionNumLabel sizeToFit];
    self.attentionNumLabel.frame = CGRectMake(self.width - kLeftMargin - kAttentionBtnW,0, kAttentionBtnW,self.attentionNumLabel.height);
    self.attentionNumLabel.bottom = self.height - 5;
    
    self.attentionBtn.frame = CGRectMake(self.attentionNumLabel.left, self.attentionNumLabel.top - kAttentionBtnH, kAttentionBtnW, kAttentionBtnH);
    
    CGFloat kArrowImageW   = 10;
    CGFloat kShopNameLabelMaxW = self.attentionNumLabel.left - self.shopIcon.right - 2*kLeftMargin - kArrowImageW;
    [self.shopNameLabel sizeToFit];
    if (kShopNameLabelMaxW < self.shopNameLabel.width) {
        kShopNameLabelMaxW = self.shopNameLabel.width;
    }
    self.shopNameLabel.frame = CGRectMake(self.shopIcon.right + kLeftMargin, self.shopIcon.top, kShopNameLabelMaxW, self.shopNameLabel.height);
    
    [self.scorePromptLabel sizeToFit];
    self.scorePromptLabel.frame = CGRectMake(self.shopNameLabel.left, self.shopIcon.bottom - self.scorePromptLabel.height, self.scorePromptLabel.width, self.scorePromptLabel.height);
    CGFloat kScoreViewW = 150;
    CGFloat kScoreViewH = 20;
    self.scoreView.frame = CGRectMake(self.scorePromptLabel.right + 5, self.shopIcon.bottom - kScoreViewH, kScoreViewW, kScoreViewH);
}


-(void)tapShopHomeShopInfoView
{
    PRLOG(@"点击店铺首页的头部");
}
-(void)attentionBtnOnClicked
{
    PRLOG(@"点击关注");
}

+(CGFloat)height
{
    return 110;
}
@end
