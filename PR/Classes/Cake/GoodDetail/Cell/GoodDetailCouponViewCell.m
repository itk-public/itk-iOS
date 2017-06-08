//
//  GoodDetailCouponViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "GoodDetailCouponViewCell.h"
#import "AutoImageView.h"
#import "GoodDetailModel.h"
#import "OnePixelSepView.h"

@implementation GoodDetailCouponModel
@end

@interface GoodDetailCouponViewCell()
@property (strong,nonatomic) AutoImageView *icon;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UIImageView *arrowIcon;
@property (strong,nonatomic) NSString *action;
@end

@implementation GoodDetailCouponViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _icon = [[AutoImageView alloc]init];
        [self.contentView addSubview:_icon];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:UIColorFromRGB(0x959595)];
        [_titleLabel setFont:KFontNormal(12)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setText:@"领取优惠券"];
        [self.contentView addSubview:_titleLabel];
        
        _arrowIcon = [[UIImageView alloc]init];
        [_arrowIcon setImage:[UIImage imageNamed:@"icon_arrow_right"]];
        [self.contentView addSubview:_arrowIcon];
        
        [self.contentView setPixelSepSet:PSRectEdgeTop];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    CGFloat kIconW  = 20;
    self.icon.frame = CGRectMake(kLeftMargin, (self.height - kIconW)/2.0,kIconW, kIconW);
    
    CGFloat kArrowIconW = 6;
    CGFloat kArrowIconH = 11;
    self.arrowIcon.frame = CGRectMake(self.width - kArrowIconW - kLeftMargin, (self.height - kArrowIconH)/2.0, kArrowIconW, kArrowIconH);

    self.titleLabel.frame = CGRectMake(self.icon.right + kLeftMargin, 0, self.arrowIcon.left - self.icon.right - 2*kLeftMargin, self.height);
}

-(void)setObject:(id)object
{
    if ([object isKindOfClass:[GoodDetailCouponModel class]]) {
        GoodDetailCouponModel *model = object;
        NSDictionary *dict = model.couponDict;
        self.contentView.hidden = NO;
        NSString *iconString = [dict safeObjectForKey:couponIcon];
        [self.icon setImgURLString:iconString];
        self.action     = [dict safeObjectForKey:couponAction];
    }else{
        self.contentView.hidden = YES;
    }
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[GoodDetailCouponModel class]], 0);
    return 46;
}
@end
