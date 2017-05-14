//
//  CartSourceData.m
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//

#import "CartSourceData.h"

@interface CartSourceData ()
{
    
}

@end

@implementation CartSourceData

#pragma mark ---------------------退出清空--------------------
#pragma mark 释放
- (void)dealloc
{
    
}
#pragma mark ---------------------System---------------------
- (instancetype)init
{
    if (self = [super init]) {
        
        
    }
    return self;
}

#pragma mark ---------------------初始化----------------------
#pragma mark ---------------------属性相关--------------------
#pragma mark ---------------------代理方法--------------------
#pragma mark ---------------------功能函数--------------------
#pragma mark ---------------------接口API--------------------
+ (instancetype)shareInstance
{
    static CartSourceData *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 根据传入的构造器，返回对应的页面数据
 
 @param structure 数据构造器
 
 @return 页面数据NSArray
 */
- (NSArray *)acquireDataArray:(CartViewStructure *)structure
{
    return nil;
}

@end
