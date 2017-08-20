//
//  FarmMainProductViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/8/6.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "FarmMainProductViewCell.h"
#import "AutoImageView.h"
#import "ProductOutline.h"

@interface FarmMainProductViewCell()
@property (strong,nonatomic) AutoImageView *productImageView;
@property (strong,nonatomic) UIView        *backView;
@property (strong,nonatomic) UIView        *containerView;
@property (strong,nonatomic) UILabel       *titleLabel;
@property (strong,nonatomic) UILabel       *subtitleLabel;
@property (strong,nonatomic) UILabel       *priceLabel;
@end

@implementation FarmMainProductViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _productImageView = [[AutoImageView alloc]init];
        [_productImageView setBackgroundColor:[UIColor orangeColor]];
        [_containerView addSubview:_productImageView];
        [self.contentView addSubview:_productImageView];
        
        _backView = [[UIView alloc]init];
        _backView.layer.borderColor     = [UIColor whiteColor].CGColor;
        _backView.layer.borderWidth     = OnePoint;
        _backView.backgroundColor       = [UIColor clearColor];
        [self.contentView addSubview:_backView];
        
        _containerView = [[UIView alloc]init];
        [_containerView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_containerView];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:KFontNormal(14)];
        [_titleLabel setTextColor:UIColorFromRGB(0x000000)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_containerView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]init];
        _subtitleLabel.numberOfLines = 2;
        [_subtitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_subtitleLabel setFont:KFontNormal(12)];
        [_containerView addSubview:_subtitleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextAlignment:NSTextAlignmentLeft];
        [_containerView addSubview:_priceLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _productImageView.frame = CGRectMake(0, 0, self.width, self.height - 2);
    
    CGFloat kBackViewW           = 170;
    CGFloat kBackViewH           = 90;
    CGFloat kBackViewTopMargin   = 29;
    CGFloat kBackViewRightMargin = 21;
    self.backView.frame = CGRectMake(self.width - kBackViewW - kBackViewRightMargin, kBackViewTopMargin, kBackViewW, kBackViewH);
    
    CGFloat kContainerViewTopMargin   = 35;
    CGFloat kContainerViewRightMargin = 15;
    self.containerView.frame          = CGRectMake(self.width - kBackViewH - kContainerViewRightMargin, kContainerViewTopMargin, kBackViewW, kBackViewH);
    
    CGFloat kTitleLabelLeftMargin          = 10;
    CGFloat kTitleLabelRightMargin         = 7;
    CGFloat kTitleLabelTopMargin           = 5;
   
    [self.titleLabel sizeToFit];
    CGFloat kTitleLabelW                   = self.containerView.width - kTitleLabelLeftMargin - kTitleLabelRightMargin;
    self.titleLabel.frame                  = CGRectMake(kTitleLabelLeftMargin, kTitleLabelTopMargin, kTitleLabelW,self.titleLabel.height);
    
    [self.priceLabel sizeToFit];
    self.priceLabel.frame                  = CGRectMake(kTitleLabelLeftMargin, self.containerView.height - self.priceLabel.height - 7, kTitleLabelW, self.priceLabel.height);
    
    CGFloat kSubtitleLabelH                = self.priceLabel.top - self.titleLabel.bottom - 10;
    self.subtitleLabel.frame               = CGRectMake(kTitleLabelLeftMargin, self.titleLabel.bottom + 5, kTitleLabelW, kSubtitleLabelH);
}

-(void)setObject:(id)object
{
    if ([object isKindOfClass:[ProductOutline class]]) {
        ProductOutline *product = object;
        if (product.imageInfo) {
            [self.productImageView setImgInfo:product.imageInfo];
        }
        self.titleLabel.text  = product.title?:@"";
        self.subtitleLabel.text = product.subtitle?:@"";
        self.priceLabel.text = @"促销价";
    }
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 142;
}


@end
