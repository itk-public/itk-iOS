//
//  AppURLCenter.h
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppURLCenter : NSObject
/**
 *  打开一个URL
 *
 *  @param originURL  需要打开的链接
 *
 *  @retur 是否打开URL成功
 */
+ (BOOL)openURL:(NSURL *)originURL;

/**
 *  处理App收到的URL
 *
 *  @param loadedURL 已经接受到的URL
 *
 *  @return App能否处理掉
 */
+ (BOOL)handleURL:(NSURL *)loadedURL;

@end
