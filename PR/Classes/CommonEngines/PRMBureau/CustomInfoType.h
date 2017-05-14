//
//  CustomBtnType.h
//  PR
//
//  Created by 黄小雪 on 12/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifndef CustomInfoType_h
#define CustomInfoType_h
typedef NS_ENUM(NSInteger,CustomBtnType)
{
    CustomBtnTypeWhiteBg  = 0,      //白色背景
    CustomBtnTypeGreenBg,           //绿色背景
    CustomBtnTypePhoneQuickLogin,   //手机快捷登录
    CustomBtnTypeAccountLogin,      //账号密码登录
    CustomBtnTypeSeleted,           //勾选按钮
    CustomBtnTypeProtocol,          //协议
};


typedef NS_ENUM(NSInteger,CustomBtnTag)
{
    CustomBtnTagToPay  = 1,      //立即支付
    CustomBtnTagToComment,       //追加评论
    CustomBtnTagToBuyAgain,      //再次购买
};

typedef NS_ENUM(NSInteger,OrderStatus)
{
    OrderStatusToDelivery  = 1,   //待配送
    OrderStatusToPickUp,          //待自提
    OrderStatusToComment,         //待评价
    OrderStatusFefunding,         //退款中
};

#endif /* CustomBtnType_h */
