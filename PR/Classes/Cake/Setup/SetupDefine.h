//  SetupDefine.h
//  YHClouds
//
//  Created by 黄小雪 on 2017/6/6.
//  Copyright © 2017年 YH. All rights reserved.
//

#ifndef SetupDefine_h
#define SetupDefine_h


typedef NS_ENUM(NSInteger,SetupViewTnteractiveType)
{
    SetupViewTnteractiveTypeModifyPwd      = 0,       //修改登录密码
    SetupViewTnteractiveTypeClearCache,               //清除本地缓存
    SetupViewTnteractiveTypeVersionInfo,              //版本信息
    SetupViewTnteractiveTypeAbout,                    //关于
};


#define kLeftString       @"leftstring"
#define kTnteractiveType  @"TnteractiveType"
#define kSubTitleString   @"SubTitleString"
#define kShowLineView     @"showlineview"

#endif /* SetupDefine_h */
