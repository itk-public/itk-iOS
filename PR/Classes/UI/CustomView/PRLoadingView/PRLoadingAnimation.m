//
//  PRLoadingAnimation.m
//  PR
//
//  Created by 黄小雪 on 09/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PRLoadingAnimation.h"
#import "UIView+Category.h"
#import "AppUIUtil.h"
#import "FruitJumLoadingView.h"
#import "SceneMananger.h"

#define DEFAULT_ANIMATION_DURATION 1.8
#define kLoadingViewTag 10001

@implementation PRLoadingAnimation
+(instancetype)sharedInstance
{
    static PRLoadingAnimation *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PRLoadingAnimation alloc]init];
    });
    return instance;
}

-(void)addLoadingAnimationOnView:(UIView *)view
{
    CONDITION_CHECK_RETURN([view findASubViewWithTag:kLoadingViewTag] == nil);
    FruitJumLoadingView *coverView = [[FruitJumLoadingView alloc]initWithFrame:view.frame];
    coverView.tag                  = kLoadingViewTag;
    [coverView startLoading];
    [view addSubview:coverView];
}

-(void)addLoadingAnimationOnView:(UIView *)view afterDelay:(NSTimeInterval)delay
{
    CONDITION_CHECK_RETURN([view findASubViewWithTag:kLoadingViewTag] == nil);
    FruitJumLoadingView *coverView = [[FruitJumLoadingView alloc]initWithFrame:view.frame];
    coverView.tag                  = kLoadingViewTag;
    coverView.hidden               = YES;
    [view addSubview:coverView];
    [view bringSubviewToFront:coverView];
    [self performSelector:@selector(delayStart:) withObject:view afterDelay:delay];
}

-(void)delayStart:(UIView *)view
{
    CONDITION_CHECK_RETURN([view findASubViewWithTag:kLoadingViewTag] != nil);
    UIView *converView = [view findASubViewWithTag:kLoadingViewTag];
    if ([converView isKindOfClass:[FruitJumLoadingView class]]) {
        converView.hidden = NO;
        [(FruitJumLoadingView *)converView startLoading];
    }
}

-(void)addUnableTouchLoadingAnimationOnView:(UIView *)view
{
    CONDITION_CHECK_RETURN([view findASubViewWithTag:kLoadingViewTag] == nil);
    
    UIView *coverView = [[UIView alloc]initWithFrame:view.bounds];
    coverView.tag     = kLoadingViewTag;
    coverView.userInteractionEnabled = YES;
    coverView.backgroundColor = [UIColor clearColor];
    coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    FruitJumLoadingView *activityView = [[FruitJumLoadingView alloc]initWithFrame:view.frame];
    [coverView addSubview:activityView];
    [activityView startLoading];
    [view addSubview:coverView];
}

-(void)addUnableTouchLoadingAnimationOnView:(UIView *)view withTips:(NSString *)tips
{
    if ([view findASubViewWithTag:kLoadingViewTag]) {
        UIView *coverView = [view findASubViewWithTag:kLoadingViewTag];
        if ([[[coverView subviews] firstObject] isKindOfClass:[FruitJumLoadingView class]]) {
            [(FruitJumLoadingView *)[[coverView subviews]firstObject]  changeTips:tips];
        }
        return;
    }
    
    UIView *coverView = [[UIView alloc]initWithFrame:view.bounds];
    coverView.tag     = kLoadingViewTag;
    coverView.userInteractionEnabled = YES;
    coverView.backgroundColor        = [UIColor clearColor];
    coverView.autoresizingMask       = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    /*
     // 显示Loading 图标
     LoadingIndicator * activityView  = [[LoadingIndicator alloc] init];
     activityView.center              = coverView.center;
     [coverView addSubview:activityView];
     [activityView startAnimating];
     activityView.autoresizingMask    = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
     */
    FruitJumLoadingView * activityView = [[FruitJumLoadingView alloc] initWithFrame:view.frame];
    coverView.tag                      = kLoadingViewTag;
    [coverView addSubview:activityView];
    [activityView startLoadingWithTips:tips?:@""];
    [view addSubview:coverView];

    
}


- (void)removeLoadingAnimation:(UIView *)view
{
    CONDITION_CHECK_RETURN([view findASubViewWithTag:kLoadingViewTag] != nil);
    UIView *coverView = [view findASubViewWithTag:kLoadingViewTag];
    [UIView animateWithDuration:0.3
                     animations:^{
                         coverView.alpha = 0;
                     } completion:^(BOOL finished) {
                         if (coverView && [coverView isKindOfClass:[FruitJumLoadingView class]]) {
                             [(FruitJumLoadingView *)coverView stopLoading];
                         }
                         [coverView removeFromSuperview];
                     }];
}

- (void)removeAllLoadingAnimtion
{
    SceneMananger *sm = [SceneMananger shareMananger];
    UIView *tView = sm.visibleViewController.view;
    if (tView) {
        if ([tView findASubViewWithTag:kLoadingViewTag] != nil) {
            UIView *coverView = [tView findASubViewWithTag:kLoadingViewTag];
            [UIView animateWithDuration:0.3
                             animations:^{
                                 coverView.alpha = 0;
                             } completion:^(BOOL finished) {
                                 if (coverView && [coverView isKindOfClass:[FruitJumLoadingView class]]) {
                                     [(FruitJumLoadingView *)coverView stopLoading];
                                 }
                                 [coverView removeFromSuperview];
                             }];
        }
        for (UIView *subView in tView.subviews) {
            if ([subView isKindOfClass:[UITableView class]]) {
                if ([subView findASubViewWithTag:kLoadingViewTag] != nil) {
                    UIView *coverView = [subView findASubViewWithTag:kLoadingViewTag];
                    [UIView animateWithDuration:0.3
                                     animations:^{
                                         coverView.alpha = 0;
                                     } completion:^(BOOL finished) {
                                         if (coverView && [coverView isKindOfClass:[FruitJumLoadingView class]]) {
                                             [(FruitJumLoadingView *)coverView stopLoading];
                                         }
                                         [coverView removeFromSuperview];
                                     }];
                }
                return;
            }
        }
    }
}

- (void)showStatusBarLoading
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)hideStatusBarLoading
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end

