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
        [self setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
        _shopNameLabel = [[UILabel alloc]init];
        [_shopNameLabel setFont:KFontNormal(16)];
        [_shopNameLabel setTextColor:UIColorFromRGB(0x4c4c4c)];
        [_shopNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_shopNameLabel];
        
        _promptLabel = [[UILabel alloc]init];
        [_promptLabel setTextAlignment:NSTextAlignmentCenter];
        [_promptLabel setFont:KFontNormal(14)];
        [_promptLabel setTextColor:UIColorFromRGB(0x959595)];
        [_promptLabel setText:@"领券优惠券"];
        [self addSubview:_promptLabel];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.shopNameLabel sizeToFit] ;
    [self.promptLabel sizeToFit];
    self.shopNameLabel.frame = CGRectMake(0, 8, self.width, self.shopNameLabel.height);
    self.promptLabel.frame = CGRectMake(0, 0, self.width, self.promptLabel.height);
    self.promptLabel.bottom = self.height - 8;

}
-(void)setShopName:(NSString *)shopName
{
    self.shopNameLabel.text = shopName?:@"";
}


+(CGFloat)height
{
    return 70;
}
@end
