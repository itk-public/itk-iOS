//
//  WTPersistenceCenter.m
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "WTPersistenceCenter.h"
#import "WTPersistenceCenter.h"
#import "FileManager.h"
#import "NSUserDefaults+BSCategory.h"
//#import "NSMutableDictionary+BSCategory.h"

NSString *const KContactTel  = @"contacttel";
NSString *const KContactName = @"contactname";

NSString *const KLuaVersionDictKey  = @"lv";
NSString *const KVerInLuaVerDictKey = @"ver";
NSString *const KAppVerInLuaVerDictKey = @"appVer";

@implementation WTPersistenceCenter
#pragma mark -
#pragma mark -- public
+ (void)storeInfo:(id )info key:(NSString *)key type:(PersistenceType)type
{
    if (type == PersistenceUserDefault) {
        [[NSUserDefaults standardUserDefaults] setObject:info forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }if (type == PersistenceLocal) {
        return [self setlocalObject:info forKey:key];
    }else if (type == PersistenceKeyChain){
        return [self setKeychainObject:info forKey:key];
    }
}

+ (void)removeInfo:(NSString *)key type:(PersistenceType)type
{
    if (type == PersistenceUserDefault) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }if (type == PersistenceLocal) {
        return [self removeLocalObjectForKey:key];
    }else if (type == PersistenceKeyChain){
        return [self removeKeychainObjectForKey:key];
    }
}

+ (id)getInfo:(NSString *)key type:(PersistenceType)type
{
    if (type == PersistenceUserDefault) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        return [defaults bsSafeObjectForKey:key];
    }if (type == PersistenceLocal) {
        return [self getLocalObjectForKey:key];
    }else if (type == PersistenceKeyChain){
        return [self getKeychainObjectForKey:key];
    }
    
    return nil;
}

#pragma mark -
#pragma mark -- keychain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)setKeychainObject:(id)info forKey:(NSString *)key
{
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:info] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}


+ (id)getKeychainObjectForKey:(NSString *)key
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", key, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
    
}


+ (void)removeKeychainObjectForKey:(NSString *)key
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

#pragma mark - local file
static NSMutableDictionary * g_localConfig = nil;
+ (NSString *)configPath
{
    NSString * fileName = @"mvconfig.plist";
    return [[FileManager shareManager] filePath:fileName inPart:FMPart_GeneralConfig forType:FM_APPFileByPreseist];
}

+ (NSMutableDictionary *)localConfig
{
    if (g_localConfig) {
        return g_localConfig;
    }
    // 读取文件
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath:[self configPath]])
    {
        g_localConfig =  [NSMutableDictionary dictionary];
    }else{
        g_localConfig =   [[NSMutableDictionary alloc] initWithContentsOfFile:[self configPath]];
    }
    return g_localConfig;
}

+ (void)saveLocalInfoToPresistFile:(NSDictionary *)localConfig
{
    NSString * filePath = [self configPath];
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    //    {
    //        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    //    }
    // 存放数据到持久化文件
    [localConfig writeToFile:filePath atomically:YES];
}

+ (void)setlocalObject:(id)info forKey:(NSString *)key
{
    NSMutableDictionary * localInfo = [self localConfig];
    [localInfo safeSetObject:info forKey:key];
    [self saveLocalInfoToPresistFile:localInfo];
}

+ (void)removeLocalObjectForKey:(NSString *)key
{
    NSMutableDictionary * localInfo = [self localConfig];
    [localInfo removeObjectForKey:key];
    [self saveLocalInfoToPresistFile:localInfo];
}

+ (id)getLocalObjectForKey:(NSString *)key
{
    NSMutableDictionary * localInfo = [self localConfig];
    return [localInfo safeObjectForKey:key];
}

#pragma mark -
#pragma mark -- lua

+ (NSDictionary *)luaVersionInfo
{
    id info =  [self getInfo:KLuaVersionDictKey type:PersistenceLocal];
    if (info) {
        if ([info isKindOfClass:[NSDictionary class]]) {
            NSString * appVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
            if ([[info valueForKey:KAppVerInLuaVerDictKey] isEqualToString:appVer] == NO) {
                // clean old version info
                [self removeInfo:KLuaVersionDictKey type:PersistenceLocal];
                return nil;
            }
        }else {
            // clean old version info
            [self removeInfo:KLuaVersionDictKey type:PersistenceLocal];
            return nil;
        }
    }
    return info;
}

+ (NSString*)getLuaVersion
{
    NSDictionary * verDict = [self luaVersionInfo];
    return [verDict objectForKey:KVerInLuaVerDictKey];
}

+ (void)setLuaVersion:(NSString*)lv
{
    if (lv.length <= 0)
    {
        [self removeInfo:KLuaVersionDictKey type:PersistenceLocal];
    }else{
        NSMutableDictionary * luaVersionDict = nil;
        if ([self luaVersionInfo]) {
            luaVersionDict = [NSMutableDictionary dictionaryWithDictionary:[self luaVersionInfo]];
        }else{
            NSString * appVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
            luaVersionDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:appVer,KAppVerInLuaVerDictKey,nil];
        }
        [luaVersionDict setObject:lv forKey:KVerInLuaVerDictKey];
        [self storeInfo:luaVersionDict key:KLuaVersionDictKey type:PersistenceLocal];
    }
}
@end

