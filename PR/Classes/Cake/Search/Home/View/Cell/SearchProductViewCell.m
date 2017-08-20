//
//  SearchProductViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SearchProductViewCell.h"
#import "AutoImageView.h"
#import "ProductOutline.h"

@interface SearchProductViewCell()
@property (strong,nonatomic) AutoImageView *productIcon;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *priceLabel;
@property (strong,nonatomic) ProductOutline *product;
@end

@implementation SearchProductViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _productIcon = [[AutoImageView alloc]init];
        [_productIcon setContentMode: UIViewContentModeScaleAspectFill];
        [self.contentView addSubview:_productIcon];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:UIColorFromRGB(0x000000)];
        [_titleLabel setFont:KFontNormal(16)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextColor:kColorOrange];
        [_priceLabel setFont:KFontNormal(14)];
        [_priceLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_priceLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSearchProductViewCell)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    CGFloat kProductIconW = 30;
    self.productIcon.frame = CGRectMake(kLeftMargin, (self.height - kProductIconW)/2.0, kProductIconW, kProductIconW);
    
    [self.priceLabel sizeToFit];
    CGFloat kPriceLabelW = self.priceLabel.width;
    self.priceLabel.frame = CGRectMake(self.width - kPriceLabelW - kLeftMargin, 0, kPriceLabelW, self.height);
    
    CGFloat kTitleLabel  = self.priceLabel.left - self.productIcon.right - 2*kLeftMargin;
    self.titleLabel.frame = CGRectMake(self.productIcon.right + kLeftMargin, 0, kTitleLabel, self.height);
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[ProductOutline class]]);
    self.product = object;
    self.titleLabel.text = self.product.title?:@"";
    self.priceLabel.text = self.product.priceInfo.marketPrice;
    [self.productIcon setImgInfo:self.product.imageInfo];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[ProductOutline class]], 0);
    return 46;
}

-(void)tapSearchProductViewCell
{
    PRLOG(@"点击查看搜索到的商品");
//    if (self.product.action) {
//        []
//    }
}
@end
