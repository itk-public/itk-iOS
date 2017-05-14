//
//  NHPSNLEGO.h
//  YHClouds
//
//  Created by biqiang.lai on 16/11/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGURL.h"
#import "NSString+Category.h"
#import "InternalSchemeHandlerDefine.h"

@interface NHPSNLEGO : NSObject
@property(nonatomic,readonly) NHPSNLEGO * outPut;
@property(nonatomic,readonly) NSString * cmdURL;

// 通过几个处理体，构建出一条完整的处理通道。
// 就像构建一条积木搭建的道路
+ (NHPSNLEGO *)buildingBlocksWith:(NSArray<NHPSNLEGO *> *)blocks;
+ (NHPSNLEGO *)buildingBlocksForURL:(NSString *)pageURL;

// 执行命令
- (void)runCMDURL:(NSString *)url;


// 继承，进行URL处理
- (void)disposeNativePageURL:(NSString *)url;
@end

