//
//  SearchShopViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SearchShopViewCell.h"
#import "AutoImageView.h"
#import "OnePixelSepView.h"
#import "SearchShopDescInfo.h"
#import "PRMBWantedOffice.h"

@interface SearchShopViewCell()
@property (strong,nonatomic) AutoImageView *shopIcon;
@property (strong,nonatomic) UILabel *shopNameLabel;
//xxx专达
@property (strong,nonatomic) UILabel *expressLabel;
//40分钟
@property (strong,nonatomic) UILabel *timeLabel;
@end

@implementation SearchShopViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        _shopIcon = [[AutoImageView alloc]init];
        [_shopIcon setContentMode:UIViewContentModeScaleAspectFill];
        [self.contentView addSubview:_shopIcon];
        
        _shopNameLabel = [[UILabel alloc]init];
        [_shopNameLabel setTextColor:UIColorFromRGB(0x333333)];
        [_shopNameLabel setFont:KFontNormal(16)];
        [_shopNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_shopNameLabel];
        
        _expressLabel = [[UILabel alloc]init];
        [_expressLabel setTextColor:UIColorFromRGB(0x959595)];
        [_expressLabel setFont:KFontNormal(16)];
        [_expressLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_expressLabel];
        
        _timeLabel = [[UILabel alloc]init];
        [_timeLabel setTextColor:UIColorFromRGB(0x959595)];
        [_timeLabel setTextAlignment:NSTextAlignmentLeft];
        [_timeLabel setFont:KFontNormal(16)];
        [self.contentView addSubview:_timeLabel];
        
        [self.contentView setPixelSepSet:PSRectEdgeBottom];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSearchShopViewCell)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    CGFloat kShopIconW  = 50;
    self.shopIcon.frame = CGRectMake(kLeftMargin, (self.height - kShopIconW)/2.0, kShopIconW, kShopIconW);
    CGFloat kShopNameLabelW = self.width - self.shopIcon.right - 2*kLeftMargin;
    [self.shopNameLabel sizeToFit];
    self.shopNameLabel.frame = CGRectMake(self.shopIcon.right + kLeftMargin, self.shopIcon.top, kShopNameLabelW, self.shopNameLabel.height);
    
    [self.expressLabel sizeToFit];
    self.expressLabel.frame = CGRectMake(self.shopNameLabel.left, self.shopIcon.bottom - self.expressLabel.height, self.expressLabel.width, self.expressLabel.height);
    
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(self.expressLabel.right + 10, 0, self.timeLabel.width, self.timeLabel.height);
    self.timeLabel.centerY = self.expressLabel.centerY;
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[SearchShopDescInfo class]]);
    SearchShopDescInfo *shopInfo = object;
    [self.shopIcon setImgInfo:shopInfo.icon];
    self.shopNameLabel.text = shopInfo.shopname?:@"";
    self.expressLabel.text  = shopInfo.allocationType?:@"";
    self.timeLabel.text     = shopInfo.deliveryTimeStr?:@"";
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[SearchShopDescInfo class]], 0);
    return 75;
}

-(void)tapSearchShopViewCell
{
    [PRMBWantedOffice nativeArrestWarrant:APPURL_VIEW_IDENTIFIER_SHOPHOME param:nil];
}
@end
