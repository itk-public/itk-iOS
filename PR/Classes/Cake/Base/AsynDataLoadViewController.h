//
//  AsynDataLoadViewController.h
//  PR
//
//  Created by 黄小雪 on 05/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,LoadingUIType)
{
    LoadingUIType_None,
    LoadingUIType_Header,
    LoadingUIType_Cover,
};

typedef NS_OPTIONS(NSInteger,DataRefreshOption)
{
    DataRefreshOption_None            = 0,
    DataRefreshOption_Enter           = 1 << 0,
    DataRefreshOption_UserActive      = 1 << 1,
    DataRefreshOption_ReturnView      = 1 << 2,
    DataRefreshOption_AppToForeground = 1 << 3,
    DataRefreshOption_ForceRefresh    = 1 << 4,
    DataRefreshOption_Retry           = 1 << 5,
    
};

@protocol AsynDataLoadInterface <NSObject>
@required

/**
 *  实际的请求发起
 *  子类需要哦实现这个函数，调用正确的model请求数据
 */
-(void)actualReqData:(NSDataReadingOptions)refeshOption;

@optional

/**
 *  显示loading方式
 *
 *  @return loading方式
 */
-(LoadingUIType)loadingRefreshUIType;

/**
 *  当前需要刷新的机制
 *
 *  @return 刷新的机制集合
 */
-(DataRefreshOption)refreshOption;

/**
 *  需要下拉刷新的scrollview
 *
 *  @return scrollview对象，会添加MJRefresh头
 */
-(UIScrollView *)pullRefreshScrollView;

/**
 *  有些页面是自己重写navgation bar的，如果不指定error容器的话，会导致
 *  自定义bar被覆盖的情况
 *
 *  @return error承载view
 */
-(UIView *)errorContainerView;
-(UIView *)errorUnderView;


/**
 *  xx 秒内返回到本界面，保持不变。否则刷新数据。
 *  这个 xx 就通过这个接口返回
 *  @return 间隔的时间段
 */
-(NSTimeInterval)intervalForBackView;

/**
 *  loading显示延迟时间，设置为0或者不设置的情况下不做延迟
 *
 *  @return
 */
- (NSTimeInterval)intervalForLoadingAfterDelay;

/**
 *  当没有内容的适合，需要显示cover 类型的 loading
 *
 *  @return 是否可以显示cover 类型的 Loading.
 */
- (BOOL)couldShowCoverPromptView;

/**
 *  loading动画进行的时候取消点击时间的传递
 *
 *  @return
 */
- (BOOL)disableTouchWhenLoading;

@end
/**
 *  AsynDataLoadViewController
 *  抽象了 异步网络请求的 view controller 的一些功能。
 *  包含了，异步请求时机，下拉刷新，jumpToTop, 极光模式
 */
@interface AsynDataLoadViewController : BaseViewController<UIScrollViewDelegate>
@property (weak,nonatomic) id<AsynDataLoadInterface>  configer;

/**
 *  开始发起一次异步数据请求
 *  可以继承，但是记得调用[super loadModelData]
 */
-(void)loadModelData;

-(void)loadModelDataWithRefresh:(BOOL)needRefresh;

-(void)loadModelDataWithPullingLoading:(BOOL)needPullingLoading;

/**
 *  通知异步数据获取成功了，AsynDataLoadViewController 处理后续的处理
 */
-(void)asynDataArrived;

/**
 *  通知异步数据获取失败了，AsynDataLoadViewController 来通知用户
 *
 *  @param errorInfo 发生错误的信息
 */
-(void)reqDataError:(NSError *)errorInfo;

/**
 *  显示本次获取数据的错误信息
 *
 *  @param errorInfo 详细的错误信息
 *  @param showTip   是否提示错误信息
 */
-(void)reqDataError:(NSError *)errorInfo showTip:(BOOL)showTip;

/**
 *  设置当前UI 等待状态
 *
 *  @param needWait 当前是否需要等待，YES,显示等待，NO,隐藏等待
 */
-(void)setWaittingStatus:(BOOL)needWait;

@end
