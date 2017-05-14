//
//  UIImage+Category.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

#pragma mark 把imgview变成圆形
-(UIImage *)drawCircleImgWithFrame:(CGRect)rect;

/**
 *  拉伸图片（拉伸图片的中间部分)
 *
 *  @param name
 *
 *  @return
 */
+ (UIImage *)resizableImage:(NSString *)name;

/**
 *  用于纯色图片直接变色
 *
 *  @param color 目标色
 *
 *  @return 变色后的图片
 */
- (UIImage *)changeImageWithColor:(UIColor *)color;

/**
 *  旋转图片
 *
 *  @param image
 *  @param orientation
 *
 *  @return
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

/**
 *  通过颜色生成纯色图片
 *
 *  @param color
 *
 *  @return
 */
+ (UIImage*) imageWithColor:(UIColor*)color;

- (UIImage *)imageFixOrientation;


@end
