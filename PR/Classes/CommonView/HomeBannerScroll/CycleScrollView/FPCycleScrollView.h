//
//  FPCycleScrollView.h
//  YHClouds
//
//  Created by YH on 15/12/7.
//  Copyright © 2015年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    SDCycleScrollViewPageContolAlimentRight,
    SDCycleScrollViewPageContolAlimentCenter
} SDCycleScrollViewPageContolAliment;

typedef enum {
    SDCycleScrollViewPageContolStyleClassic,        // 系统自带经典样式
    SDCycleScrollViewPageContolStyleAnimated,       // 动画效果pagecontrol
    SDCycleScrollViewPageContolStyleNone   ,        // 不显示pagecontrol
    SDCycleScrollViewPageContolStyleNumber
} SDCycleScrollViewPageContolStyle;

typedef enum {
    SDEmbedViewUnknown,
    SDEmbedViewHome,
    SDEmbedViewGoodsDetail,
} SDEmbedViewType;

typedef enum {
    SDCycleScrollviewDotPositionLeft,           // ...在左边
    SDCycleScrollviewDotPositionMiddle,         // ...在中间 缺省值
    SDCycleScrollviewDotPositionRight           // ...在右边
} SDCycleScrollviewDotPosition;

@class FPCycleScrollView;

@protocol SDCycleScrollViewDelegate <NSObject>

- (void)cycleScrollView:(FPCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

@end


@interface FPCycleScrollView : UIView

// >>>>>>>>>>>>>>>>>>>>>>>>>>  数据源接口

// 本地图片数组
@property (nonatomic, strong) NSArray *localizationImagesGroup;

// 网络图片 url string 数组
@property (nonatomic, strong) NSArray *imageURLStringsGroup;

// 每张图片对应要显示的文字数组
@property (nonatomic, strong) NSArray *titlesGroup;





// >>>>>>>>>>>>>>>>>>>>>>>>>  滚动控制接口

// 自动滚动间隔时间,默认2s
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

// 是否无限循环,默认Yes
@property(nonatomic,assign) BOOL infiniteLoop;

// 是否自动滚动,默认Yes
@property(nonatomic,assign) BOOL autoScroll;

@property (nonatomic, weak) id<SDCycleScrollViewDelegate> delegate;




// >>>>>>>>>>>>>>>>>>>>>>>>>  自定义样式接口

// 是否显示分页控件
@property (nonatomic, assign) BOOL showPageControl;

// 是否在只有一张图时隐藏pagecontrol，默认为YES
@property(nonatomic) BOOL hidesForSinglePage;

// pagecontrol 样式，默认为动画样式
@property (nonatomic, assign) SDCycleScrollViewPageContolStyle pageControlStyle;

// 占位图，用于网络未加载到图片时
@property (nonatomic, strong) UIImage *placeholderImage;

// 分页控件位置
@property (nonatomic, assign) SDCycleScrollViewPageContolAliment pageControlAliment;

// 分页控件小圆标大小
@property (nonatomic, assign) CGSize pageControlDotSize;

// 分页控件小圆标颜色
@property (nonatomic, strong) UIColor *dotColor;

// 分页控件小圆位于底部位置
@property (nonatomic, assign) SDCycleScrollviewDotPosition dotPosition;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont  *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;



// >>>>>>>>>>>>>>>>>>>>>>>>>  BI info
@property (nonatomic,assign) SDEmbedViewType embedViewType;


+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup;

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLStringsGroup;

// 获取当前展现的图片index
- (NSInteger)currentViewIndex;
- (UIImage *)currentShownImage;

//替换pagecontrol的小圆点的图片
-(void)setDotImageName:(NSString *)dotImageName currentDotImageName:(NSString *)currentDotImageName;


@end
