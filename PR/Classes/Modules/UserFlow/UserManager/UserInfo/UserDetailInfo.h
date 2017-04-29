//
//  UserDetailInfo.h
//  PR
//
//  Created by 黄小雪 on 08/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoData.h"

@interface UserDetailInfo : NSObject
@property (strong,nonatomic) NSString *userId;
@property (strong,nonatomic) NSString *userToken;
@property(nonatomic,strong)  NSString *versionNum;

// 读取本地备份的用户信息
+(instancetype)newUserFromLocal;
-(void)saveToLocal;

//删除本地用户信息
+(BOOL)removeLocalUserInfo;

-(UserInfoData *)publicInfo;

@end
