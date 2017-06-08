//
//  GoodDetailShopViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "GoodDetailShopViewCell.h"
#import "AutoImageView.h"
#import "ShopDescInfo.h"

@interface GoodDetailShopViewCell()
@property (strong,nonatomic) AutoImageView *shopIcon;
@property (strong,nonatomic) UILabel *shopTitleLabel;
@property (strong,nonatomic) UILabel *shopProudctNumLabel;
@property (strong,nonatomic) UILabel *goLabel;
@property (strong,nonatomic) UITapGestureRecognizer *tap;
@property (strong,nonatomic) ShopDescInfo *shopInfo;
@end

@implementation GoodDetailShopViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _shopIcon = [[AutoImageView alloc]init];
        [_shopIcon setContentMode:UIViewContentModeScaleToFill];
        [self.contentView addSubview:_shopIcon];
        
        _shopTitleLabel = [[UILabel alloc]init];
        [_shopTitleLabel setFont:KFontNormal(16)];
        [_shopTitleLabel setTextColor:kColorNormal];
        [_shopTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_shopTitleLabel];
        
        _shopProudctNumLabel = [[UILabel alloc]init];
        [_shopProudctNumLabel setFont:KFontNormal(12)];
        [_shopProudctNumLabel setTextColor:UIColorFromRGB(0x959595)];
        [_shopProudctNumLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_shopProudctNumLabel];
        
        _goLabel = [[UILabel alloc]init];
        [_goLabel setText:@"进店逛逛"];
        [_goLabel setFont:KFontNormal(12)];
        [_goLabel setTextColor:UIColorFromRGB(0x959595)];
        _goLabel.layer.borderColor = _goLabel.textColor.CGColor;
        _goLabel.layer.borderWidth = OnePoint;
        _goLabel.layer.cornerRadius = 4.0;
        [_goLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_goLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShopViewCell)];
        [self.contentView addGestureRecognizer:tap];
        self.tap = tap;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    CGFloat kShopIconW  = 40;
    self.shopIcon.frame = CGRectMake(kLeftMargin, (self.height - kShopIconW)/2.0, kShopIconW, kShopIconW);
    [self.goLabel sizeToFit];
    CGFloat kGoLabelW  = self.goLabel.width + 8;
    CGFloat kGoLabelH  = self.goLabel.height + 5;
    self.goLabel.frame = CGRectMake(self.width - kGoLabelW - kLeftMargin, (self.height - kGoLabelH )/2.0, kGoLabelW, kGoLabelH);
   
    CGFloat kShopProductNumLabelW = self.goLabel.left - self.shopIcon.right - 2*kLeftMargin;
    [self.shopTitleLabel sizeToFit];
    self.shopTitleLabel.frame = CGRectMake(self.shopIcon.right + kLeftMargin, 10, kShopProductNumLabelW, self.shopTitleLabel.height);
    
    [self.shopProudctNumLabel sizeToFit];
    self.shopProudctNumLabel.frame = CGRectMake(self.shopTitleLabel.left, self.shopIcon.bottom - self.shopProudctNumLabel.height, kShopProductNumLabelW, self.shopProudctNumLabel.height);
}


-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[ShopDescInfo class]]);
    self.shopInfo = object;
    self.shopTitleLabel.text = self.shopInfo.title?:@"";
    self.shopProudctNumLabel.text = self.shopInfo.subTitle?:@"";
    [self.shopIcon setImgInfo:self.shopInfo.icon];
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[ShopDescInfo class]], 0);
    return 70;
}

-(void)tapShopViewCell
{
    PRLOG(@"进店逛逛");
}

-(void)dealloc
{
    [self.contentView removeGestureRecognizer:self.tap];
}
@end
