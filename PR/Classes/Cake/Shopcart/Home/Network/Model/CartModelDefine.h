//
//  CartModelDefine.h
//  YHClouds
//
//  Created by biqiang.lai on 16/2/3.
//  Copyright © 2016年 YH. All rights reserved.
//

#ifndef CartModelDefine_h
#define CartModelDefine_h

#define KEY_PRODUCT_ID      @"id"
#define KEY_PRODUCT_NUM     @"num"
#define KEY_PRODUCT_SELECT  @"selectstate"
#define KEY_PRODUCT_PATTERN @"pattern"

#define DEFAULT_PATTERN_VALUE @"t"
#define NEXT_PATTERN_VALUE    @"n"


#define HEGIHT_CARTORDERCELL  95
#define HEGIHT_TOPMARGIN      10
#define HEGIHT_CARTHEADERVIEW 41
#define HEGIHT_CARTFOOTERVIEW 40
#define HEGIHT_PROMPTVIEW     25


#define CONFIRM_ORDER_SUCCESS  @"confirmOrderSuccess"
//余额不足充值成功
#define ACCOUNT_RECHARGE_SUCCESS_NOTIFICATION @"AccountRechargeSuccessNotification"

//reload购物车
#define CART_SHOP_RELOAD   @"cartshopreload"
//刷新购物车
#define CART_SHOP_REQUEST @"cartshoprequest"

#define CART_SHOP_TALBEVIEWTOTOP  @"cartshoptableviewtotop"

//QuantityView是第一响应者
#define QUANTITYVIEW_FRISTRESPONDER @"QuantityView_FristResponder"

typedef NS_ENUM(NSInteger,CartDataAPIType)
{
    CartTNoneDataType = 0,
    CartDetailDataType = 1,
};


typedef NS_ENUM(NSInteger,CartDeliveryRestrict)
{
    CartDeliveryNoRestrict = 0,
    CartDeliverySpeedRestrict,
    CartDeliveryNextDayRestrict,
};


typedef NS_ENUM(NSInteger,AlterViewType){
    AlterViewTypePickSelf  = 1,
    AlterViewTypeRefreshCart,
    AlterViewTypeDeletedAll,
    AlterViewTypeDeletedOne,
    AlterViewTypeGotoHome,
    AlterViewTypeRestr,
};

typedef NS_ENUM(NSInteger,PTDeliveryType)
{
    PTDeliveryUnknown = 0,
    PTDeliveryFast,
    PTDeliverySlow,
    PTDeliveryEP,
};


#endif /* CartModelDefine_h */
