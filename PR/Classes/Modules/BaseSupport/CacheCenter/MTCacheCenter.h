//
//  MTCacheCenter.h
//  PR
//
//  Created by 黄小雪 on 12/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 不要修改值，因为归档时使用值为保存文件名称，
 * 如果修改值，可能会造成新老版本的兼容问题
 * 所以，如果修改，请增加新的枚举并增加值，或者升级缓存ver
 */
typedef NS_ENUM(NSInteger,MTCacheElement)
{
    MTCacheElementHomeData = 0,
    MTCacheElementCategoryData ,
    MTCacheElementCartData,
    MTCacheElementSearchHistory,
    MTCacheElementMax,
    MTCacheElementNone = INT32_MAX,
};


/**
 *  element的版本控制
 */
FOUNDATION_EXTERN  NSString *const VerElementHomeData;
FOUNDATION_EXTERN  NSString *const VerElementCategoryData;
FOUNDATION_EXTERN  NSString *const VerElementCartData;
FOUNDATION_EXTERN  NSString *const VerElementSearchHistory;

/**
 *  保存缓存完成后的处理block
 */
typedef void (^MTCacheFinishHandler)();

typedef void (^MTCacheGetHandler)(id cache);

@interface MTCacheVersionRecode : NSObject
+(NSString *)versionForElement:(MTCacheElement)elemtent;

@end


@interface MTCacheCenter : NSObject
/*
 * 异步在缓存线程中处理保存缓存
 *@param saveElement 保存的对象
 *@param elementName 保存的类型
 *@param subNam 保存的子名称，如果没有指定，则一个elementName保存对应的是一个文件，如果有指定，则对应的是一个文件夹，文件夹下有与subName相关联的子文件
 *@param completion 缓存完成后执行的block，在主线程中处理
 *@return 参数是否正确
 */

+(BOOL)saveElement:(id)obj
       elementName:(MTCacheElement)element
           subName:(NSString *)subName
        completion:(MTCacheFinishHandler)completion;

/*
 * 异步获取缓存数据,会回到主线程
 * 如果该element保存的是多个对象，则返回数组
 * 如果subName不为nil，则返回指定的子类型
 * @return 参数是否正确
 */

+(BOOL)getElementByName:(MTCacheElement)element
                subName:(NSString *)subName
             completion:(MTCacheGetHandler)completion;

+(void)cleanAncientCache;
@end
