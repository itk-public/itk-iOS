//
//  GoodDetailModel.h
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"
#import "EvaluateModel.h"
#import "ProductOutline.h"
#import "ShopDescInfo.h"

FOUNDATION_EXTERN NSString *const couponIcon;
FOUNDATION_EXTERN NSString *const couponAction;

@interface GoodDetailModel : YHDataModel
//商品主图片
@property (readonly,nonatomic) NSArray          *mainImgs;
//评论
@property (readonly,nonatomic)  EvaluateModel   *evaluate;
//评论总数
@property (readonly,nonatomic)  NSInteger        evaluateTotalNum;
//好评率
@property (readonly,nonatomic)  NSString        *favorableRate;
@property (readonly,nonatomic)  ProductOutline  *product;
@property (readonly,nonatomic)  ShopDescInfo    *shopInfo;
//附加信息（快递、产地、销量）
@property (readonly,nonatomic)  NSArray         *additionalInfo;
//优惠券信息
@property (readonly,nonatomic)  NSDictionary    *coupon;
//图文详情的图片
@property (readonly,nonatomic)  NSArray         *pictureDetail;



@end
