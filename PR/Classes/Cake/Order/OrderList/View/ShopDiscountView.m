//
//  ShopDiscountView.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#define kShopDiscountViewH  46
#import "ShopDiscountView.h"
#import "OnePixelSepView.h"

@interface ShopDiscountView()

@property (strong,nonatomic) UILabel *promptLabel;
@property (strong,nonatomic) UILabel *discountLabel;
@property (strong,nonatomic) UILabel *arrowLabel;

@end
@implementation ShopDiscountView

+(instancetype)defaultView
{
   ShopDiscountView *discountView =  [[ShopDiscountView alloc]init];
    discountView.frame = CGRectMake(0, 0, ScreenWidth, kShopDiscountViewH);
    return discountView;
}
-(instancetype)init{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _promptLabel = [[UILabel alloc]init];
        [_promptLabel setText:@"店铺优惠"];
        [_promptLabel setFont:KFontNormal(14)];
        [_promptLabel setTextColor:kColorNormal];
        [_promptLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_promptLabel];
        
        _discountLabel = [[UILabel alloc]init];
        [_discountLabel setText:@"满200减50"];
        [_discountLabel setFont:KFontNormal(14)];
        [_discountLabel setTextColor:kColorNormal];
        [_discountLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_discountLabel];
        
        _arrowLabel = [[UILabel alloc]init];
        [_arrowLabel setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_arrowLabel];
        
        [self setPixelSepSet:PSRectEdgeTop];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    self.promptLabel.frame = CGRectMake(kLeftMargin, 0, 100, self.height);
    
    CGFloat arrowLabelW = 5;
    CGFloat arrowLabelH = 11;
    self.arrowLabel.frame  = CGRectMake(self.width - kLeftMargin - arrowLabelW, (self.height - arrowLabelH)/2.0, arrowLabelW, arrowLabelH);
    
    self.discountLabel.frame = CGRectMake(0, 0, self.arrowLabel.left - self.promptLabel.right-20, self.height);
    self.discountLabel.right  = self.arrowLabel.left - 10;
}
@end
