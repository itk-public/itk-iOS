//
//  PRMBEnquiry.h
//  PR
//
//  Created by 黄小雪 on 12/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRMBEnquiry : NSObject

/*!
 @method
 @abstract      生成view跳转url
 @param         identifier: view 标识
 @param         params: 初始化参数
 @discussion    参数必须全部为NSString类型的,示例；
 [YHURLMap urlForViewWithIdentifier:APPURL_IDENTIFIER_WEBVIEW params:@{@"_url": @"http://www.baidu.com", @"_title": @"你好"}];
 @return        NSString,生成的view跳转url
 */
+ (NSString *)urlForViewWithIdentifier:(NSString *)identifier params:(NSDictionary *)params;

/*!
 @method
 @abstract      生成调用应用服务的url
 @param         identifier: 应用提供的服务标识
 @param         params: 初始化参数
 @discussion    参数必须全部为NSString类型的,示例；
 [YHURLMap urlForViewWithIdentifier:APPURL_IDENTIFIER_WEBVIEW params:@{@"_url": @"http://www.baidu.com", @"_title": @"你好"}];
 @return        NSString,生成的view跳转url
 */
+ (NSString *)urlForServiceWithIdentifier:(NSString *)identifier params:(NSDictionary *)params;

@end
