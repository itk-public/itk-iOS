//
//  SceneMananger.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "SceneMananger.h"
#import "BaseViewController.h"
#import "ServiceCenter.h"
#import "PRShowToastUtil.h"
#import "PRControlCenter.h"
#import "AppDelegate.h"
#import "NSString+Category.h"
#import "WTPersistenceCenter.h"
#import "LoginViewController.h"


@interface SceneMananger()

@property(nonatomic,copy) LOGINCALLBACK					loginCallBack;
@property (strong,nonatomic) LoginViewController        *loginVC;

@end

@implementation SceneMananger
IMP_SINGLETON

+ (id)shareMananger
{
    return [[ServiceCenter defaultCenter] standardSceneManager];
}

-(void)popCurrentViewControllerUnderAnimation:(BOOL)animate
{
    UINavigationController * tempNavigationController = nil;
    // 根据可视viewController
    UIViewController * tempVisibleVC                  = self.visibleViewController;
    if (tempVisibleVC) {
        UIViewController * tNaviVC    = tempVisibleVC.navigationController;
        if (tNaviVC && [tNaviVC isKindOfClass:[UINavigationController class]]) {
            tempNavigationController  = (UINavigationController *)tNaviVC;
        }
    }else{
        PRLOG(@"获取当前可视view controller错误");
        return;
    }
    if (!tempNavigationController) {
        [PRShowToastUtil showNotice:@"没有获取到UINavigationController"];
        return;
    }
    [tempNavigationController popViewControllerAnimated:animate];
}

-(void)popCurrentViewController
{
    [self popCurrentViewControllerUnderAnimation:YES];
}

-(void)popToTargetViewController:(Class)vcClass
{
    UINavigationController * tempNavigationController = nil;
    // 根据可视viewController
    UIViewController * tempVisibleVC                  = self.visibleViewController;
    if (tempVisibleVC) {
        UIViewController * tNaviVC    = tempVisibleVC.navigationController;
        if (tNaviVC && [tNaviVC isKindOfClass:[UINavigationController class]]) {
            tempNavigationController  = (UINavigationController *)tNaviVC;
        }
    }else{
        PRLOG(@"获取当前可视view controller错误");
    }
    UIViewController * jumpToVC = nil;
    if (tempNavigationController) {
        NSArray * vcArr = tempNavigationController.childViewControllers;
        for (UIViewController *tempVC in vcArr) {
            if ([tempVC isKindOfClass:vcClass]) {
                jumpToVC = tempVC;
                break;
            }
        }
    }
    if (jumpToVC) {
        [tempNavigationController popToViewController:jumpToVC animated:YES];
    }
}

-(id)lastViewController
{
    return [self getViewControllerOfIndex:1];
}


- (UIViewController *)previewVisiableViewController
{
    NSInteger preIndex = 1;
    while (true) {
        UIViewController * vc = [self getViewControllerOfIndex:preIndex];
        if (vc == nil) {
            break;
        }
        
        if (NO == [vc isKindOfClass:[BaseViewController class]]) {
            return vc;
        }else{
            if ([(BaseViewController *)vc availableInNavgationStack] == YES) {
                return  vc;
            }
        }
        preIndex ++ ;
    }
    
    return nil;
}

-(BaseViewController *)currentViewController;
{
    return [self getViewControllerOfIndex:0];
}

-(BaseViewController *)getViewControllerOfIndex:(NSInteger)index
{
    UINavigationController * tempNavigationController = nil;
    // 根据可视viewController
    UIViewController * tempVisibleVC                  = self.visibleViewController;
    if (tempVisibleVC) {
        UIViewController * tNaviVC    = tempVisibleVC.navigationController;
        if (tNaviVC && [tNaviVC isKindOfClass:[UINavigationController class]]) {
            tempNavigationController  = (UINavigationController *)tNaviVC;
        }
    }else{
//        YHLogVerbose(@"获取当前可视view controller错误");
        return nil;
    }
    if (!tempNavigationController) {
        [PRShowToastUtil
         showNotice:@"没有获取到UINavigationController"];
        return nil;
    }
    NSInteger childCount = [tempNavigationController.childViewControllers count];
    if (childCount > index) {
        return [tempNavigationController.childViewControllers objectAtIndex:childCount -(index + 1)];
    }else{
        return nil;
    }
    
}


- (void)showViewController:(UIViewController*)vc withStyle:(U_SCENE_SHOW_STYLE)s
{
    if (!vc) {
        [PRShowToastUtil showNotice:@"传入的UIViewController为nil"];
        return;
    }
    
    [self checkNeedLogin:vc callback:^(BOOL suc) {
        if (suc) {
            UINavigationController * tempNavigationController   = nil;
            // 根据可视viewController
            UIViewController * tempVisibleVC = self.visibleViewController;
            if (tempVisibleVC) {
                UIViewController * tNaviVC = tempVisibleVC.navigationController;
                if (tNaviVC && [tNaviVC isKindOfClass:[UINavigationController class]]) {
                    tempNavigationController = (UINavigationController *)tNaviVC;
                }
            }else{
                PRLOG(@"获取当前可视view controller错误");
                return;
            }
            
            
            if (!tempNavigationController) {
                [PRShowToastUtil showNotice:@"没有获取到UINavigationController"];
                return;
            }
            
            // 根据style ,push 或者 present vc.
            switch (s) {
                case U_SCENE_SHOW_DEFAULT:
                {
                    // ???: 默认的情况为PUSH吗
                    [tempNavigationController pushViewController:vc animated:YES];
                    break;
                }
                case U_SCENE_SHOW_PUSH:
                {
                    [tempNavigationController pushViewController:vc animated:YES];
                    break;
                }
                case U_SCENE_SHOW_PUSH_NO_ANIMATION:
                {
                    [tempNavigationController pushViewController:vc animated:NO];
                    break;
                }
                case U_SCENE_SHOW_PRESENT:
                {
                    [tempNavigationController presentViewController:vc animated:YES completion:^{
                        // TODO:
                    }];
                    break;
                }
                case U_SCENE_SHOW_ADDTOWINDOW:
                {
                    [PRShowToastUtil showNotice:@"U_SCENE_SHOW_ADDTOWINDOW方式待确认"];
                    break;
                }
                case U_SCENE_SHOW_PRESENT_OVER_CURRENT_CONTEXT:
                {
                    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    vc.modalTransitionStyle   = UIModalTransitionStyleCrossDissolve;
                    [tempNavigationController presentViewController:vc animated:YES completion:nil];
                    break;
                }
                default:
                    break;
            }
            
        }
    }];
    
}


- (void)dismissModelViewController:(UIViewController *)modelVC
                        completion:(void (^)(void))completion
{
//    LoginNavigationController *nav = (LoginNavigationController *)modelVC.navigationController;
//    UIViewController* parentVC =nav
//    .presentingViewController;
//    [parentVC dismissViewControllerAnimated:YES completion:completion];
    
    
}

- (NSArray *)navigationStack{
    
    NSArray * stack             = nil;
    if (self.rootViewController && [self.rootViewController isKindOfClass:[UINavigationController class]]) {
        stack                   = [(UINavigationController *)self.rootViewController viewControllers];
    }
    
    return stack;
}

#pragma mark - setter/getter
- (UIWindow *)window{
    if (nil == _window) {
        
        //UIWindow * keyWindow    = [UIApplication sharedApplication].keyWindow;
        UIWindow * keyWindow = [(AppDelegate *)[[UIApplication sharedApplication] delegate] window];
        if (!keyWindow) {
            keyWindow           = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [keyWindow makeKeyAndVisible];
        }
        
        self.window             = keyWindow;
    }
    
    return _window;
}

- (UIViewController *)rootViewController
{
    if (nil == _rootViewController) {
        _rootViewController = [[PRControlCenter sharedInstance] rootViewController];
    }
    return _rootViewController;
    
}

- (UIViewController *)topViewController
{
    UIViewController * controller = nil;
    if (self.rootViewController && [self.rootViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController * midVC      = [(UITabBarController *)self.rootViewController selectedViewController];
        if (midVC && [midVC isKindOfClass:[UINavigationController class]]) {
            controller                    = [(UINavigationController *)midVC topViewController];
        }
    }
    return controller;
}

- (UIViewController *)visibleViewController
{
    UIViewController * controller = nil;
    if (self.rootViewController) {
        if ( [self.rootViewController isKindOfClass:[UITabBarController class]]) {
            UIViewController * midVC = [(UITabBarController *)self.rootViewController selectedViewController];
            if (midVC && [midVC isKindOfClass:[UINavigationController class]]) {
                controller = [(UINavigationController *)midVC visibleViewController];
            }
        }else if ([self.rootViewController isKindOfClass:[UINavigationController class]])
        {
            controller = [(UINavigationController *)self.rootViewController visibleViewController];
        }
        
    }
    return controller;
}

- (void)setupRootViewController{
    self.rootViewController         = [[PRControlCenter sharedInstance] rootViewController];
    self.window.rootViewController  = self.rootViewController;
    [self.window makeKeyAndVisible];
}

@end


#import "BaseViewController.h"
#import "UserManager.h"
#import "AppDelegate.h"

@implementation SceneMananger(login)
- (void)checkNeedLogin:(UIViewController *)vc callback:(void (^)(BOOL suc))callback
{
    BOOL isNeedLogin = NO;
    
    if ([vc isKindOfClass:[BaseViewController class]]) {
        BaseViewController * baseVC = (BaseViewController *)vc;
        isNeedLogin = baseVC.needLogin;
    }
    if (NO == isNeedLogin || [[UserManager shareMananger] isUserLogin]) {
        if (callback) {
            callback(YES);
        }
    }else{
        [self showLoginViewWithCallback:callback];
    }
}

- (void)showLoginViewWithCallback:(LOGINCALLBACK)callback
{
    if ([[UserManager shareMananger] isUserLogin]) {
        if (callback) {
            callback(YES);
        }
    }else{
        if (self.loginVC == nil) {
            self.loginVC = [[LoginViewController alloc]init];
        }
        [[self topViewController].navigationController pushViewController:self.loginVC animated:YES];
        __weak typeof(self)weakSelf = self;
        self.loginVC.finshBlock = ^(BaseViewController *vc){
            [[weakSelf topViewController].navigationController popViewControllerAnimated:YES];
            if ([[UserManager shareMananger] isUserLogin]) {
                if (callback) {
                    callback(YES);
                }else if(callback){
                    callback(NO);
                }
            }
        };
    }
    [self showViewController:self.loginVC withStyle:U_SCENE_SHOW_PUSH];
}
@end

@implementation SceneMananger (Main)

- (void)showMainView
{
    if (self.topViewController) {
        [self.topViewController.navigationController popToRootViewControllerAnimated:NO];
        UITabBarController * tTabbar = (UITabBarController *)self.rootViewController;
        tTabbar.selectedIndex = 0;
    }
}
@end


@implementation SceneMananger(userInfo)

-(void)showUserInfoView
{
    if (self.topViewController) {
        [self.topViewController.navigationController popToRootViewControllerAnimated:NO];
        UITabBarController * tTabbar = (UITabBarController *)self.rootViewController;
        tTabbar.selectedIndex = 3;
    }
}
@end


//#import "SPTabbarViewController.h"
//
//@implementation SceneMananger (vcstack)
//- (NSString *)stackTitle
//{
//    NSString * stitle = @"";
//    if (self.visibleViewController.navigationController) {
//        UIViewController * disposeVC = nil;
//        for (UIViewController * aVC in [self.visibleViewController.navigationController viewControllers]) {
//            if ([aVC isKindOfClass:[SPTabbarViewController class]]) {
//                disposeVC = [(SPTabbarViewController *)aVC visiableViewController];
//            }else{
//                disposeVC = aVC;
//            }
//            
//            if ([stitle length] > 0) {
//                stitle = [stitle stringByAppendingString:@"|"];
//            }
//            
//            NSString * appendTitle = nil;
//            if ([disposeVC isKindOfClass:[BaseViewController class]]) {
//                appendTitle = [[(BaseViewController *)disposeVC navTitle] stringByReplacingOccurrencesOfString:@"|" withString:@"||"];
//            }else if ([aVC isKindOfClass:[UIViewController class]]){
//                appendTitle = [[disposeVC title] stringByReplacingOccurrencesOfString:@"|" withString:@"||"];
//            }
//            
//            stitle = [stitle stringByAppendingString:[NSString stringWithFormat:@"%@",appendTitle]];
//        }
//    }else{
//        if ([self.visibleViewController isKindOfClass:[BaseViewController class]]) {
//            stitle = [(BaseViewController *)self.visibleViewController navTitle];
//        }else{
//            stitle = [self.visibleViewController title];
//        }
//    }
//    return stitle;
//    

