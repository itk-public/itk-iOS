//
//  ShopHomeSingleCouponView.m
//  PR
//
//  Created by 黄小雪 on 2017/6/10.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeSingleCouponView.h"
#import "AutoImageView.h"
#import "CouponModel.h"

@interface ShopHomeSingleCouponView()
//左边view的容器
@property (strong,nonatomic) UIView *leftContainer;
//￥10
@property (strong,nonatomic) UILabel *priceLabel;
//本地满80元使用
@property (strong,nonatomic) UILabel *conditionLabel;
//日期
@property (strong,nonatomic) UILabel *dateLabel;
//右边view的容器
@property (strong,nonatomic) UIView *rightContainer;
//领券
@property (strong,nonatomic) UILabel *receiveLabel;
@property (strong,nonatomic) AutoImageView *imageView;
@property (strong,nonatomic) CouponModel *coupon;
@end

@implementation ShopHomeSingleCouponView
-(instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor grayColor]];
        
        _leftContainer = [[UIView alloc]init];
        [self addSubview:_leftContainer];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextColor:[UIColor whiteColor]];
        [_priceLabel setFont:KFontNormal(15)];
        [_priceLabel setTextAlignment:NSTextAlignmentLeft];
        [_leftContainer addSubview:_priceLabel];
        
        _conditionLabel = [[UILabel alloc]init];
        [_conditionLabel setTextColor:[UIColor whiteColor]];
        [_conditionLabel setFont:KFontNormal(12)];
        [_conditionLabel setTextAlignment:NSTextAlignmentLeft];
        [_leftContainer addSubview:_conditionLabel];
        
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setTextColor:[UIColor yellowColor]];
        [_dateLabel setFont:KFontNormal(12)];
        [_dateLabel setTextAlignment:NSTextAlignmentLeft];
        [_leftContainer addSubview:_dateLabel];
        
        _imageView = [[AutoImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:_imageView];
        
        _rightContainer = [[UIView alloc]init];
        [self addSubview:_rightContainer];
        
        _receiveLabel = [[UILabel alloc]init];
        _receiveLabel.numberOfLines = 2;
        [_receiveLabel setText:@"领 \n取"];
        [_receiveLabel setTextAlignment:NSTextAlignmentCenter];
        [_receiveLabel setTextColor:[UIColor whiteColor]];
        [_receiveLabel setFont:KFontNormal(12)];
        [_rightContainer addSubview:_receiveLabel];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    CGFloat kReceiveLabelW = 35;
    self.receiveLabel.frame = CGRectMake(self.width - kReceiveLabelW, 0, kReceiveLabelW, self.height);
    CGFloat kPriceLabelW    = self.width - kReceiveLabelW;
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(5, 5, kPriceLabelW, self.priceLabel.height);
    [self.conditionLabel sizeToFit];
    self.conditionLabel.frame = CGRectMake(self.priceLabel.left, self.priceLabel.bottom + 5, kPriceLabelW, self.conditionLabel.height);
    [self.dateLabel sizeToFit];
    self.dateLabel.frame  = CGRectMake(self.priceLabel.left, self.conditionLabel.bottom + 5, kPriceLabelW, self.dateLabel.height);
}

-(void)setModel:(CarouselSingleViewModel *)model
{
    CouponModel *coupon = model.data;
    [self setCoupon:coupon];
}
-(void)setCoupon:(CouponModel *)coupon
{
    CONDITION_CHECK_RETURN([coupon isKindOfClass:[CouponModel class]]);
    _coupon = coupon;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%zd",coupon.amount];
    self.conditionLabel.text = coupon.desc?:@"";
    self.dateLabel.text      = [coupon dateString];
}

+(CGFloat)height
{
    return 70;
}
@end
