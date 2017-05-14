//
//  AsynDataLoadViewController.m
//  PR
//
//  Created by 黄小雪 on 05/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "AsynDataLoadViewController.h"
#import "MJRefresh.h"
#import "PRLoadingAnimation.h"
#import "TimeStampMananger.h"


@interface AsynRefreshInfo : NSObject
@property (assign,nonatomic) BOOL              needLoading;
@property (assign,nonatomic) DataRefreshOption refreshOption;
+(instancetype)infoWithLoading:(BOOL)needLoading option:(DataRefreshOption)option;
@end

@implementation AsynRefreshInfo
+(instancetype)infoWithLoading:(BOOL)needLoading option:(DataRefreshOption)option
{
    AsynRefreshInfo *obj = [[AsynRefreshInfo alloc]init];
    obj.needLoading      = needLoading;
    obj.refreshOption    = option;
    return obj;
}

+(instancetype)infoWithOption:(DataRefreshOption)option
{
    return [self infoWithLoading:YES option:option];
}
@end

@interface AsynDataLoadViewController()

@property (weak,nonatomic  ) UIScrollView    *loadingView;
@property (assign,nonatomic) NSTimeInterval  timeStampDisappear;
@property (assign,nonatomic) NSTimeInterval  timeStampBackground;
@property (assign,nonatomic) BOOL            loadingStatus;
@property (assign,nonatomic) BOOL            isCurInWaitting;
@property (assign,nonatomic) BOOL            hadBeenSucessOnce;
@property (assign,nonatomic) BOOL            didNotifyToForeground;
@property (assign,nonatomic) LoadingUIType   lastLoadingType;
@property (strong,nonatomic) AsynRefreshInfo *currentRefreshInfo;

@end
@implementation AsynDataLoadViewController

#pragma mark view life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.loadingView.scrollsToTop = NO;
    if ([self queryRefreshOption] & DataRefreshOption_Enter) {
        self.loadingView = [self.configer pullRefreshScrollView];
        self.loadingView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(handleUserPull)];
    }
    if ([self queryRefreshOption] & DataRefreshOption_AppToForeground) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleAppToForeground)
                                                     name:AppKeyNotifyEnterForeground
                                                   object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(handlerAppToBackground)
                                                    name:AppKeyNotifyEnterBackground
                                                  object:nil];
        self.didNotifyToForeground  = YES;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self queryRefreshOption] & DataRefreshOption_ReturnView) {
        if (self.timeStampDisappear) {
            NSTimeInterval timeEscaped = [[TimeStampMananger shareManager] timeStamp] - self.timeStampDisappear;
            if (timeEscaped >= [self queryIntervalForBackView]) {
                AsynRefreshInfo *refreshInfo = [AsynRefreshInfo infoWithOption:DataRefreshOption_ReturnView];
                [self innerLoadModelWithInfo:refreshInfo];
            }
        }
    }
    
    if ([self queryRefreshOption] & DataRefreshOption_Enter && self.timeStampDisappear == 0) {
        AsynRefreshInfo *refreshInfo = [AsynRefreshInfo infoWithOption:DataRefreshOption_Enter];
        [self performSelectorOnMainThread:@selector(innerLoadModelWithInfo:) withObject:refreshInfo waitUntilDone:0];
    }
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.timeStampDisappear = [[TimeStampMananger shareManager] timeStamp];
}
#pragma mark -async request
//开始实际的数据请求获取
-(void)doActualReqData:(NSNumber *)refreshOption
{
//    [self.view viewWithTag:kerr]
}

-(void)innerLoadModelWithInfo:(AsynRefreshInfo *)info
{
    self.currentRefreshInfo = info;
    [self loadModelDataWithRefreshLoading:info.needLoading refreshType:info.refreshOption];

}
#pragma mark - refresh control

- (void)handleAppToForeground
{
    
}

-(void)handlerAppToBackground
{
    
}
-(void)handleUserPull
{
    
}
-(DataRefreshOption)queryRefreshOption
{
    if ([self.configer respondsToSelector:@selector(refreshOption)]) {
        return [self.configer refreshOption];
    }
    return DataRefreshOption_Enter;
}

-(NSTimeInterval)queryIntervalForBackView
{
    if ([self.configer respondsToSelector:@selector(intervalForBackView)]) {
        return [self.configer intervalForBackView];
    }
    return 0;
}

#pragma  mark -getter
- (LoadingUIType)queryLoadingRefreshUIType
{
    if ([self.configer respondsToSelector:@selector(loadingRefreshUIType)]) {
        return [self.configer loadingRefreshUIType];
    }
    //返回默认的
    //已经在下拉刷新了，就不需要显示蒙层了
    if (self.loadingView && self.loadingView.mj_header.isRefreshing) {
        return LoadingUIType_Header;
    }else{
        //判断当前是否有数据，如果有数据，则不需要显示任何刷新提示
        BOOL couldShowCover = YES;
        if ([self.configer respondsToSelector:@selector(couldShowCoverPromptView)]) {
            couldShowCover = [self.configer couldShowCoverPromptView];
        }else{
            couldShowCover = self.hadBeenSucessOnce == NO?YES:NO;
        }
        if (couldShowCover) {
            return LoadingUIType_Cover;
        }
        
        //第一次，显示蒙层
        return LoadingUIType_None;
    }
}


- (void)loadModelDataWithRefreshLoading:(BOOL)needLoading
                            refreshType:(DataRefreshOption)option
{
    [self setWaittingStatus:needLoading];
    [self performSelectorOnMainThread:@selector(doActualReqData:) withObject:[NSNumber numberWithInteger:option] waitUntilDone:NO];
}
#pragma mark - Loading type


/**
 *  设置当前UI 等待状态
 *
 *  @param needWait 当前是否需要等待，YES 显示等待，NO 隐藏等待
 */
-(void)setWaittingStatus:(BOOL)needWait
{
    if (needWait) {
        [self showWaittingStatus];
    }else{
        [self hidenWaittingStatus];
    }
}

-(void)showWaittingStatus
{
    CONDITION_CHECK_RETURN(self.isCurInWaitting == NO);
    self.isCurInWaitting = YES;
    LoadingUIType refreshType = [self queryLoadingRefreshUIType];
    if (refreshType == LoadingUIType_Cover) {
        if (self.currentRefreshInfo &&
            self.currentRefreshInfo.refreshOption == DataRefreshOption_UserActive) {
            //手动下拉刷新的时候下拉动画就是一种loading动画，所以不用两种loading同时出现
        }else{
            BOOL isDisableTouch = NO;
            if (self.configer &&
                [self.configer respondsToSelector:@selector(disableTouchWhenLoading)]) {
                isDisableTouch = [self.configer disableTouchWhenLoading];
            }
            if (isDisableTouch) {
                [[PRLoadingAnimation sharedInstance]addUnableTouchLoadingAnimationOnView:self.view];
            }else if(self.configer &&
                     [self.configer respondsToSelector:@selector(intervalForLoadingAfterDelay)]){
                NSTimeInterval interval = [self.configer intervalForLoadingAfterDelay];
                if (interval) {
                    [[PRLoadingAnimation sharedInstance]addLoadingAnimationOnView:self.view afterDelay:interval];
                }else{
                    [[PRLoadingAnimation sharedInstance]addUnableTouchLoadingAnimationOnView:self.view];
                }
            }else{
                [[PRLoadingAnimation sharedInstance] addLoadingAnimationOnView:self.view];
            }
        }
    }else if (refreshType == LoadingUIType_Header){
        [self.loadingView.mj_header beginRefreshing];
    }
    self.lastLoadingType = refreshType;
}

- (void)hidenWaittingStatus
{
    CONDITION_CHECK_RETURN(self.isCurInWaitting);
    self.isCurInWaitting = NO;
    [[PRLoadingAnimation sharedInstance] removeLoadingAnimation:self.view];
    [self.loadingView.mj_header endRefreshing];
}
@end

