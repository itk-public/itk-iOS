//
//  UserInfo.m
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "UserInfo.h"
#import "FileManager.h"

NSString *keyOfUid       = @"uid";
NSString *keyOfUserToken = @"accesstoken";
NSString *keyOfVersion   = @"infoVersion";

#define UserSaveFileName  @"uif.data"
#define curVersion @"1.0"
@implementation UserInfo
#pragma mark super method
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _userId = [dic safeObjectForKey:keyOfUid];
        _userToken = [dic safeObjectForKey:keyOfUserToken];
    }
    return self;
}

#pragma mark pulbic method

- (UserInfoData *)publicInfo
{
    return [[UserInfoData alloc]initWithUID:self.userId token:self.userToken];
    
}

+(instancetype)newUserFromLocal
{
    UserInfo * newUser = nil;
    
    NSString * filePath = [self saveModelPath];
    NSFileManager* manager = [[NSFileManager alloc] init];
    if ([manager fileExistsAtPath:filePath])
    {
        // 从文件中解压获得本地保存的用户信息
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        newUser = [UserInfo modelFromDictionary:dict];
        [newUser updateWithVersion:newUser.versionNum];
    }
    if (nil == newUser)
    {
        // 本地部存在，构建一个默认的
        newUser = [[UserInfo alloc] init];
    }
    return newUser;
}


-(void)saveToLocal
{
    NSString *filePath = [[self class] saveModelPath];
    NSFileManager *manager = [[NSFileManager alloc]init];
    //删除原来的文件
    if([manager removeItemAtPath:filePath error:nil]){
        filePath = [[FileManager shareManager] filePath:UserSaveFileName inPart:FMPart_User forType:FM_UserDataByShare];
    }
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict safeSetObject:self.userId forKey:keyOfUid];
    [dict safeSetObject:self.userToken forKey:keyOfUserToken];
    [dict safeSetObject:curVersion forKey:keyOfVersion];
    [dict writeToFile:filePath atomically:YES];
}

+(BOOL)removeLocalUserInfo
{
    NSString *filePath = [[self class] saveModelPath];
    NSFileManager* manager = [[NSFileManager alloc] init];
    return [manager removeItemAtPath:filePath error:nil];
}

#pragma mark private method
+(NSString *)saveModelPath
{
    NSString *filePath = [[FileManager shareManager]filePath:UserSaveFileName inPart:FMPart_User forType:FM_UserDataByShare];
    return filePath;
}

-(void)updateWithVersion:(NSString *)lastVersion
{
    if (!lastVersion) {
        lastVersion = @"0.0";
    }
    double versionnum = [lastVersion doubleValue];
    double recard     = [curVersion doubleValue];
    if (versionnum < recard && recard - versionnum == 1) {
        self.userId       = nil;
        self.userToken    = nil;
    }
    [self saveToLocal];
}
@end
