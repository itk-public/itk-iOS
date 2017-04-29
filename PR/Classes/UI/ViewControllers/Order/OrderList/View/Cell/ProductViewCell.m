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


@interface ProductViewCell()

@property (strong,nonatomic) UIImageView  *productImg;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *subTitleLabel;
@property (strong,nonatomic) UILabel *priceLable;
@property (strong,nonatomic) UILabel *numLabel;

@end

@implementation ProductViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _productImg = [[UIImageView alloc]init];
        [_productImg setContentMode:UIViewContentModeScaleAspectFit];
        [_productImg setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:_productImg];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setNumberOfLines:2];
        [_titleLabel setTextColor:kColorNormal];
        [_titleLabel setText:@"商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称"];
        [_titleLabel setFont:KFontNormal(15)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc]init];
        [_subTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_subTitleLabel setText:@"规格文字规格文字规格文字规格文字"];
        [_subTitleLabel setFont:KFontNormal(12)];
        [_subTitleLabel setTextColor:kColorGray];
        [self.contentView addSubview:_subTitleLabel];
        
        _priceLable = [[UILabel alloc]init];
        [_priceLable setTextAlignment:NSTextAlignmentRight];
        [_priceLable setText:@"￥129.00"];
        [_priceLable setTextColor:kColorNormal];
        [_priceLable setFont:KFontNormal(15)];
        [self.contentView addSubview:_priceLable];
        
        _numLabel = [[UILabel alloc]init];
        [_numLabel setFont:KFontNormal(12)];
        [_numLabel setTextColor:kColorGray];
        [_numLabel setTextAlignment:NSTextAlignmentRight];
        [_numLabel setText:@"x2"];
        [self.contentView addSubview:_numLabel];
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


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 95;
}


-(void)doTarget
{
    [super doTarget];
    [PRMBWantedOffice nativeArrestWarrant:APPURL_VIEW_IDENTIFIER_ORDERDETAIL param:nil];
    
}
@end
