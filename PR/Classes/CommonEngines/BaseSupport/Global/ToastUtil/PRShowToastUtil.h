//
//  PRShowToastUtil.h
//  PR
//
//  Created by 黄小雪 on 05/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PRShowToastUtil : NSObject

+ (void)showNotice:(NSString *)s inView:(UIView *)view;
+ (void)showNotice:(NSString *)s inView:(UIView *)view duration:(NSTimeInterval)duration;
+ (void)showNotice:(NSString *)s inView:(UIView *)view duration:(NSTimeInterval)duration completion:(void(^)(void))completion;

+ (void)showNotice:(NSString *)s;

@end
