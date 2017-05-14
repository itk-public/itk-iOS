//
//  OnePixelSepView.h
//  YHClouds
//
//  Created by biqiang.lai on 15/11/6.
//  Copyright © 2015年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int,OnePixelSepPos)
{
    OnePixelSepViewNone = -1,   //无分割线
    OnePixelSepPosAuto = 0,     //自动选择，如果宽大于高，则使用OnePixelSepPosUp，否则使用OnePixelSepPosLeft
    OnePixelSepPosUp,      //最上的一个像素
    OnePixelSepPosDown,    //最下的一个像素
    OnePixelSepPosLeft,    //最左的一个像素
    OnePixelSepPosRight    //最右的一个像素
};

//根据pos在view的某一个方位画一条1像素的实线，其他位置为透明
IB_DESIGNABLE
@interface OnePixelSepView : UIView

//默认使用OnePixelSepPosAuto
@property (nonatomic,assign) IBInspectable OnePixelSepPos pos;
@property (nonatomic,retain) IBInspectable UIColor* lineColor;
@property (nonatomic,assign) IBInspectable BOOL isDottedLine;
@property (assign,nonatomic) IBInspectable CGFloat margin; //水平方向：左间距  垂直方向：上间距

@end



typedef NS_OPTIONS(NSUInteger, PSRectEdge) {
    PSRectEdgeNone   = 0,
    PSRectEdgeTop    = 1 << 0,
    PSRectEdgeLeft   = 1 << 1,
    PSRectEdgeBottom = 1 << 2,
    PSRectEdgeRight  = 1 << 3,
    PSRectEdgeVert   = PSRectEdgeTop | PSRectEdgeBottom,
    PSRectEdgeAll    = PSRectEdgeTop | PSRectEdgeLeft | PSRectEdgeBottom | PSRectEdgeRight
};



@interface UIView(OnPixelSep)

- (PSRectEdge)pixelSepSet;
- (void)setPixelSepSet:(PSRectEdge)inSep;

- (OnePixelSepView *)psTopSep;
- (OnePixelSepView *)psLeftSep;
- (OnePixelSepView *)psRightSep;
- (OnePixelSepView *)psBottomSep;
@end