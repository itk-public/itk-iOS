//
//  PRShowToastUtil.m
//  PR
//
//  Created by 黄小雪 on 05/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PRShowToastUtil.h"
#import "AppUIUtil.h"

@implementation PRShowToastUtil

static BOOL hudShowed = NO;
static UIView *hudView = nil;

+ (void)showNotice:(NSString *)s{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [self showNotice:s inView:window];
}

+ (void)showNotice:(NSString *)s inView:(UIView *)view
{
    float delay = 1;
    if (s.length > 10)
        delay = 2.5;
    else if (s.length > 15)
        delay = 3.5;
    [self showNotice:s inView:view duration:delay completion:nil];
}

+ (void)showNotice:(NSString *)s inView:(UIView *)view duration:(NSTimeInterval)duration
{
    [self showNotice:s inView:view duration:duration completion:nil];
}

+ (void)showNotice:(NSString *)s inView:(UIView *)view duration:(NSTimeInterval)duration completion:(void(^)(void))completion
{
    if (hudView.superview) {
        [hudView removeFromSuperview];
        hudView = nil;
    };
    
    UILabel *cus = [[UILabel alloc] init];
    cus.frame = CGRectZero;
    cus.numberOfLines = 0;
    cus.textAlignment = NSTextAlignmentCenter;
    cus.backgroundColor = [UIColor clearColor];
    cus.textColor = [UIColor whiteColor];
    cus.font = [UIFont fontWithName:@"Helvetica" size:15];
    CGSize maxsize = CGSizeMake(280, 1500);
    
    
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:15]};
    CGSize size = [s boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    cus.frame  = CGRectMake(0, 0, size.width, size.height);
    cus.text = s;
    
    CGFloat margin = 10;
    UIView *background  = [[UIView alloc] initWithFrame:CGRectZero];
    [background setFrame:CGRectMake(0, 0, cus.bounds.size.width + margin * 2, cus.bounds.size.height + margin *2)];
    CGPoint center = view.center;
    
    if ([view isKindOfClass:[UIWindow class]]) {
        
    }else{
        center.y -= -20;
    }
    
    [background setCenter:CGPointMake(center.x, view.height * 0.458)];  // center
    [background setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.78]];
    [background.layer setCornerRadius:5];
    [background.layer setOpacity:0.0];
    
    // 传说中黄金比例
    [cus setCenter:CGPointMake(background.bounds.size.width / 2, background.bounds.size.height / 2)];
    [background addSubview:cus];
    
    hudView = background;
    [view insertSubview:hudView atIndex:view.subviews.count];
    
    hudView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    hudShowed = YES;
    [self performBlock:^{
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             hudView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                             [hudView.layer setOpacity:0.9];
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseIn
                                              animations:^{
                                                  hudView.transform = CGAffineTransformMakeScale(1, 1);
                                                  [hudView.layer setOpacity:0.8];
                                              } completion:^(BOOL finished) {
                                                  // 延迟移出
                                                  [self performBlock:^{
                                                      [UIView animateWithDuration:0.3
                                                                            delay:0 options:UIViewAnimationOptionCurveEaseInOut
                                                                       animations:^{
                                                                           hudView.transform = CGAffineTransformMakeScale(0.001, 0.001);
                                                                           [hudView.layer setOpacity:0.0];
                                                                       } completion:^(BOOL finished) {
                                                                           
                                                                           if (completion != nil)
                                                                               completion();
                                                                           [hudView removeFromSuperview];
                                                                           hudShowed = NO;
                                                                       }];
                                                  } afterDelay:duration cancelPreviousOperation:YES];
                                              }];
                             
                         }];
    } afterDelay:0 cancelPreviousOperation:YES];
}

+ (void)delayedAddOperation:(NSOperation *)operation {
    [[NSOperationQueue currentQueue] addOperation:operation];
}

+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(delayedAddOperation:)
               withObject:[NSBlockOperation blockOperationWithBlock:block]
               afterDelay:delay];
}

+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay cancelPreviousOperation:(BOOL)cancel {
    if (cancel) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }
    [self performBlock:block afterDelay:delay];
}


@end
