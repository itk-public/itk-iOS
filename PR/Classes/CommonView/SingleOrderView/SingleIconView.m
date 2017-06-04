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
        [_titleLabel setFont:KFontNormal(12)];
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(0,self.height - self.titleLabel.height - 10 , self.width, self.titleLabel.height);
    CGFloat iconLabelW  = 35;
    self.iconImage.frame  = CGRectMake(0, 0, iconLabelW, iconLabelW);
    self.iconImage.centerX = self.width/2.0;
    self.iconImage.bottom = self.titleLabel.top - 10;
}

-(void)setItem:(DMExhibitItem *)item
{
    CONDITION_CHECK_RETURN([item isKindOfClass:[DMExhibitItem class]]);
    [self.titleLabel setText:item.title];
    [self.iconImage setImgInfo:item.imgInfo];
}
@end

