//
//  CartOtherInfoModel.h
//  YHClouds
//
//  Created by 黄小雪 on 15/10/27.
//  Copyright © 2015年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartOtherInfoModel : NSObject
/**
 *  总计(购物车使用)
 */
@property (readonly,nonatomic) NSMutableAttributedString *allprice;
/**
 *  总计价格(商家首页使用)
 */
@property (readonly,nonatomic) NSString *amountPrice;
@property (copy,nonatomic    ) NSString *storeid;
@property (assign,nonatomic  ) BOOL     isOutDelivered;
@property (assign,nonatomic  ) BOOL     showPrice;
@property (assign,nonatomic  ) BOOL     showFreightTips;
@property (strong,nonatomic  ) NSString *freightPrompt;
//免邮文案 4.0支持 例如：满18元免邮费
@property (strong,nonatomic)   NSString *freightPromotionMsg;
//订单满减文案 4.0支持 例如：满99减30"
@property (strong,nonatomic)   NSString *orderPromotionMsg;
//总促销文案 4.0支持 例如：已减30，免运费"
@property (strong,nonatomic)   NSString *promotionMsg;
+(instancetype)cartOtherInfoModelWithDict:(NSDictionary *)dict;
-(NSMutableAttributedString *)getCSXAllPrice;
@end
