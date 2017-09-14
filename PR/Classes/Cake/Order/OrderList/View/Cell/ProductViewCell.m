//
//  ProductViewCell.m
//  PR
//
//  Created by 黄小雪 on 02/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ProductViewCell.h"
#import "OnePixelSepView.h"
#import "PRMBWantedOffice.h"
#import "ProductOutline.h"
#import "AutoImageView.h"


@interface ProductViewCell()

@property (strong,nonatomic) AutoImageView  *productImg;
@property (strong,nonatomic) UILabel        *titleLabel;
@property (strong,nonatomic) UILabel        *subTitleLabel;
@property (strong,nonatomic) UILabel        *priceLable;
@property (strong,nonatomic) UILabel        *numLabel;

@end

@implementation ProductViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _productImg = [[AutoImageView alloc]init];
        [_productImg setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:_productImg];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setNumberOfLines:2];
        [_titleLabel setTextColor:kColorNormal];
        [_titleLabel setFont:KFontNormal(15)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc]init];
        [_subTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_subTitleLabel setFont:KFontNormal(12)];
        [_subTitleLabel setTextColor:kColorGray];
        [self.contentView addSubview:_subTitleLabel];
        
        _priceLable = [[UILabel alloc]init];
        [_priceLable setTextAlignment:NSTextAlignmentRight];
        [_priceLable setTextColor:kColorNormal];
        [_priceLable setFont:KFontNormal(15)];
        [self.contentView addSubview:_priceLable];
        
        _numLabel = [[UILabel alloc]init];
        [_numLabel setFont:KFontNormal(12)];
        [_numLabel setTextColor:kColorGray];
        [_numLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_numLabel];
        
        [self.contentView setPixelSepSet:PSRectEdgeBottom];
        OnePixelSepView *lineView = [self.contentView psBottomSep];
        [lineView setMargin:10];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTarget)];
        [self.contentView addGestureRecognizer:tap];
        

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kTopMargin  = 10;
    CGFloat kLeftMargin = 15;
    self.productImg.frame = CGRectMake(kLeftMargin, kTopMargin, self.height - 2*kTopMargin, self.height - 2*kTopMargin);
    
    CGSize priceLabSize = [self.priceLable  sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.priceLable.frame = CGRectMake(self.width - priceLabSize.width - kLeftMargin, kTopMargin, priceLabSize.width, priceLabSize.height);
    
    self.numLabel.frame = CGRectMake(self.priceLable.left, self.priceLable.bottom + kTopMargin, self.priceLable.width, self.priceLable.height);
    
    CGFloat kTitleLabelW  = self.priceLable.left - self.productImg.right - 2*kTopMargin;
    CGFloat kTitleLablH   = [self.titleLabel sizeThatFits:CGSizeMake(kTitleLabelW, MAXFLOAT)].height;
    self.titleLabel.frame = CGRectMake(self.productImg.right + kTopMargin, kTopMargin, kTitleLabelW,kTitleLablH);
    self.subTitleLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + kTopMargin, kTitleLabelW, 20);
    
}


-(void)setObject:(id)object
{
    if ([object isKindOfClass:[ProductOutline class]]) {
        ProductOutline *product = object;
        [self.productImg setImgInfo:product.imageInfo];
        self.titleLabel.text    = product.title?:@"";
        self.subTitleLabel.text = product.spec?:@"";
        self.priceLable.text    = product.priceInfo.marketPrice?:@"";
        self.numLabel.text      = [NSString stringWithFormat:@"x%zd",product.num];
    }
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 95;
}


-(void)doTarget
{
    [PRMBWantedOffice nativeArrestWarrant:APPURL_VIEW_IDENTIFIER_ORDERDETAIL param:nil];
    
}
@end
