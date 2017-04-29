//
//  UIView+Category.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
- (id)initWithMainFrame;
+ (CGRect)mainFrame;

+ (CGRect)fullScreenBound;
+ (CGRect)navigationControllerBound;
+ (CGRect)tabBarNavigationBound;

- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (void)setLeft:(CGFloat)left;
- (void)setRight:(CGFloat)right;
- (void)setBottom:(CGFloat)bottom;
- (void)setSize:(CGSize)size;
- (void)setTop:(CGFloat)top;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setOrigin:(CGPoint)point;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen;


#pragma mark 给边框设置颜色
-(void)addColorToBorder:(UIColor *)color;
#pragma mark 加圆角效果
+(void)CircularbeadInView:(UIView *)view color:(UIColor *)color;


+(void)CircularbeadInView:(UIView *)view color:(UIColor *)color BorderWidth:(CGFloat)width;

- (UIView *)findFirstResponder;
@end
