//
//  TableViewHeaderView.m
//  PR
//
//  Created by 黄小雪 on 28/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "TableViewHeaderView.h"

@interface TableViewHeaderView()
@property (strong,nonatomic) UILabel *shopNameLabel;
@property (strong,nonatomic) UILabel *promptLabel;
@end

@implementation TableViewHeaderView
-(instancetype)init{
    if (self = [super init]) {
        _shopNameLabel = [[UILabel alloc]init];
        [_shopNameLabel setText:@"xxxxx店铺"];
        [_shopNameLabel setFont:KFontNormal(18)];
        [_shopNameLabel setTextColor:kColorNormal];
        [_shopNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_shopNameLabel];
        
        _promptLabel = [[UILabel alloc]init];
        [_promptLabel setTextAlignment:NSTextAlignmentCenter];
        [_promptLabel setFont:KFontNormal(14)];
        [_promptLabel setTextColor:kColorGray];
        [_promptLabel setText:@"领券优惠券"];
        [self addSubview:_promptLabel];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kTopMargin = 10;
    CGFloat kLabelH    = (self.height - 2*kTopMargin)/2.0;
    self.shopNameLabel.frame = CGRectMake(0, kTopMargin, self.width, kLabelH);
    self.promptLabel.frame = CGRectMake(0, self.shopNameLabel.bottom, self.width, kLabelH);

}
-(void)setShopName:(NSString *)shopName
{
    self.shopNameLabel.text = shopName?:@"";
}
@end
