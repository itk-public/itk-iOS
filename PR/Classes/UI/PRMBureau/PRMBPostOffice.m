//
//  PRMBPostOffice.m
//  YHClouds
//
//  Created by biqiang.lai on 15/11/4.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "PRMBPostOffice.h"
#import "NSString+Category.h"
#import "InternalSchemeHandler.h"
#import "InternalSchemeHandlerDefine.h"


@interface PRMBPoseParamWareHourse : NSObject
@property(nonatomic,strong) NSMutableDictionary * goodsShell;
@property(nonatomic,strong) dispatch_semaphore_t gsSignal;
@end

@implementation PRMBPoseParamWareHourse
- (instancetype)init
{
    if (self = [super init]) {
        self.gsSignal =  dispatch_semaphore_create(1);
    }
    return self;
}

- (NSMutableDictionary *)goodsShell
{
    if (nil == _goodsShell) {
        _goodsShell = [NSMutableDictionary new];
    }
    return _goodsShell;
}

- (NSString *)goodsUniqueID
{
    static long t = 1;
    return [NSString stringWithFormat:@"%ld",t++];
}

- (NSString *)storeParam:(id)param
{
    if (nil == param) {
        return nil;
    }
    
    if(dispatch_semaphore_wait(self.gsSignal, DISPATCH_TIME_NOW) != 0 )
    {
        return nil;
    }
    
    NSString * paramCode = [self goodsUniqueID];
    [self.goodsShell safeSetObject:param forKey:paramCode];
    dispatch_semaphore_signal(self.gsSignal);
    return paramCode;
}


- (id)pickUpStoredParam:(NSString *)receipt
{
    if(dispatch_semaphore_wait(self.gsSignal, DISPATCH_TIME_NOW) != 0 )
    {
        return nil;
    }
    
    id param = [self.goodsShell safeObjectForKey:receipt];
    [self.goodsShell removeObjectForKey:receipt];
    dispatch_semaphore_signal(self.gsSignal);
    return param;
}
@end


@implementation PRMBPostOffice
+ (PRMBPoseParamWareHourse *)officeWarehourse
{
    static PRMBPoseParamWareHourse * wareHouser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wareHouser = [PRMBPoseParamWareHourse new];
    });
    
    return wareHouser;
}

+ (BOOL)postParam:(id)params
{
    NSString * url              = nil;
    NSString * expressID        = nil;
    if (params) {
        expressID =  [[self officeWarehourse] storeParam:params];
        if (nil == expressID) {
            return  NO;
        }
    }
    
    NSString * scheme       = SCHEME_MYYH;
    NSString * host         = INTERNAL_HOST;
    NSString * path         = URL_PATH_PARAMEXPRESS;
    url                     = [NSString stringWithFormat:@"%@://%@%@",scheme,host,path];
    
     NSDictionary *  expressInfo = [NSDictionary dictionaryWithObject:expressID?:@"" forKey:URL_QUERY_KEY_EXPRESSID];
    url                     = [url stringByAddingURLParams:expressInfo];
    
    [[InternalSchemeHandler defaultHandler] handleURL:url];
    
    return YES;
}

+ (id)takeParamExpress:(NSString *)expressID
{
    return [[self officeWarehourse] pickUpStoredParam:expressID];
}
@end
