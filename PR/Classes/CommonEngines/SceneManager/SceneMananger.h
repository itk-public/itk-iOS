//
//  SceneMananger.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,U_SCENE_SHOW_STYLE)
{
    U_SCENE_SHOW_DEFAULT = 0,
    U_SCENE_SHOW_PUSH,
    U_SCENE_SHOW_PRESENT,
    U_SCENE_SHOW_ADDTOWINDOW,
    U_SCENE_SHOW_PUSH_NO_ANIMATION,
    U_SCENE_SHOW_PRESENT_OVER_CURRENT_CONTEXT,
};

//管理整个app的UI场景
@interface SceneMananger : NSObject
DEF_SINGLETON(SceneMananger)
#warning ????
@property (nonatomic,assign)   BOOL  rootVCVaild;
/*!
 @property
 @abstract      window，默认是系统的keywindow，若没有，则创建一个，用来承载导航堆栈
 */
@property (nonatomic, strong)   UIWindow          * window;


/*!
 @property
 @abstract      window的根viewcontroller
 */
@property (nonatomic, strong)   UIViewController  * rootViewController;

/*!
 @property
 @abstract      导航堆栈中最上面的viewcontroller
 */
@property (nonatomic, readonly) UIViewController  * topViewController;

/*!
 @property
 @abstract      当前可视的viewcontroller
 */
@property (nonatomic, strong) UIViewController  * visibleViewController;


+ (instancetype)shareMananger;

- (void)showViewController:(UIViewController*)vc withStyle:(U_SCENE_SHOW_STYLE)s;

/*!
 @method
 @abstract      设置rootViewController 通过manager生成和配置rootViewController
 */
// !!!: 可优化点
- (void)setupRootViewController;

-(void)popCurrentViewController;
-(void)popCurrentViewControllerUnderAnimation:(BOOL)animate;

// 跳转到指定的view controller
-(void)popToTargetViewController:(Class)vcClass;
/**
 *  上一个vc
 */
-(id)lastViewController;

/**
 *  找到上一个有效的vc，有效的vc(back会显示的vc)
 *
 *  @return 一个viewcontroller
 */
- (UIViewController *)previewVisiableViewController;

/**
 *  当前的vc
 */
-(UIViewController *)currentViewController;
@end


typedef void(^LOGINCALLBACK)(BOOL suc);

@interface SceneMananger(login)
- (void)showLoginViewWithCallback:(LOGINCALLBACK)callback;
- (void)checkNeedLogin:(UIViewController *)vc callback:(LOGINCALLBACK)callback;

////根据商品类型跳转相关登录界面。1.个人用户登录2.企业用户登录
//-(void)showLoginVCWithProductType:(NSInteger )type Callback:(LOGINCALLBACK)callback;


@end

@interface SceneMananger (Main)
- (void)showMainView;
@end

@interface SceneMananger (userInfo)
-(void)showUserInfoView;
@end

@interface SceneMananger (vcstack)
- (NSString *)stackTitle;

@end
