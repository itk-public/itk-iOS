//
//  UserInfo.h
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHDataModel.h"
#import "UserInfoData.h"

@interface UserInfo : YHDataModel
@property (copy,nonatomic) NSString *userId;
@property (copy,nonatomic) NSString *userToken;
@property(nonatomic,strong)NSString * versionNum;

+(instancetype)newUserFromLocal;
-(void)saveToLocal;
+(BOOL)removeLocalUserInfo;
-(UserInfoData *)publicInfo;

@end
