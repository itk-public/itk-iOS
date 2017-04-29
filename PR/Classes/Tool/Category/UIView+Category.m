//
//  UIView+Category.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

- (id)initWithMainFrame
{
    CGRect frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height  - 20 - 44);
    return [self initWithFrame:frame];
}

+ (CGRect)mainFrame
{
    return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20 - 44);
}

+ (CGRect)fullScreenBound{
    return [[UIScreen mainScreen] bounds];
}

+ (CGRect)navigationControllerBound{
    return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20 - 44);
}

+ (CGRect)tabBarNavigationBound{
    return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20 - 44 - 49);
}


- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)point
{
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}

#pragma mark - 判断view是否是在屏幕上
// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen
{
    if (self.superview == nil) {
        return NO;
    }
    
    if (self.hidden) {
        return NO;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect rect = [self.superview convertRect:self.frame toView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return NO;
    }
    
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  NO;
    }
    
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return NO;
    }
    
    return YES;
}

#pragma mark 给边框设置颜色
-(void)addColorToBorder:(UIColor *)color;{
    
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = color.CGColor;
}

#pragma mark 加圆角效果
+(void)CircularbeadInView:(UIView *)view color:(UIColor *)color;
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4.0;
    view.layer.borderWidth = (1/[UIScreen mainScreen].scale);
    
    view.layer.borderColor = color.CGColor;
}



+(void)CircularbeadInView:(UIView *)view color:(UIColor *)color BorderWidth:(CGFloat)width;
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 6.0;
    view.layer.borderWidth = width;
    
    view.layer.borderColor = color.CGColor;
}


- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}


@end
