//
//  ProductImageView2.m
//  PR
//
//  Created by 黄小雪 on 16/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ProductImageView2.h"
#import "AutoImageView.h"
#import "ActionHandler.h"


@interface ProductImageView2()
@property (strong,nonatomic) AutoImageView *productImage;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *priceLabel;
@end

@implementation ProductImageView2
-(instancetype)init{
    if (self = [super init]) {
        _productImage = [[AutoImageView alloc]init];
        [_productImage setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_productImage];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 2;
        [_titleLabel setTextColor:kColorNormal];
        [_titleLabel setFont:KFontNormal(14)];
        [self addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextColor:kColorCSX];
        [self addSubview:_priceLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapProductImageView2)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMarign = 15;
    CGFloat kPriceLabelH = [self.priceLabel sizeThatFits:CGSizeMake(MAXFLOAT,MAXFLOAT)].height;
    CGFloat kBottomMargin = 5;
    self.priceLabel.frame = CGRectMake(kLeftMarign, self.height - kBottomMargin - kPriceLabelH, self.width - 2*kLeftMarign, kPriceLabelH);
    CGFloat kTitleLabelH = [self.titleLabel sizeThatFits:CGSizeMake(self.priceLabel.width, MAXFLOAT)].height;
    self.titleLabel.frame = CGRectMake(self.priceLabel.left, self.priceLabel.top - kBottomMargin - kTitleLabelH, self.priceLabel.width, kTitleLabelH);
    [self.titleLabel setBackgroundColor:[UIColor orangeColor]];
    CGFloat kProductImageH = self.titleLabel.top - 2* kBottomMargin;
    self.productImage.frame = CGRectMake(kLeftMarign, kBottomMargin, self.priceLabel.width, kProductImageH);
}

-(void)setInfo:(ProductInfo *)info
{
    CONDITION_CHECK_RETURN([info isKindOfClass:[ProductInfo class]]);
    _info = info;
    self.titleLabel.text = info.title?:@"";
    if (info.imageInfo) {
         [self.productImage setImgInfo:info.imageInfo];
    }
    if ([info.priceInfo.marketPrice length]) {
        self.priceLabel.hidden = NO;
        NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] init];
        [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:info.priceInfo.marketPrice attributes:@{NSForegroundColorAttributeName : kColorReferenceTawnyColor,
                                                                                                                              NSFontAttributeName : KFontBold(isNarrowScreem?15:17)}]];
        if ([info.spec length]) {
            NSString *priceInfo = [NSString stringWithFormat:@"/%@",info.spec];
             [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:priceInfo attributes:ATTR_DICTIONARY(kColorReferenceTawnyColor, KFontNormal(isNarrowScreem?10:12))]];
        }
        self.priceLabel.attributedText = attrString;
    }else{
        self.priceLabel.hidden = YES;
    }
    [self setNeedsLayout];
}

-(void)tapProductImageView2
{
    if (self.info.action) {
        [[ActionHandler handlerWithAction:self.info.action]run];
    }
}
@end
