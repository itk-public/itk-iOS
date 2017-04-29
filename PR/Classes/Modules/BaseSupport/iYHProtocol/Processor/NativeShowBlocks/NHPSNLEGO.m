//
//  NHPSNLEGO.m
//  YHClouds
//
//  Created by biqiang.lai on 16/11/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "NHPSNLEGO.h"
#import "PRMBureau.h"
#import "NHPSNToPage.h"
#import "NHPSNToRoot.h"
#import "NHPSNUnsloved.h"
#import "NHPSNSellerPage.h"
#import "NSPSNEnvChecker.h"
#import "NHPSNCaOPage.h"

@implementation NHPSNLEGO
+ (NHPSNLEGO *)buildingBlocksWith:(NSArray<NHPSNLEGO *> *)blocks
{
    NHPSNLEGO * headBlock = nil;
    NHPSNLEGO * preBlock = nil;
    for (NSInteger index = 0; index < [blocks count]; index++) {
        NHPSNLEGO * curBlock = [blocks objectAtIndex:index];
        if (preBlock == nil) {
            preBlock = curBlock;
            headBlock = curBlock;
        }else{
            preBlock->_outPut = curBlock;
            preBlock = curBlock;
        }
    }
    
    return headBlock;
}

+ (NHPSNLEGO *)buildingBlocksForURL:(NSString *)pageURL
{
    NSDictionary * params     = [pageURL getURLParams];
    NSString * viewIdentifier = [params safeObjectForKey:URL_QUERY_KEY_NAME hintClass:[NSString class]];
    if ([viewIdentifier isEqualToString:APPURL_VIEW_IDENTIFIER_SELLER_MAIN] ||
        [viewIdentifier isEqualToString:APPURL_VIEW_IDENTIFIER_SELLER_CATEGORY] ||
        [viewIdentifier isEqualToString:APPURL_VIEW_IDENTIFIER_SELLER_INNER_SEARCH]) {
        return [self buildingBlocksWith:@[[NSPSNEnvChecker new],
                                          [NHPSNSellerPage new],
                                          [NHPSNToPage new],
                                          [NHPSNCaOPage new],
                                          [NHPSNUnsloved new]]];
    }else{
        return [self buildingBlocksWith:@[[NSPSNEnvChecker new],
                                          [NHPSNToPage new],
                                          [NHPSNToRoot new],
                                          [NHPSNCaOPage new],
                                          [NHPSNUnsloved new]]];
    }
}

- (void)runCMDURL:(NSString *)url
{
    _cmdURL = url;
    
}

- (void)disposeNativePageURL:(NSString *)url
{
    _cmdURL = url;
}

@end
