//
//  SDImageViewShell.h
//  Fanli
//
//  Created by biqiang.lai on 18/7/14.
//  Copyright (c) 2014 www.fanli.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "UIButton+WebCache.h"
#import "AutoOptionURL.h"

@interface SDWebImageLibraryManager : NSObject
+ (void)initLibrary;
@end


@interface UIImageView (SDImageViewShell)
- (void)op_setImageWithURL:(NSURL *)url;
- (void)op_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

/**
 *  优化级函数，增加对网络资源的优化。
 *  更加当前网络情况使用不同的链接请求不同的图片，以达到节约网络资源的目的
 *
 *  @param wifiUrl WiFi 模式下使用的 图片URL
 *  @param wwanUrl 移动网络下使用的 图片URL
 */
- (void)op_setImageWithWifiURL:(NSURL *)wifiUrl  andWWANURL:(NSURL *)wwanUrl;
/**
 *  同样是优化级函数，可以指定加载 AutoOptionURL 对象
 *  以及默认的图片
 *
 *  @param optionUrl        不同网络下得URL 数据对象
 *  @param placeholderImage 默认图片
 */
- (void)op_setImageWithAutoOptionURL:(AutoOptionURL *)optionUrl placeholderImage:(UIImage *)placeholderImage;
@end
