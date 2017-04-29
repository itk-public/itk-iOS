#import <UIKit/UIKit.h>
#import "YHNavigatorProtocol.h"
#import "AppUIUtil.h"
#import "AppColorDefine.h"

@class BaseViewController;


@interface BaseViewController : UIViewController <YHNavigatorProtocol>
{
@protected
    BOOL					_needLogin;
    BOOL					_viewDidAppear;
    BOOL					_needNavbarHidden;
    BOOL                    _validPopGesture;
    
    //是否依然需要在navigation controller中显示,如果为否，则下次pop的时候，会跨过这些页面
    BOOL                    _availableInNavgationStack;
    NSString              * _pageName;
}
@property (nonatomic,readwrite) BOOL     needLogin;
@property (nonatomic,readonly ) BOOL     viewDidAppear;
@property (nonatomic,readonly ) BOOL     needNavbarHidden;
@property (nonatomic,readonly)  BOOL     validPopGesture;  // 是否支持右滑返回手势
@property (nonatomic,readonly ) BOOL     availableInNavgationStack;
@property (nonatomic,readonly ) NSString * pageName;
@property (nonatomic,strong   ) NSString  * navTitle;//  设置导航栏的title.
@property (strong,nonatomic)   UIColor    *navTitleColor;


@property (nonatomic, assign  ) BOOL     isAnimating;


/*
 *返回
 */
- (void)back;

- (void)outOfNavigationStack;

@end


@interface BaseViewController(protectInterface)
- (BOOL)needShowBackButton;

@end



// 无效页面标识
// 这个是用于 viewmap 里面构建无效 viewcontroller 使用的。
// 之所有需要 无效标识，是viewmap 中需要一个 vc 的class 来占位，因此构建这么个class
@interface NullViewController : BaseViewController

@end
