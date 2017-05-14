//
//  SubtotalView.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#define kSubtotalViewH 46
#import "SubtotalView.h"
#import "OnePixelSepView.h"

@interface SubtotalView()
@property (strong,nonatomic) UILabel *priceLabel;
@end

@implementation SubtotalView


+(instancetype)defaultView
{
    SubtotalView *view = [[SubtotalView alloc]init];
    view.frame         = CGRectMake(0, 0, ScreenWidth, kSubtotalViewH);
    return view;
}

-(instancetype)init
{
    if (self =[super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextAlignment:NSTextAlignmentRight];
        [_priceLabel setTextColor:[UIColor orangeColor]];
        [_priceLabel setFont:KFontNormal(13)];
        [_priceLabel setText:@"共1件商品 小计：￥129.00"];
        [self addSubview:_priceLabel];
        
        [self setPixelSepSet:PSRectEdgeTop];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kRightMargin = 15;
    self.priceLabel.frame = CGRectMake(kRightMargin, 0,self.width - 2*kRightMargin, self.height);
}

@end
