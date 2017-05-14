//
//  NHPShowNative.m
//  YHClouds
//
//  Created by biqiang.lai on 15/11/4.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "NHPShowNative.h"
#import "PRMBureau.h"
#import "SceneMananger.h"
#import "NHPSNLEGO.h"

@implementation NHPShowNative
+ (BOOL)matchCMDPath:(NSString *)path inCMDURL:(NSString *)url
{
    return [path isEqualToString:URL_PATH_NATIVE];
}

- (void)disposeCommand
{
    NHPSNLEGO * lego = [NHPSNLEGO buildingBlocksForURL:self.cmdURL];
    [lego disposeNativePageURL:self.cmdURL];
}
@end
