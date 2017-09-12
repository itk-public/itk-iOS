//
//  OrderSettlementProductViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/8/21.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderSettlementProductViewCell.h"
#import "AutoImageView.h"
#import "OnePixelSepView.h"
#import "ProductOutline.h"

@interface OrderSettlementProductViewCell()
@property (strong,nonatomic)AutoImageView    *productImage;
@property (strong,nonatomic) UILabel         *titleLabel;
@property (strong,nonatomic) UILabel         *subtitleLabel;
@property (strong,nonatomic) UILabel         *priceLabel;
@property (strong,nonatomic) OnePixelSepView *lineView;
@property (strong,nonatomic) UIView          *containerView;
@property (strong,nonatomic) UILabel         *numLabel;
@end

@implementation OrderSettlementProductViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:UIColorFromRGB(0xf3f4f5)];
        
        _containerView = [[UIView alloc]init];
        [_containerView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_containerView];
        
        _productImage = [[AutoImageView alloc]init];
        [self.containerView addSubview:_productImage];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:KFontNormal(14)];
        [_titleLabel setTextColor:UIColorFromRGB(0x000000)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.containerView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]init];
        [_subtitleLabel setFont:KFontNormal(12)];
        [_subtitleLabel setTextColor:UIColorFromRGB(0x929292)];
        [_subtitleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.containerView addSubview:_subtitleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setFont:KFontNormal(12)];
        [_priceLabel setTextColor:UIColorFromRGB(0x000000)];
        [_priceLabel setTextAlignment:NSTextAlignmentLeft];
        [self.containerView addSubview:_priceLabel];
        
        _numLabel = [[UILabel alloc]init];
        [_numLabel setTextAlignment:NSTextAlignmentRight];
        [_numLabel setFont:KFontNormal(12)];
        [_numLabel setTextColor:UIColorFromRGB(0x959595)];
        [self.containerView addSubview:_numLabel];
        
        [self.containerView setPixelSepSet:PSRectEdgeBottom];
        _lineView = [self.containerView psBottomSep];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kContainerViewLeftMargin = 5;
    self.containerView.frame = CGRectMake(kContainerViewLeftMargin,0, self.width - 2*kContainerViewLeftMargin, self.height);
    
    CGFloat kLeftMargin    = 10;
    CGFloat kProductImageW = 70;
    self.productImage.frame = CGRectMake(kLeftMargin, (self.height - kProductImageW)/2.0, kProductImageW, kProductImageW);
    
    CGFloat kTitleLabelLeftMargin  = 10;
    CGFloat kTitleLabelRightMargin = 42;
    CGFloat kTitleLabelTopMargin   = 10;
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(self.productImage.right + kTitleLabelLeftMargin, kTitleLabelTopMargin, self.containerView.width - self.productImage.right - kTitleLabelLeftMargin - kTitleLabelRightMargin, self.titleLabel.height);
    
    [self.subtitleLabel sizeToFit];
    CGFloat kSubtitleLabelTopMargin = 12;
    self.subtitleLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + kSubtitleLabelTopMargin , self.titleLabel.width, self.subtitleLabel.height);
    
    [self.priceLabel sizeToFit];
    self.priceLabel.frame  = CGRectMake(self.titleLabel.left, self.productImage.bottom - self.priceLabel.height, self.titleLabel.width, self.priceLabel.height);
    
    CGFloat kNumLabelRightMargin = 10;
    [self.numLabel sizeToFit];
    self.numLabel.frame = CGRectMake(self.containerView.width - kNumLabelRightMargin - self.numLabel.width, self.productImage.bottom - self.numLabel.height, self.numLabel.width, self.numLabel.height);
    
    self.lineView.left = kLeftMargin;
    self.lineView.width = self.containerView.width - kLeftMargin
    ;
}

-(void)setObject:(id)object
{
    if ([object isKindOfClass:[ProductOutline class]]) {
        ProductOutline *product = object;
        [self.productImage setImgInfo:product.imageInfo];
        self.titleLabel.text    = product.title?:@"";
        self.subtitleLabel.text = product.subtitle?:@"";
        self.numLabel.text      = [NSString stringWithFormat:@"x%zd",product.num];
        self.priceLabel.text    = [NSString stringWithFormat:@"￥%@", product.priceInfo.marketPrice];
        
    }
}
+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 90;
}
@end
