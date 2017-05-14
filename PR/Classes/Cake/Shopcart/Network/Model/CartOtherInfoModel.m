//
//  CartOtherInfoModel.m
//  YHClouds
//
//  Created by 黄小雪 on 15/10/27.
//  Copyright © 2015年 YH. All rights reserved.
//   购物车中的 总计、总额、优惠、运费数据模型

#import "CartOtherInfoModel.h"

@implementation CartOtherInfoModel
-(instancetype)initWithDict:(NSDictionary *)dict;
{
    if (self = [super init]) {
        _storeid                                 = [dict safeObjectForKey:@"storeid" hintClass:[NSString class]];

        _amountPrice                             = [NSString stringWithFormat:@"%.2f",([[dict safeObjectForKey:@"priceTotal" hintClass:[NSNumber class]] doubleValue])/100];
        NSInteger priceTotal = [[dict safeObjectForKey:@"priceTotal" hintClass:[NSNumber class]] integerValue]/100;
        NSInteger minOrderAmount = [[dict safeObjectForKey:@"minOrderAmount" hintClass:[NSNumber class]] integerValue];
        _showFreightTips = minOrderAmount > priceTotal;
        if (_showFreightTips) {
            _freightPrompt = [NSString stringWithFormat:@"未达到起订金额￥%zd,可能会加收运费",minOrderAmount];
        }else{
            _freightPrompt = @"";
        }
        _freightPromotionMsg = [dict safeObjectForKey:@"freightpromotionmsg" hintClass:[NSString class]];
        _orderPromotionMsg   = [dict safeObjectForKey:@"orderpromotionmsg" hintClass:[NSString class]];
        _promotionMsg        = [dict safeObjectForKey:@"promotionmsg" hintClass:[NSString class]];
    }
    return self;
}
+(instancetype)cartOtherInfoModelWithDict:(NSDictionary *)dict;
{
    return [[self alloc]initWithDict:dict];
}

-(void)setIsOutDelivered:(BOOL)isOutDelivered
{
//    NSMutableAttributedString *fristStr      = [[NSMutableAttributedString alloc]initWithString:@"合计:"];
//    NSDictionary       *fristAttribute       = [NSDictionary dictionaryWithObjectsAndKeys:
//                                                KFontNormal(12),NSFontAttributeName,
//                                                kColorNormal,NSForegroundColorAttributeName,nil];
//    [fristStr addAttributes:fristAttribute range:NSMakeRange(0, fristStr.string.length)];
//    
//    NSMutableAttributedString *secondStr     = [[NSMutableAttributedString alloc]initWithString:@"￥ "];
//    NSDictionary       *secondAttribute      = [NSDictionary dictionaryWithObjectsAndKeys:
//                                                KFontNormal(12),NSFontAttributeName,
//                                                UIColorFromRGB(0xff4600),NSForegroundColorAttributeName,nil];
//    [secondStr addAttributes:secondAttribute range:NSMakeRange(0, secondStr .string.length)];
//    
//    
//    NSString *price                          = self.amountPrice;
//    
//    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:price?:@""];
//    NSRange pointRange                       = [price rangeOfString:@"."];
//    NSInteger decimalLocation                = pointRange.location + 1;
//    NSInteger decimalLenght                  = price.length - decimalLocation;
//    NSRange decimalRange                     = NSMakeRange(decimalLocation, decimalLenght);
//    
//    [attributedStr addAttribute:NSFontAttributeName
//                          value:KFontNormal(12)
//                          range:decimalRange];
//    [attributedStr addAttribute:NSFontAttributeName
//                          value:KFontNormal(16)
//                          range:NSMakeRange(0, price.length - decimalLenght)];
//    [attributedStr addAttribute:NSForegroundColorAttributeName
//                          value: UIColorFromRGB(0xff4600)
//                          range:NSMakeRange(0, price.length)];
//    
//    
//    BOOL pickSelf                            = [ShipAddrManager sharedInstance].deliveryInfo.pickselfStyle;
//    NSString *freight                        = @"  (不含运费)";
//    if (pickSelf || isOutDelivered) {
//        freight                                  = @"";
//    }
//    NSMutableAttributedString *freightStr    = [[NSMutableAttributedString alloc]initWithString:freight];
//    NSDictionary       *freightDict          = [NSDictionary dictionaryWithObjectsAndKeys:
//                                                KFontNormal(10),NSFontAttributeName,
//                                                kColorGray,NSForegroundColorAttributeName,nil];
//    [freightStr addAttributes:freightDict range:NSMakeRange(0, freight.length)];
//    
//    NSMutableAttributedString *title         = [[NSMutableAttributedString alloc]initWithAttributedString:fristStr];
//    [title appendAttributedString:secondStr];
//    [title appendAttributedString:attributedStr];
//    [title appendAttributedString:freightStr];
//    _allprice                                = title;
}

-(NSMutableAttributedString *)getCSXAllPrice
{
    if (self.showPrice == NO) return nil;
        NSMutableAttributedString *fristStr      = [[NSMutableAttributedString alloc]initWithString:@"商品金额:  "];
        NSDictionary       *fristAttribute       = [NSDictionary dictionaryWithObjectsAndKeys:
                                                    KFontNormal(13),NSFontAttributeName,
                                                    kColorNormal,NSForegroundColorAttributeName,nil];
        [fristStr addAttributes:fristAttribute range:NSMakeRange(0, fristStr.string.length)];
        
        NSMutableAttributedString *secondStr     = [[NSMutableAttributedString alloc]initWithString:@"￥"];
        NSDictionary       *secondAttribute      = [NSDictionary dictionaryWithObjectsAndKeys:
                                                    KFontNormal(13),NSFontAttributeName,
                                                    UIColorFromRGB(0xfe4600),NSForegroundColorAttributeName,nil];
        [secondStr addAttributes:secondAttribute range:NSMakeRange(0, secondStr .string.length)];
        
        
        NSString *price                          = self.amountPrice;
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:price?:@""];
        NSRange pointRange                       = [price rangeOfString:@"."];
        NSInteger decimalLocation                = pointRange.location + 1;
        NSInteger decimalLenght                  = price.length - decimalLocation;
        NSRange decimalRange                     = NSMakeRange(decimalLocation, decimalLenght);
        
        [attributedStr addAttribute:NSFontAttributeName
                              value:KFontNormal(12)
                              range:decimalRange];
        [attributedStr addAttribute:NSFontAttributeName
                              value:KFontNormal(18)
                              range:NSMakeRange(0, price.length - decimalLenght)];
        [attributedStr addAttribute:NSForegroundColorAttributeName
                              value: UIColorFromRGB(0xfe4600)
                              range:NSMakeRange(0, price.length)];
    
        
        NSMutableAttributedString *title         = [[NSMutableAttributedString alloc]initWithAttributedString:fristStr];
        [title appendAttributedString:secondStr];
    [title appendAttributedString:attributedStr];
    return title;

}
@end
