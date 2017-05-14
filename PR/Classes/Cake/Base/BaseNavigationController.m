//
//  BaseNavigationController.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "BaseNavigationController.h"
#import "WTTabbarNotifyInterface.h"
#import "BaseViewController.h"
#import "HomeViewController.h"

@interface BaseNavigationController ()<UIViewControllerTransitioningDelegate,WTTabbarNotifyInterface>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarbg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage imageNamed:@"dotline"]];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
        [self.interactivePopGestureRecognizer addTarget:self action:@selector(panOnViewController:)];
        self.delegate                                 = self;
    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    YHLogVerbose(@"%@", viewController);
    if (self.topViewController && [self.topViewController isKindOfClass:[BaseViewController class]]) {
        BaseViewController *tTopVC = (BaseViewController *)self.topViewController;
        if (tTopVC.isAnimating) {
            return;
        }
        tTopVC.isAnimating = YES;
        if (viewController && [viewController isKindOfClass:[BaseViewController class]]) {
            BaseViewController *tVC = (BaseViewController *)viewController;
            tVC.isAnimating = YES;
        }
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    
    // 对于root的控制器，关闭动作识别
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = [self.viewControllers count] > 1;
    }
//    if ([viewController isKindOfClass:[PayFailViewController class]] || [viewController isKindOfClass:[PaySuccessViewController class]] || [viewController isKindOfClass:NSClassFromString(@"CSXPaySuccessViewController")]) {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    for (UIView * tV in fromVC.view.subviews) {
        if ([tV isKindOfClass:[UIScrollView class]]) {
            UIScrollView *tSV = (UIScrollView *)tV;
            if ([fromVC isKindOfClass:[HomeViewController class]]) {
                if ([tSV isKindOfClass:[UITableView class]]) {
                    [tSV setScrollEnabled:YES];
                }else{
                    [tSV setScrollEnabled:NO];
                }
            }else{
                [tSV setScrollEnabled:YES];
            }
        }
        if ([tV isKindOfClass:[UIWebView class]]) {
            UIWebView *tWV = (UIWebView *)tV;
            tWV.scrollView.scrollEnabled = YES;
        }
    }
    return nil;
}

- (void) panOnViewController : (UIGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.inTransition = YES;
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            self.inTransition = NO;
            break;
        default:
            break;
    }
}

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

#pragma mark - UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    if ([[[SceneMananger shareMananger] currentViewController] isKindOfClass:[YHLocationViewController class]] ||
//        [[[SceneMananger shareMananger] currentViewController] isKindOfClass:[ChooseCityViewController class]]) {
//        
//        if([[[SceneMananger shareMananger] currentViewController] isKindOfClass:[YHLocationViewController class]]){
//            
//            YHLocationViewController *vc = (YHLocationViewController *)[[SceneMananger shareMananger] currentViewController];
//            if ([vc isNeedCutTap]) {
//                return (gestureRecognizer == self.interactivePopGestureRecognizer && !self.inTransition);
//            }else{
//                return NO;
//            }
//        }else{
//            ChooseCityViewController *vc = (ChooseCityViewController *)[[SceneMananger shareMananger] currentViewController];
//            if ([vc isNeedCutTap]) {
//                return (gestureRecognizer == self.interactivePopGestureRecognizer && !self.inTransition);
//            }else{
//                return NO;
//            }
//        }
//    }else{
//        id topVC  = [[SceneMananger shareMananger] currentViewController];
//        if ([topVC conformsToProtocol:@protocol(YHNavigatorProtocol)] && [topVC respondsToSelector:@selector(canUserPopGesture)]) {
//            BOOL  canPop = [topVC canUserPopGesture];
//            if (canPop == NO) {
//                return NO;
//            }
//        }
//    }
    
    return (gestureRecognizer == self.interactivePopGestureRecognizer && !self.inTransition);
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    if ([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
        UIScrollView * tScrollView = (UIScrollView *)otherGestureRecognizer.view;
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            // 当top vc 包含一个table view时，
            // 用户快速上下滑动tableview，这个时候想要立马使用右滑返回是无效的，因为touch事件被scroll 抢走了
            // 因此这里需要 return YES
            // 至于 tScrollView.scrollEnabled 关闭又打开，是想立即停止scroll的滚动，让视觉效果上更符合人眼的预期
            tScrollView.scrollEnabled = NO;
            tScrollView.scrollEnabled = YES;
        }
        return YES;
    }
    return NO;
}

#pragma mark - refresh status
- (void)refreshActionTriggerByTabbar
{
    UIViewController * topSeriesVC = [self.viewControllers lastObject];
    if ([topSeriesVC conformsToProtocol:@protocol(WTTabbarNotifyInterface)]) {
        __weak id<WTTabbarNotifyInterface> theVC = (id)topSeriesVC;
        if ([theVC respondsToSelector:@selector(refreshActionTriggerByTabbar)]) {
            [theVC refreshActionTriggerByTabbar];
        }
    }
}

@end

