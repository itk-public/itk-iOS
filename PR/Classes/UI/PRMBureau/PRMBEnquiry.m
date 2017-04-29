//
//  PRMBEnquiry.m
//  PR
//
//  Created by 黄小雪 on 12/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PRMBEnquiry.h"
#import "PRMBureauDefine.h"
#import "IGUtilties.h"
#import "InternalSchemeHandlerDefine.h"
#import "NSString+Category.h"

@implementation PRMBEnquiry
+ (NSString *)urlForViewWithIdentifier:(NSString *)identifier params:(NSDictionary *)params
{
    NSString *url = nil;
    if (identifier) {
        //配置myyh协议链接
        NSString * scheme = SCHEME_MYYH;
        NSString * host   = INTERNAL_HOST;
        NSString * path   = URL_PATH_NATIVE;
        
        url = [NSString stringWithFormat:@"%@://%@%@",scheme,host,path];
        
        //拼接参数
        NSMutableDictionary *urlParam = [NSMutableDictionary dictionaryWithDictionary:params];
        [urlParam setObject:[IGUtilties encodeURL:identifier] forKey:URL_QUERY_KEY_NAME];
        url                     = [url stringByAddingURLParams:urlParam];
    }
    
    return url;
}


+(NSString *)urlForServiceWithIdentifier:(NSString *)identifier params:(NSDictionary *)params{
    NSString *url  = nil;
    if (identifier) {
        // 配置myyh协议链接
        NSString * scheme = SCHEME_MYYH;
        NSString * host   = INTERNAL_HOST;
        NSString * path   = URL_PATH_WEB;
        url = [NSString stringWithFormat:@"%@://%@%@",scheme,host,path];
        
        // 拼接参数
        NSMutableDictionary * urlParam = [NSMutableDictionary dictionaryWithDictionary:params];
        [urlParam setObject:[IGUtilties encodeURL:identifier] forKey:URL_QUERY_KEY_URL];
        url                     = [url stringByAddingURLParams:urlParam];
    }
    return url;
}
@end
