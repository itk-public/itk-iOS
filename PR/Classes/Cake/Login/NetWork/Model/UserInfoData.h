//
//  UserInfoData.h
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoData : NSObject
@property(nonatomic,readonly)NSString * uid;
@property(nonatomic,readonly)NSString * uToken;

-(instancetype)initWithUID:(NSString *)uid token:(NSString *)token;
@end
