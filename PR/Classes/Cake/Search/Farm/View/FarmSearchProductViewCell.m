//
//  FarmSearchProductViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/8/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "FarmSearchProductViewCell.h"
#import "AutoImageView.h"
#import "ProductOutline.h"

@interface FarmSearchProductViewCell()
@property (strong,nonatomic) AutoImageView *markImage;
@property (strong,nonatomic) AutoImageView *productImage;
@property (strong,nonatomic) UILabel       *titleLabel;
@property (strong,nonatomic) UILabel       *subtitleLabel;
@property (strong,nonatomic) UILabel       *priceLabel;
@property (strong,nonatomic) UIButton      *cartBtn;
@property (strong,nonatomic) UIView        *containerView;
@property (strong,nonatomic) ProductOutline *product;
@end

@implementation FarmSearchProductViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _containerView = [[UIView alloc]init];
        [_containerView setBackgroundColor:[UIColor whiteColor]];
        _containerView.layer.cornerRadius = 4.0;
        _containerView.layer.borderColor  = [UIColor whiteColor].CGColor;
        _containerView.layer.borderWidth  = OnePoint;
        _containerView.layer.shadowColor  = UIColorFromRGB(0x999999).CGColor;
        _containerView.layer.shadowOpacity = 0.3f;
        _containerView.layer.shadowRadius = 4.0f;
        _containerView.layer.shadowOffset = CGSizeMake(0, 0);
        [self.contentView addSubview:_containerView];
        
        _markImage = [[AutoImageView alloc]init];
        [_markImage setBackgroundColor:[UIColor grayColor]];
        [self.containerView addSubview:_markImage];
        
        _productImage = [[AutoImageView alloc]init];
        [_productImage setContentMode:UIViewContentModeScaleAspectFit];
        [self.containerView addSubview:_productImage];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setFont:KFontNormal(14)];
        [_titleLabel setTextColor:UIColorFromRGB(0x000000)];
        [self.containerView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]init];
        [_subtitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_subtitleLabel setFont:KFontNormal(12)];
        [_subtitleLabel setTextColor:UIColorFromRGB(0x7e7e7e)];
        [self.containerView addSubview:_subtitleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextAlignment:NSTextAlignmentLeft];
        [_priceLabel setFont:KFontNormal(12)];
        [_priceLabel setTextColor:UIColorFromRGB(0x7e7e7e)];
        [self.containerView addSubview:_priceLabel];
        
        _cartBtn = [[UIButton alloc]init];
        [_cartBtn setBackgroundColor:[UIColor redColor]];
        [_cartBtn addTarget:self action:@selector(cartBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:_cartBtn];
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.containerView bringSubviewToFront:_markImage];
    }
    return self;
}

-(void)layoutSubviews
{
    CGFloat kContainerViewBottomMargin = 10;
    CGFloat kContainerViewTopMargin    = 2;
    self.containerView.frame = CGRectMake(kContainerViewBottomMargin, kContainerViewTopMargin, self.width - 2*kContainerViewBottomMargin, self.height - kContainerViewBottomMargin - kContainerViewTopMargin);
    CGFloat kMarkImageW      = 28;
    self.markImage.frame     = CGRectMake(2, 0, kMarkImageW, kMarkImageW);
    
    CGFloat kProductImageW          = 70;
    CGFloat kProductImageH          = 62;
    CGFloat kProductImageLeftMargin = 20;
    self.productImage.frame         = CGRectMake(kProductImageLeftMargin, (self.containerView.height - kProductImageH)/2.0, kProductImageW, kProductImageH);
    
    CGFloat kTitleLabelLeftMargin   = 10;
    [self.titleLabel sizeToFit];
    self.titleLabel.frame           = CGRectMake(self.productImage.right + kTitleLabelLeftMargin, 7, self.containerView.width- self.productImage.right - 2*kTitleLabelLeftMargin, self.titleLabel.height);

    [self.subtitleLabel sizeToFit];
    self.subtitleLabel.frame        = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + 5, self.titleLabel.width, self.subtitleLabel.height);
    
    CGFloat kCartBtnW               = 40;
    self.cartBtn.frame              = CGRectMake(self.containerView.width - kCartBtnW - 10, self.containerView.height - kCartBtnW - 10, kCartBtnW, kCartBtnW);
    
    CGFloat kPriceLabelW            = self.cartBtn.left - self.titleLabel.left;
    [self.priceLabel sizeToFit];
    self.priceLabel.frame           = CGRectMake(self.titleLabel.left, self.containerView.height - self.priceLabel.height - 12 , kPriceLabelW, self.priceLabel.height);
}


-(void)setObject:(id)object
{
    if ([object isKindOfClass:[ProductOutline class]]) {
        self.product = object;
        [self.productImage setImgInfo:self.product.imageInfo];
        self.titleLabel.text    = self.product.title?:@"";
        self.subtitleLabel.text = self.product.subtitle?:@"";
        self.priceLabel.text    = [NSString stringWithFormat:@"促销价:￥%@",self.product.priceInfo.marketPrice];
    }
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    if ([object isKindOfClass:[ProductOutline class]]) {
        return 95;
    }
    return 0;
}


-(void)cartBtnOnClicked
{
    PRLOG(@"点击加入购物车====");
    
}
@end
