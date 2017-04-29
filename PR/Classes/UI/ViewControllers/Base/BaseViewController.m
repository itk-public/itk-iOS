//
//  BaseViewController.m
//  PR
//
//  Created by 黄小雪 on 04/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "BaseViewController.h"
//#import "SceneMananger.h"
#import "AppUIUtil.h"

@implementation BaseViewController
@synthesize needLogin = _needLogin;
@synthesize viewDidAppear = _viewDidAppear;
@synthesize needNavbarHidden = _needNavbarHidden;
@synthesize validPopGesture = _validPopGesture;
@synthesize availableInNavgationStack = _availableInNavgationStack;
@synthesize pageName = _pageName;

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kVCViewBGColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTranslucent:NO];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)])
    {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    if ([self needShowBackButton])
    {
        [self addBackBarButton];
    }
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // kColorNavigationBarBg
        self.navigationController.navigationBar.tintColor    = kColorNavigationBarBg;   //0x825329
    } else {
        self.navigationController.navigationBar.barTintColor = kColorNavigationBarBg;    //0x825329
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.isNavigationBarHidden != self.needNavbarHidden)
    {
        [self makeNavigationChangeSmoothly];
    }
    
    [self decorateBaseNavigationBar];
}

- (void)decorateBaseNavigationBar
{
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarbg"]  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"dotline"]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _viewDidAppear = YES;
    self.isAnimating = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _viewDidAppear = NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.isAnimating = NO;
}

#pragma mark - navigation controller

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)addBackBarButton
{
    UIBarButtonItem* backItem             = [UIBarButtonItem backStyleItem];
    [(UIButton *)backItem.customView addTarget:self
                                        action:@selector(curVCBack:)
                              forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.backBarButtonItem = nil;
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (BOOL)needShowBackButton
{
    UIViewController* root = [self.navigationController.viewControllers safeObjectAtIndex:0];
    if (root && root != self)
    {
        return YES;
    }
    return NO;
}

- (void)setNavTitle:(NSString *)title
{
    
    _navTitle = title;
    if (nil == [self.navigationItem titleView])
    {
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180*displayScale, 25)];
        [lab setText:title];
        lab.font      = KFontNormal(18);
        [lab setTextColor:kColorNavigationTitle];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [self.navigationItem setTitleView:lab];
    }
    else if ([[self.navigationItem titleView] isKindOfClass:[UILabel class]])
    {
        UILabel * lab = (UILabel *)[self.navigationItem titleView];
        [lab setText:title];
    }
}

-(void)setNavTitleColor:(UIColor *)navTitleColor{
    if ([[self.navigationItem titleView] isKindOfClass:[UILabel class]])
    {
        UILabel * lab = (UILabel *)[self.navigationItem titleView];
        [lab setTextColor:navTitleColor];
    }
}

- (BOOL)canUserPopGesture
{
    return self.validPopGesture;
}

/**
 *	系统导航在页面之间切换，显隐需要动画使效果平滑
 **/
- (void)makeNavigationChangeSmoothly
{
    [self.navigationController setNavigationBarHidden:self.needNavbarHidden animated:YES];
}


#pragma mark - auto back

- (void)outOfNavigationStack
{
    _availableInNavgationStack = NO;
}

- (void)back
{
    // 做Pop保护
    if (self.navigationController == nil) {
        return;
    }
    
    NSArray * vcInStack = [self.navigationController viewControllers];
    
    UIViewController * needShowVC = nil;
    for (NSInteger thePopIndex = [vcInStack count] - 2; thePopIndex >= 0; thePopIndex--) {
        needShowVC  = [vcInStack safeObjectAtIndex:thePopIndex];
        if (NO == [needShowVC isKindOfClass:[BaseViewController class]] ||
            [(BaseViewController *)needShowVC availableInNavgationStack] == YES){
            break;
        }
    }
    
    if (needShowVC) {
        [self.navigationController popToViewController:needShowVC animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)curVCBack:(id)sender
{
    [self back];
}



#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithQuery:(NSDictionary *)query
{
    self = [self init];
    if (self) {
        //        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _needLogin                 = NO;
    _viewDidAppear             = NO;
    _needNavbarHidden          = NO;
    _availableInNavgationStack = YES;
    _validPopGesture           = YES;
    _pageName                  = NSStringFromClass([self class]);
    [self setHidesBottomBarWhenPushed:YES];
}

@end



@implementation NullViewController


@end
