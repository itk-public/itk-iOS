//
//  URLPathDefine.h
//  PR
//
//  Created by 黄小雪 on 09/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifndef URLPathDefine_h
#define URLPathDefine_h

// 平台首页
#define   DynamicData_URLPATH                     @"/api/v1/home"

//购物车同步
#define   Cart_URLPATH                            @"/api/cart/place"

//购物车获取店铺优惠券
#define  Cart_GetCoupons_URLPATH                  @"/api/cart/coupons"

//个人中心
#define  MemberInfo_URLPATH                       @"/api/member/info"



#pragma mark --------登录模块-----------------
//手机快捷登录
#define  PhoneLogin_URLPATH                       @"/api/member/phoneLogin"
//账号登录
#define  AccountLogin_URLPATH                     @"/api/member/accountLogin"
//获取验证码
#define  GetSecurityCode_URLPATH                  @"/api/member/getSecurityCode"
//注册
#define  Register_URLPATH                         @"/api/member/register"
//忘记密码
#define  ForgetPwd_URLPATH                        @"/api/member/forgetPwd"
#endif /* URLPathDefine_h */
