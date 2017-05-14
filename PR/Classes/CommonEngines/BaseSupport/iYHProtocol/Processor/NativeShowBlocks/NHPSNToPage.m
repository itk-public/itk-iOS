//
//  NHPSNToPage.m
//  YHClouds
//
//  Created by biqiang.lai on 16/11/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "NHPSNToPage.h"
//#import "ChangeRoleManager.h"
#import "BaseViewController.h"
#import "SceneMananger.h"
#import "PRMBOperationGroup.h"

@implementation NHPSNToPage

- (void)switchToViewPage:(UIViewController *)nativePage withId:(NSString *)viewIdentifier needAnimation:(BOOL)needAnimation
{
    if (nil != nativePage) {
        // 获取切换配置
        [[SceneMananger shareMananger] showViewController:nativePage withStyle:(needAnimation?U_SCENE_SHOW_PUSH:U_SCENE_SHOW_PUSH_NO_ANIMATION)];
    }else{
        [self.outPut disposeNativePageURL:self.cmdURL];
    }
}

- (void)disposeNativePageURL:(NSString *)url
{
    [super disposeNativePageURL:url];
    
    NSDictionary * params     = [url getURLParams];
    NSString * viewIdentifier = [params safeObjectForKey:URL_QUERY_KEY_NAME hintClass:[NSString class]];
    
    // 获取是否需要以非动画方式切换
    NSString * animated       = [params safeObjectForKey:APPURL_PARAM_NOANIMATED hintClass:[NSString class]];
    BOOL shouldAnaimate       = animated ? [animated boolValue] : YES;
    
    // 构建 view controller
    UIViewController * nativePage = [[PRMBOperationGroup sharedInstance] arrestWithPageID:viewIdentifier
                                                                                 andParam:params];
    if (nativePage) {
        [[SceneMananger shareMananger] checkNeedLogin:nativePage callback:^(BOOL suc) {
            if (suc) {
                if ([[PRMBOperationGroup sharedInstance] authenticateViewContorller:nativePage withPageID:viewIdentifier]) {
                    [self switchToViewPage:nativePage withId:viewIdentifier needAnimation:shouldAnaimate];
                }else{
                    UIViewController * researchPage = [[PRMBOperationGroup sharedInstance] arrestWithPageID:viewIdentifier
                                                                                                   andParam:params];
                    if ([researchPage isKindOfClass:[NullViewController class]]) {
//                        ChangeRoleManager * changeRoleManager = [[ChangeRoleManager alloc] init];
//                        [changeRoleManager showChangeRoleAlertWithChangeToRoleType:ChangeToRolePerson];
                        return;
                    }else if ([researchPage isKindOfClass:[UIViewController class]]) {
                        [self switchToViewPage:researchPage withId:viewIdentifier needAnimation:shouldAnaimate];
                    }
                }
            }
        }];
    }else{
        [self switchToViewPage:nativePage withId:viewIdentifier needAnimation:shouldAnaimate];
    }
}

@end
