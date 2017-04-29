//
//  UserInfoData.h
//  PR
//
//  Created by 黄小雪 on 08/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoData : NSObject
DEF_SINGLETON(UserInfoData)

@property (readonly,nonatomic) NSString *uid;
@property (readonly,nonatomic) NSString *uToken;

- (instancetype)initWithUID:(NSString *)uid token:(NSString *)token;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
