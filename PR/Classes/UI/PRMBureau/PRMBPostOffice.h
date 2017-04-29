//
//  PRMBPostOffice.h
//  YHClouds
//
//  Created by biqiang.lai on 15/11/4.
//  Copyright © 2015年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PRMBPackageInterface <NSObject>

- (void)receivePRMBPackage:(id)package;

@end


@interface PRMBPostOffice : NSObject

+ (BOOL)postParam:(id)params;

+ (id)takeParamExpress:(NSString *)expressID;
@end
