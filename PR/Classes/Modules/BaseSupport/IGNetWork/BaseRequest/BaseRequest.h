//
//  BaseRequest.h
//  PR
//
//  Created by 黄小雪 on 10/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGNetworkDefine.h"

typedef NS_ENUM(NSInteger,HttpMethodType)
{
    kHttpMethodPost,
    kHttpMethodGet,
};

/**
 *  基础请求类，主要负责对URL以及参数进行处理。
 *  目前提供如下功能：
 *      唯一ID标示
 *      HTTPS支持（暂时待定）
 *      共有参数添加
 *      数据加密
 *      HTTP方式指定
 */

@interface BaseRequest : NSObject
@property (assign,nonatomic)HttpMethodType httpMethod;        //网络请求的类型
@property (assign,nonatomic) BOOL needPublicInfo;             //配置是否需要共有参数
@property (strong,nonatomic) NSDictionary *param;             //请求的参数，如果是get,拼接在URL，否则放在body内

@property (strong,nonatomic) NSString *paramStr;              //请求的参数，字符串格式
@property (assign,nonatomic) BOOL isString;                   //是否是字符串
@property (assign,nonatomic) BOOL isOutsideVisit;             //是否是外部接口

/**
 *	生成一个request，默认为Get模式，带param参数自动使用post模式
 *
 *  @param urlStr 服务器路径 .可以是 NSString / NSURL / IGURL类型.
 *  @param parmas 这个请求需要附带的参数
 *
 *  @return 一个网络请求对象
 */
+ (instancetype)requsetWithURL:(id)urlStr andParams:(NSDictionary *)parmas;
+ (instancetype)requsetWithURL:(id)urlStr andParamsString:(NSString *)parmasString;
@end

@class IGURL;
@interface BaseRequest(innerCooperate)
@property (readonly,nonatomic) IGURL *baseURL;              //基础的，不包含参数的URL
@property (readonly,nonatomic) NSString *requestURL;        //封装了参数的URL
@property (readonly,nonatomic) NSDictionary *requestParams;  //URL附带参数
@property (readonly,nonatomic) NSDictionary *postJSONDict;    //发送请求的body内容

-(void)outOfHttps;
@end
