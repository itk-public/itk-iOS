//
//  DynamicUIModel.h
//  PR
//
//  Created by 黄小雪 on 12/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"


typedef NS_ENUM(NSInteger,DynamicCardType)
{
    DynamicCardType_None,
    DynamicCardType_MIN = DynamicCardType_None,         // 0
    DynamicCardType_HotBanner,                          //广告banner
    DynamicCardType_HotIcon,                            //超市生鲜icon,新鲜水果
    DynamicCardType_CellGap,                            //cell间隙
    DynamicCardType_Channels,                           //频道（美食盛宴、xx专场）
    DYnamicCardType_SellerInfo,                         //商家信息(xx店铺)
    DYnamicCardType_SellerActivity,                     //商家活动提示(满100减20活动等。。。。)
    DYnamicCardType_SellerProducts,                     //商品的products
    DYnamicCardType_SellerCoupon,                       //商家优惠券
    DYnamicCardType_ThressProducts,
    DYnamicCardType_MAX,
    
};

@interface DynamicCardItem : YHDataModel
@property (readonly,nonatomic) DynamicCardType type;
@property (readonly,nonatomic) id data;

@end

@interface DynamicUIModel : YHDataModel
//返回所有的动态卡片信息
- (NSArray *)dynamicCards;
@end
