//
//  SingleOrderView.m
//  PR
//
//  Created by 黄小雪 on 14/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "SingleIconView.h"
#import "AutoImageView.h"

@interface SingleIconView()
@property (strong,nonatomic) AutoImageView        *iconImage;
@property (strong,nonatomic) UILabel              *titleLabel;

@end

@implementation SingleIconView
-(instancetype)init{
    if (self = [super init]) {
        _iconImage                    = [[AutoImageView alloc]init];
        [_iconImage setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_iconImage];
        
        _titleLabel                   = [[UILabel alloc]init];
        [_titleLabel setTextColor:kColorGray];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor whiteColor]];
        [_titleLabel setFont:KFontNormal(14)];
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat titleLabelH  = 18;
    self.titleLabel.frame = CGRectMake(0,self.height - titleLabelH , self.width, titleLabelH);
    CGFloat iconLabelW  = 35;
    self.iconImage.frame  = CGRectMake(0, 0, iconLabelW, iconLabelW);
    self.iconImage.centerX = self.width/2.0;
    self.iconImage.bottom = self.titleLabel.top;
}

-(void)setItem:(DMExhibitItem *)item
{
    CONDITION_CHECK_RETURN([item isKindOfClass:[DMExhibitItem class]]);
    [self.titleLabel setText:item.title];
    [self.iconImage setImgInfo:item.imgInfo];
    [self.iconImage setImgURLString:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1489588845&di=64735fa10c51f9329efec22e367bd4bc&src=http://pic13.nipic.com/20110419/2457331_142656838000_2.png"];
}
@end

