//
//  FileManager.m
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "FileManager.h"

NSString * const FMPart_User = @"fmUser";
NSString * const FMPart_ObjCache = @"fmCache";
NSString * const FMPart_GeneralConfig = @"fmConfig";
NSString * const FMPart_Patch = @"fmpatch";

@implementation FileManager

+ (FileManager *)shareManager
{
    static FileManager * theFileManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        theFileManager = [[FileManager alloc] init];
    });
    return theFileManager;
}


- (NSString *)baseFilePathForType:(FMTYPE)type
{
    switch (type)
    {
        case FM_UserDataByShare:
        {
            NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths1 objectAtIndex:0];
            return documentsDirectory;
        }
        case FM_AppFileByCache:
        {
            NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory] == NO)
            {
                NSError * error = nil;
                BOOL creatSuc =  [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory
                                                           withIntermediateDirectories:NO
                                                                            attributes:nil
                                                                                 error:&error];
                if (NO == creatSuc) {
//                    YHLogVerbose(@"create cache floder failed ,error %@",error);
                }
            }
            return documentsDirectory;
        }
        case FM_APPFileByPreseist:
        {
            NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory] == NO)
            {
                NSError * error = nil;
                BOOL creatSuc =  [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory
                                                           withIntermediateDirectories:NO
                                                                            attributes:nil
                                                                                 error:&error];
                if (NO == creatSuc) {
//                    YHLogVerbose(@"create FM_APPFileByPreseist floder failed ,error %@",error);
                }
            }
            return documentsDirectory;
        }
        case FM_TEMPFile:
        {
            NSString * tempFileDirctory = NSTemporaryDirectory();
            return tempFileDirctory;
        }
        default:
            break;
    }
    
    return nil;
}


- (NSString *)filePath:(NSString *)fileName inPart:(NSString *)partInfo forType:(FMTYPE)type
{
    NSString * thePath = [self baseFilePathForType:type];
    NSString * folderPath =  [thePath stringByAppendingPathComponent:partInfo];
    if ([[NSFileManager defaultManager] fileExistsAtPath:folderPath] == NO)
    {
        NSError * error = nil;
        BOOL creatSuc =  [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                                                   withIntermediateDirectories:NO
                                                                    attributes:nil
                                                                         error:&error];
        if (NO == creatSuc) {
//            YHLogVerbose(@"create folder failed ,error %@",error);
        }
    }
    
    return [folderPath stringByAppendingPathComponent:fileName];
}

#pragma mark 删除缓存的处理
/**
 *  获取cache的路径
 *
 *  @return <#return value description#>
 */
+ (NSString *)findCachePath {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return cachePath;
}

+ (unsigned long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
    
}
+ (float)folderSizeAtPath:(NSString *)path
{
#define  kBytesNumInM   1048576.0f
    NSFileManager *fileManager = [NSFileManager defaultManager];
    unsigned long long folderSize = 0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        return folderSize/ kBytesNumInM;
        
        
    }
    return 0.0f;
}

+(void)clearCache
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[self findCachePath]]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:[self findCachePath]];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath = [[self findCachePath] stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
        [fileManager removeItemAtPath:[self findCachePath] error:nil];
    }
}

+(NSString *)getCacheSize
{
    return [[NSString stringWithFormat:@"%.2f",[self folderSizeAtPath:[self findCachePath]]] isEqualToString:@"0.00"]?@"0.0":[NSString stringWithFormat:@"%.2f",[self folderSizeAtPath:[self findCachePath]]];
}

@end
