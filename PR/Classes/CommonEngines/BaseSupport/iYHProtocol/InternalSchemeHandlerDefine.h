//
//  InternalSchemeHandlerDefine.h
//  PR
//
//  Created by 黄小雪 on 13/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifndef InternalSchemeHandlerDefine_h
#define InternalSchemeHandlerDefine_h

/**
 *  自定义协议的scheme
 *
 */
#define SCHEME_MYYH       @"myyh"

/**
 *  永辉生活的内部域名
 */
#define INTERNAL_HOST			@"yhlife.com"

/**
 *  支持的handle类型以及对应的path
 */
typedef NS_ENUM(NSInteger,HandleType)
{
    TYPE_INVALID,
    TYPE_OPEN_NATIVE,
    TYPE_OPEN_WEB,
    // 以下类型是app内部自己的协议类型，部提供给外部使用
    TYPE_PARAM_EXPRESS,
};

#define URL_PATH_NATIVE					@"/show/native"
#define URL_PATH_WEB					@"/show/web"
#define URL_PATH_PARAMEXPRESS           @"/private/paramexpress"
#define URL_PATH_LOGIN                  @"/user/login"
#define URL_PATH_ORDER_DETAIL           @"/order/detail"
#define URL_PATH_GOODS_DETAIL           @"/goods/detail"

/**
 *  URL参数解析Key
 */
#define URL_QUERY_KEY_NAME		@"name"
#define URL_QUERY_KEY_URL		@"url"
#define URL_QUERY_KEY_TITLE		@"title"
#define URL_QUERY_KEY_NEEDLOGIN	@"needlogin"
#define URL_QUERY_KEY_BACK      @"backleap" //返回时跳过前面一个页面 默认不处理 0不处理，不跳过  1跳过

#define URL_QUERY_KEY_BACK_LEAP_STRING @"1" //返回跳过前面的页面

#define URL_QUERY_KEY_NOLOADING	@"noloading"
#define URL_QUERY_KEY_CB		@"cb"
#define URL_QUERY_KEY_UD		@"ud"
#define URL_QUERY_KEY_UPLOAD	@"upload"
#define URL_QUERY_KEY_W			@"w"
#define URL_QUERY_KEY_T			@"t"
#define URL_QUERY_KEY_CD		@"cd"
#define URL_QUERY_KEY_ANCHOR	@"anchor"
#define URL_QUERY_KEY_EXPRESSID @"eid"

/**
 *  JS回调参数KEY
 */
#define CALL_BACK_JS_KEY        @"js"

#endif /* InternalSchemeHandlerDefine_h */
