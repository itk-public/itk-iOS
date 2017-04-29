//
//  HomeCouponCell.m
//  PR
//
//  Created by 黄小雪 on 06/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "HomeCouponCell.h"
#import "DMExhibitItem.h"
#import "AutoImageView.h"
#import "DynamicUIModel.h"

@interface HomeCouponCell()

@property (strong,nonatomic) AutoImageView *iconImage;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UIImageView *arrowImage;

@end

@implementation HomeCouponCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconImage = [[AutoImageView alloc]init];
        [_iconImage setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:_iconImage];
        
        _arrowImage = [[UIImageView alloc]init];
        [_arrowImage setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:_arrowImage];
        
        _titleLabel = [[UILabel alloc]init];
//        [_titleLabel setText:@"15元店铺优惠券"];
        [_titleLabel setFont:KFontNormal(14)];
        [_titleLabel setTextColor:kColorGray];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    CGFloat kIconImageW = 15;
    CGFloat kIconImageH = 12;
    self.iconImage.frame = CGRectMake(kLeftMargin, (self.height - kIconImageH)/2.0, kIconImageW, kIconImageH);
    self.arrowImage.frame = CGRectMake(0, 0, 6, 12);
    self.arrowImage.right = self.width - kLeftMargin;
    self.arrowImage.centerY = self.height/2.0;
    
    CGFloat kTitleLabelW = self.arrowImage.left - self.iconImage.right - 20;
    self.titleLabel.frame = CGRectMake(self.iconImage.right + 10, 0, kTitleLabelW, self.height);
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[DynamicCardItem class]]);
    DynamicCardItem *cardItem = object;
    DMExhibitItem *item = cardItem.data;
    [_iconImage setImgInfo:item.imgInfo];
    [_titleLabel setText:item.title];
    
}
@end
