//
//  CouponModel.m
//  PR
//
//  Created by 黄小雪 on 21/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super initWithDictionary:dic]) {
        _amount    = [[dic safeObjectForKey:@"amount"]integerValue]/100;
        _cid       = [dic safeObjectForKey:@"id"];
        _startDate = [dic safeObjectForKey:@"startdate"];
        _endDate   = [dic safeObjectForKey:@"enddata"];
        _desc      = [dic safeObjectForKey:@"desc"];
    }
    return self;
}

-(void)updateShopId:(NSString *)shopid
{
    if (shopid && [shopid length]) {
        _shopid = shopid;
    }
}

-(NSMutableAttributedString *)titleAttributedString
{
    NSMutableAttributedString *fristStr      = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%zd",self.amount]];
    NSDictionary       *fristAttribute       = [NSDictionary dictionaryWithObjectsAndKeys:
                                                KFontBold(12),NSFontAttributeName,
                                                kColorOrange ,NSForegroundColorAttributeName,nil];
    [fristStr addAttributes:fristAttribute range:NSMakeRange(0, fristStr.string.length)];
    
    NSString *secondeStr                          = @"元";
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:secondeStr];
    
    NSDictionary       *secondAttribute       = [NSDictionary dictionaryWithObjectsAndKeys:
                                                 KFontNormal(12),NSFontAttributeName,
                                                 kColorOrange,NSForegroundColorAttributeName,nil];
    [attributedStr addAttributes:secondAttribute range:NSMakeRange(0, attributedStr.string.length)];
    
    
    
    NSMutableAttributedString *title         = [[NSMutableAttributedString alloc]initWithAttributedString:fristStr];
    [title appendAttributedString:attributedStr];
    return title;
}
-(NSString *)dateString
{
    return [NSString stringWithFormat:@"使用日期:%@-%@",self.startDate?:@"",self.endDate?:@""];
}
@end
