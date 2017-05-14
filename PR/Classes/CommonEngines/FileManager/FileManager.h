//
//  FileManager.h
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FMTYPE)
{
    // 保存用户数据，用户可以共享查看，itunes 备份
    FM_UserDataByShare,
    
    // 保存 app 文件，对用户不可见，不保证会一直存在
    FM_AppFileByCache,
    
    // 保存 app 文件，对用户不可见，持久化存在，itunes 备份
    FM_APPFileByPreseist,
    
    // 本次启动流程临时文件，下次流程会被清除
    FM_TEMPFile,
};


// 由于模块多了以后，各个模块的文件存放会比较随意，后续难以看懂
// 因此这里申请文件时需要制定归属的模块。
extern NSString * const FMPart_User;
extern NSString * const FMPart_ObjCache;
extern NSString * const FMPart_GeneralConfig;
extern NSString * const FMPart_Patch;


@interface FileManager : NSObject
+ (FileManager *)shareManager;

/**
 *  获取一个文件的存储路径
 *
 *  @param fileName 文件夹或者文件名
 *  @param partInfo 归属的part路径，part的定义参考上方的 FMPart_
 *  @param type     需要存放的文件类型，类型参考 FMTYPE
 *
 *  @return 返回一个文件路径
 */
- (NSString *)filePath:(NSString *)fileName inPart:(NSString *)partInfo forType:(FMTYPE)type;

/**
 *  清除缓存
 */
+(void)clearCache;
/**
 *  获取缓存大小
 *
 *  @return <#return value description#>
 */

+(NSString *)getCacheSize;
@end
