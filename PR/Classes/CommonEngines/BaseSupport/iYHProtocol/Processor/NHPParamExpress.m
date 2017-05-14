//
//  NHPParamExpress.m
//  YHClouds
//
//  Created by biqiang.lai on 15/11/4.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "NHPParamExpress.h"
#import "IGURL.h"
#import "SceneMananger.h"
#import "PRMBPostOffice.h"

@implementation NHPParamExpress
+ (BOOL)matchCMDPath:(NSString *)path inCMDURL:(NSString *)url
{
    return [path isEqualToString:URL_PATH_PARAMEXPRESS];
}

- (void)disposeCommand
{
    IGURL * url = [IGURL urlWithString:self.cmdURL];
    NSDictionary * params     = [url allQueryPairs];

    NSString * expressID      = [params safeObjectForKey:URL_QUERY_KEY_EXPRESSID];
    if (expressID == nil) {
        NSAssert(false, @"没有包裹信息");
    }
    id express                = [PRMBPostOffice takeParamExpress:expressID];
    if (express == nil) {
        NSAssert(false, @"包裹丢失了!!!!");
    }
    
    // 进行参数派送
    [self processServiceParams:express];
}

- (void)processServiceParams:(id)params
{
    UIViewController * topViewController = [[SceneMananger shareMananger] visibleViewController];
    if (topViewController && [topViewController conformsToProtocol:@protocol(PRMBPackageInterface)]){
        id<PRMBPackageInterface> packageVC = (id<PRMBPackageInterface>)topViewController;
        if ([packageVC respondsToSelector:@selector(receivePRMBPackage:)]) {
            [packageVC receivePRMBPackage:params];
        }
    }
}
@end
