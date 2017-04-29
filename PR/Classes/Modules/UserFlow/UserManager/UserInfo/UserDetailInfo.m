//
//  UserDetailInfo.m
//  PR
//
//  Created by 黄小雪 on 08/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "UserDetailInfo.h"
#import "FileManager.h"

NSString *keyOfUid     = @"userid";
NSString *keyOfToken   = @"usertoken";
NSString *keyOfVersion = @"infoVersion";

#define UserSaveFileName   @"uif.data"
#define curVersion @"1.0"
@implementation UserDetailInfo

+(NSString *)saveModelPath
{
    NSString *filePath = [[FileManager shareManager] filePath:UserSaveFileName inPart:FMPart_User forType:FM_UserDataByShare];
    return filePath;
}

-(UserInfoData *)publicInfo
{
    return [[UserInfoData alloc]initWithUID:self.userId token:self.userToken];
    
}

-(void)saveToLocal
{
    NSString *filePath = [[self class] saveModelPath];
    NSFileManager *manager = [[NSFileManager alloc]init];
    if ([manager removeItemAtPath:filePath error:nil]) {
        filePath = [[FileManager shareManager] filePath:UserSaveFileName inPart:FMPart_User forType:FM_UserDataByShare];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict safeSetObject:self.userId forKey:keyOfUid];
    [dict safeSetObject:self.userToken forKey:keyOfToken];
    [dict safeSetObject:curVersion forKey:keyOfVersion];
    [dict writeToFile:filePath atomically:YES];
}

+(BOOL)removeLocalUserInfo
{
    NSString *filePath = [[self class]saveModelPath];
    NSFileManager *manager = [[NSFileManager alloc]init];
    return [manager removeItemAtPath:filePath error:nil];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        _userId        = [dict safeObjectForKey:keyOfUid hintClass:[NSString class]];
        _userToken     = [dict safeObjectForKey:keyOfToken hintClass:[NSString class]];
        _versionNum    = [dict safeObjectForKey:keyOfVersion hintClass:[NSString class]];
    }
    
    return self;
    
}

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

-(void)updateWithVersion:(NSString *)lastVersion
{
    if (!lastVersion) {
        lastVersion = @"0.0";
    }
    double versionnum = [lastVersion doubleValue];
    double recard     = [curVersion doubleValue];
    if (versionnum < recard && recard - versionnum == 1) {
        if (!self.userId || !self.userToken) {
            self.userToken = nil;
            self.userId    = nil;
        }
    }
    [self saveToLocal];
}

+(instancetype)newUserFromLocal
{
    UserDetailInfo *newUser = nil;
    NSString *filePath = [self saveModelPath];
    NSFileManager *manager = [[NSFileManager alloc]init];
    if ([manager fileExistsAtPath:filePath]) {
        //从文件中解压获得本地保存的用户信息
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        newUser = [UserDetailInfo modelWithDict:dict];
        [newUser updateWithVersion:newUser.versionNum];
    }
    if (nil == newUser) {
        // 本地部存在，构建一个默认的
        newUser = [[UserDetailInfo alloc] init];
    }
    return newUser;
}
@end
