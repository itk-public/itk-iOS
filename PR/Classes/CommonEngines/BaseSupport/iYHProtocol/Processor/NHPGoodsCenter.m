//
//  NHPGoodDispose.m
//  YHClouds
//
//  Created by biqiang.lai on 15/12/10.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "NHPGoodsCenter.h"
#import "PRMBureau.h"
#import "IGURL.h"

@implementation NHPGoodsCenter
+ (BOOL)matchCMDPath:(NSString *)path inCMDURL:(NSString *)url
{
    return [path isEqualToString:URL_PATH_GOODS_DETAIL];
}

- (void)disposeCommand
{
    IGURL * url = [IGURL urlWithString:self.cmdURL];
    //url
    NSString * cid    = [url queryForKey:@"cid" isCaseSensitive:NO];
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary:[url allQueryPairs]];
    [params safeSetObject:cid forKey:@"id"];
    if (cid) {
        [PRMBWantedOffice nativeArrestWarrant:APPURL_VIEW_IDENTIFIER_GOODS_DETAIL
                                        param:params];
    }
}
@end
