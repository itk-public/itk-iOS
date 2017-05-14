//
//  UserCenterModel.h
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

typedef NS_ENUM(NSInteger,SexType)
{
    SexTypeBoy   = 1,
    SexTypeGirl  = 2,
};

@interface UserInfo : YHDataModel

@property (readonly,nonatomic) SexType  sexType;
@property (readonly,nonatomic) NSString *phoneNum;
@property (readonly,nonatomic) NSString *nickName;

@end


@interface AssetsInfo : YHDataModel

/**
 *  余额样式：￥xxx
 */
@property (readonly,nonatomic) NSString *balanceString;

/**
 *  优惠券:xxx张
 */
@property (readonly,nonatomic) NSString *couponString;

@end

@interface OrderInfo : YHDataModel

/**
 *  待配送
 */
@property (readonly,nonatomic) NSInteger toDelivery;

/**
 *  待自提
 */
@property (readonly,nonatomic) NSInteger toPick;

/**
 *  待评价
 */
@property (readonly,nonatomic) NSInteger toComment;



@end


@interface UserCenterModel : YHDataModel

@property (strong,nonatomic) UserInfo *userInfo;
@property (strong,nonatomic) AssetsInfo *assetInfo;
@property (strong,nonatomic) OrderInfo *orderInfo;

@end
