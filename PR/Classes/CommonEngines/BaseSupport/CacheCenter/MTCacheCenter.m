//
//  MTCacheCenter.m
//  PR
//
//  Created by 黄小雪 on 12/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "MTCacheCenter.h"
#import "FileManager.h"

#define kCacheVersion     @"1.0"
static NSString *const kCachePrefix      = @"ch";
static NSString *const kSubNameExtention = @"cache";

NSString *const VerElementHomeData       = @"0.0";
NSString *const VerElementCategoryData   = @"0.1";
NSString *const VerElementCartData       = @"0.1";
NSString *const VerElementSearchHistory  = @"0.0";

@implementation MTCacheVersionRecode

+ (NSString *)innerVersion:(MTCacheElement)elemtent
{
    switch (elemtent) {
        case MTCacheElementHomeData:
        {
            return VerElementHomeData;
        }
        case MTCacheElementCartData:
        {
            return VerElementCartData;
        }
        case MTCacheElementCategoryData:
        {
            return VerElementCategoryData;
        }
        case MTCacheElementSearchHistory:
        {
            return VerElementSearchHistory;
        }
        default:
        break;
    }
    
    return nil;
}

+ (NSString *)versionForElement:(MTCacheElement)elemtent
{
    NSString * elementVersion = [self innerVersion:elemtent];
    if ([elementVersion  floatValue] > 0.0) {
        return elementVersion;
    }
    return nil;
}


@end

@implementation MTCacheCenter
/*
 *如果一个元素有多个实例要归档，指定不同的subName
 */
+(BOOL)saveElement:(id)obj
       elementName:(MTCacheElement)element
           subName:(NSString*)subName
        completion:(MTCacheFinishHandler)completion
{
    CONDITION_CHECK_RETURN_VAULE(element != MTCacheElementNone,NO);
    CONDITION_CHECK_RETURN_VAULE(obj != nil, NO);
    
    NSString * elementVer = [MTCacheVersionRecode versionForElement:element];
    dispatch_queue_t cacheQueue = [self cacheQueue];
    
    dispatch_barrier_async(cacheQueue, ^{
        @autoreleasepool {
            if (obj) {
                NSString* filePath = [self localFilePath:element version:elementVer subName:subName];
                
                NSFileManager* fileManager = [NSFileManager defaultManager];
                
                NSString* basePath = [filePath stringByDeletingLastPathComponent];
                NSString* noSubCacheFile = nil;
                BOOL isDirectory = NO;
                BOOL isFileExist = [fileManager fileExistsAtPath:basePath isDirectory:&isDirectory];
                if (isFileExist && NO == isDirectory)
                {
                    // 出现了同名的文件，那么就把这个文件扔进sub文件夹中
                    noSubCacheFile = [NSString stringWithFormat:@"%@_",basePath];
                    [fileManager moveItemAtPath:basePath toPath:noSubCacheFile error:nil];
                }
                
                if (NO == isFileExist)
                {
                    [fileManager createDirectoryAtPath:basePath withIntermediateDirectories:YES attributes:nil error:nil];
                    if (noSubCacheFile) {
                        NSString * newPlaceToNoSub = [basePath stringByAppendingPathComponent:[basePath lastPathComponent]];
                        [fileManager moveItemAtPath:noSubCacheFile toPath:newPlaceToNoSub error:nil];
                    }
                }
                
                if (isFileExist == YES && isDirectory == YES && [subName length] == 0) {
                    filePath = [filePath stringByAppendingPathComponent:[filePath lastPathComponent]];
                }
                [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
            }
            
            if (completion != NULL) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion();
                });
            }
        }
    });
    
    return YES;
    
}

/*
 * 获取缓存的cache对象
 */
+(BOOL)getElementByName:(MTCacheElement)element
                subName:(NSString*)subName
             completion:(MTCacheGetHandler)completion
{
    CONDITION_CHECK_RETURN_VAULE(completion, NO);
    CONDITION_CHECK_RETURN_VAULE(element != MTCacheElementNone, NO);
    
    NSString * elementVer = [MTCacheVersionRecode versionForElement:element];
    dispatch_queue_t cacheQueue = [self cacheQueue];
    dispatch_async(cacheQueue, ^{
        @autoreleasepool {
            NSString* path = [self localFilePath:element version:elementVer subName:subName];
            NSFileManager* fileManager = [NSFileManager defaultManager];
            BOOL isDir = NO;
            id result = nil;
            
            if ([fileManager fileExistsAtPath:path isDirectory:&isDir])
            {
                //如果没有子文件夹直接反归档
                //否则将子文件中后缀为kSubNameExtention的文件依次反归档，并放入数组返回
                if (!isDir)
                {
                    result = [self unarchiveObjectWithFile:path];
                }
                else
                {
                    if ([subName length] == 0) {
                        path = [path stringByAppendingPathComponent:[path lastPathComponent]];
                        result = [self unarchiveObjectWithFile:path];
                    }else{
                        NSMutableArray* objs = [NSMutableArray array];
                        NSArray* subPathes = [fileManager subpathsAtPath:path];
                        for (NSString* subPath in subPathes)
                        {
                            if ([[subPath pathExtension] isEqualToString:kSubNameExtention])
                            {
                                NSString* objPath = [path stringByAppendingPathComponent:subPath];
                                id obj = [self unarchiveObjectWithFile:objPath];
                                if (obj)
                                {
                                    [objs addObject:obj];
                                }
                            }
                        }
                        
                        if ([objs count] > 0)
                        {
                            result = [NSArray arrayWithArray:objs];
                        }
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(result);
            });
        }
    });
    
    return YES;
}


+(void)removeElement:(MTCacheElement)element
       beforeVersion:(NSString *)version
{
    NSError * error = nil;
    NSArray * allElments = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self fileDirectory] error:&error];
    for (NSString * aFilePath in allElments) {
        NSString * prefixName =  [kCachePrefix stringByAppendingPathExtension:[NSString stringWithFormat:@"%ld",(long)element]];
        NSRange findRange = [aFilePath rangeOfString:prefixName];
        if (findRange.length > 0) {
            NSString * verSuffix = [aFilePath substringFromIndex:findRange.location + findRange.length];
            if ([verSuffix length] == 0) {
                BOOL isClean = [[NSFileManager defaultManager] removeItemAtPath:[[self fileDirectory] stringByAppendingPathComponent:aFilePath] error:&error];
                if (isClean == NO) {
//                    YHLogVerbose(@"无法清理路径，%@",error);
                }
            }else{
                NSRange versionAppendRange = [verSuffix rangeOfString:@"_"];
                if (versionAppendRange.length > 0) {
                    NSString * savedFileVersion = [verSuffix substringFromIndex:versionAppendRange.location + versionAppendRange.length];
                    if (NO == [savedFileVersion isEqualToString:version]) {
                        BOOL isClean = [[NSFileManager defaultManager] removeItemAtPath:[[self fileDirectory] stringByAppendingPathComponent:aFilePath] error:&error];
                        if (isClean) {
//                            YHLogVerbose(@"无法清理路径，%@",error);
                        }
                    }
                }
            }
            
        }
    }
}

#pragma mark ---
#pragma mark private
+(dispatch_queue_t)cacheQueue
{
    static dispatch_queue_t queue = NULL;
    if (queue == NULL)
    {
        @synchronized([self class])
        {
            if (queue == NULL) {
                queue = dispatch_queue_create("cn.yonghui.hyd.cache",
                                              DISPATCH_QUEUE_CONCURRENT);
            }
        }
        
    }
    return queue;
}


+ (NSString*)fileDirectory
{
    return [[FileManager shareManager] filePath:kCacheVersion inPart:FMPart_ObjCache forType:FM_AppFileByCache];
}

+ (NSString*)localFilePath:(MTCacheElement)element version:(NSString *)version subName:(NSString*)subName
{
    NSString* name = [kCachePrefix stringByAppendingPathExtension:[NSString stringWithFormat:@"%ld",(long)element]];
    if ([version length] > 0) {
        name = [name stringByAppendingString:[NSString stringWithFormat:@"_%@",version]];
    }
    NSString* path = [[self fileDirectory] stringByAppendingPathComponent:name];
    
    if (subName.length > 0) {
        path = [[path stringByAppendingPathComponent:subName] stringByAppendingPathExtension:kSubNameExtention];
    }
    return path;
}


+ (id)unarchiveObjectWithFile:(NSString*)file
{
    if (file.length > 0 && [[NSFileManager defaultManager] fileExistsAtPath:file])
    {
        id result = nil;
        @try {
            result = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
        }
        @catch (NSException *exception) {
//            YHLogVerbose(@"attention , unarchiver failed !!!");
            result = nil;
        }
        @finally {
            return result;
        }
    }
    else
    {
        return nil;
    }
}


+(void)cleanAncientCache
{
    MTCacheElement element = 0;
    while (true) {
        NSString * elementVer = [MTCacheVersionRecode versionForElement:element];
        if (elementVer) {
            [self removeElement:element beforeVersion:elementVer];
        }
        element ++;
        if (element == MTCacheElementMax) {
            break;
        }
    }
}
@end
