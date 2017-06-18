//
//  ShopHomeSingleProductView.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeSingleProductView.h"
#import "AutoImageView.h"
#import "ProductOutline.h"
#import "CouponModel.h"

@interface ShopHomeSingleProductView()
@property (strong,nonatomic) AutoImageView *productImage;
@property (strong,nonatomic) UILabel       *titleLabel;
@property (strong,nonatomic) UIButton      *cartBtn;
@property (strong,nonatomic) UILabel       *priceLabel;
@end

@implementation ShopHomeSingleProductView
-(instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _productImage = [[AutoImageView alloc]init];
        [_productImage setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:_productImage];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 2;
        [_titleLabel setTextColor:UIColorFromRGB(0x333333)];
        [_titleLabel setFont:KFontNormal(14)];
        [self addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextColor:kColorOrange];
        [_priceLabel setFont:KFontNormal(14)];
        [_priceLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_priceLabel];
        
        _cartBtn = [[UIButton alloc]init];
        [_cartBtn addTarget:self action:@selector(cartBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cartBtn];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShopHomeSingleProductView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kTopMargin = 5;
    CGFloat kLeftMaring = 15;
    self.productImage.frame = CGRectMake(0,0, (ScreenWidth - kMiddleMargin)/2.0, (ScreenWidth - kMiddleMargin)/2.0);
    
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(kLeftMaring, 0, self.priceLabel.width, self.priceLabel.height);
    self.priceLabel.bottom = self.height - kTopMargin;
    
    CGFloat kCartBtnW = 40;
    CGFloat kCartBtnH = 30;
    self.cartBtn.frame = CGRectMake(self.width - kLeftMaring - kCartBtnW, self.height - kCartBtnH, kCartBtnW, kCartBtnH);
    
    CGFloat kTitleLableH = self.priceLabel.top - self.productImage.bottom;
    self.titleLabel.frame = CGRectMake(kLeftMaring, self.productImage.bottom, self.width - 2*kLeftMaring, kTitleLableH);
}

-(void)setProduct:(ProductOutline *)product
{
    CONDITION_CHECK_RETURN([product isKindOfClass:[ProductOutline class]]);
    _product = product;
    [self.productImage setImgInfo:product.imageInfo];
    self.titleLabel.attributedText = [[[self class]ajustWithProduct:product] safeObjectForKey:@"content"];
    self.priceLabel.text           = product.priceInfo.marketPrice;
}

-(void)tapShopHomeSingleProductView
{
     PRLOG(@"点击查看商品详情");
}


-(void)cartBtnOnClicked
{
    PRLOG(@"点击购物车");
}

+(CGFloat)heightWithProduct:(ProductOutline *)product
{

    CONDITION_CHECK_RETURN_VAULE([product isKindOfClass:[ProductOutline class]], 0);
    NSDictionary *dict = [[self class]ajustWithProduct:product];
    return [[dict safeObjectForKey:@"height"]floatValue];
}


+(NSDictionary *)ajustWithProduct:(ProductOutline *)product
{
    CONDITION_CHECK_RETURN_VAULE([product isKindOfClass:[ProductOutline class]], nil);
    CGFloat height = (ScreenWidth - kMiddleMargin)/2.0 + 30;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.lineSpacing   = 5;
    paragraph.alignment = NSTextAlignmentLeft;
    NSDictionary *attributes           = @{NSFontAttributeName:KFontNormal(14),NSParagraphStyleAttributeName:paragraph};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:product.title attributes:attributes];
    CGSize maximumLabelSize            = CGSizeMake(ScreenWidth - 30, CGFLOAT_MAX);
    CGSize expectSize                  = [product.title boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return @{@"height":@(expectSize.height + height),@"content":attributeStr};
}
@end
