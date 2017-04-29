//
//  PRLoadingAnimation.h
//  PR
//
//  Created by 黄小雪 on 09/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PRLoadingAnimation : NSObject
DEF_SINGLETON(PRLoadingAnimation)

-(void)addLoadingAnimationOnView:(UIView *)view;  //view为nil 则加到window上
-(void)addUnableTouchLoadingAnimationOnView:(UIView *)view;
-(void)addUnableTouchLoadingAnimationOnView:(UIView *)view withTips:(NSString *)tips;
-(void)addLoadingAnimationOnView:(UIView *)view afterDelay:(NSTimeInterval)delay;
-(void)removeLoadingAnimation:(UIView *)view;
-(void)removeAllLoadingAnimation;

//状态栏上的indicator控制
-(void)showStatusBarLoading;
-(void)hideStatusBarLoading;
@end
