//
//  AppUIUtil.h
//  PR
//
//  Created by 黄小雪 on 05/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppColorDefine.h"

FOUNDATION_EXTERN NSString * biLabelKey;
/******************************		Size 相关的定义	***************************************/
#define ScreenWidth             [UIScreen mainScreen].bounds.size.width //屏幕宽度
#define ScreenHeight            [UIScreen mainScreen].bounds.size.height    //屏幕高度
#define APPLICATIONHEIGHT       [[UIScreen mainScreen] applicationFrame].size.height    //应用高度 (除去statusBar，statusBar隐藏时，应用高度和屏幕高度一样)
#define APPLICATIONWIDTH        ScreenWidth //应用宽度 (通常情况下和屏幕宽度是一样的)
#define KeybordRoughHeight      260 //键盘的粗略高度
#define OnePoint                (1/[UIScreen mainScreen].scale) //广义的点
#define BaseLineWidth               ([UIScreen mainScreen].scale > 2 ? 0.66 : 0.5)  // 基本的线的宽度，用于分割和边框

#define Kscale(k)               (k*(ScreenWidth/320.0))
#define displayScale            (nativeScale() / 2) // 适配用的缩放比
#define DDDisplayScale          (FFNativeScale() / 2) //design draft 的缩放比例
#define XXDisplayScale          (XNativeScale() / 2)

#define fontdelta               ((ceil(displayScale)-1)*2)

/******************************		字体相关的定义	***************************************/
#define  KColorOfCommonWords    [UIColor blackColor]
#define  KFontOfTitle           ([UIFont systemFontOfSize:14])
#define  KFontOfContent         ([UIFont systemFontOfSize:13])
#define  KFontNormal(size)      ([UIFont systemFontOfSize:size])
#define  KFontBold(size)        ([UIFont boldSystemFontOfSize:size])

// NSAttributeString属性便捷处理，可根据需求维护
#define ATTR_DICTIONARY(color, font)            @{NSForegroundColorAttributeName : color, NSFontAttributeName : font}


/******************************	  通用的工具方法	***************************************/
CGFloat nativeScale();  // 与320（IPHONE4）模式下的缩放比
CGFloat FFNativeScale(); // 与750 (IPHONE6) 模式下的缩放比
CGFloat XNativeScale();


//EA: entire app. 与EA游戏公司同时同名。
UIView * EADefaultViewForClass(Class X);
void EARemoveAllSubview(UIView * view);

void EABIEvent(NSString * bievent,NSString * biLabel,NSDictionary * biParam);
void BuryingPointEvent(NSString *bievent,NSDictionary *biParam);

@interface UIView(noRecursiveSearch)
- (UIView * )findASubViewWithTag:(NSInteger)tag; // 不做递归搜索
@end


/**
 *  自定义的barbutton
 */
@interface UIBarButtonItem(yhapp)
+ (instancetype)backStyleItem;
@end


@interface NSString(yhsizecalc)
/*
 *根据字体计算单行text的size
 *如果text的长度为0活着font为nil，返回CGSizeZero
 */
+(CGSize)text:(NSString*)text sizeWithFont:(UIFont*)font;

+ (NSString *)stringPriceDescWithFen:(long)priceNum;
@end



/**
 *  按钮点击区域扩展
 */
@interface UIButton(touchExpand)

- (void)expandTouchArea:(UIEdgeInsets)appendArea;
@end



/**
 *  字体调整
 */
@interface UILabel(yhfont)

@end

@interface UIButton(yhfont)

@end


@interface UITextField(yhfont)

@end

