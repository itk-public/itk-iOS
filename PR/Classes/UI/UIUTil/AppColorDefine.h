//
//  AppColorDefine.h
//  PR
//
//  Created by 黄小雪 on 05/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifndef AppColorDefine_h
#define AppColorDefine_h
#import "Define.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:0.5]


#define kColorTheme              UIColorFromRGB(0x2cdbc7)
#define kColorNormal             UIColorFromRGB(0x333333)
#define kColorActionSepLine      UIColorFromRGB(0x444444)
#define kColorYHBrown            UIColorFromRGB(0x946632)
#define kColorYHOrange           UIColorFromRGB(0xfd7622)
#define kColorErrorViewBG        UIColorFromRGB(0xf3f4f6)
#define kColorDarkOrange         UIColorFromRGB(0xe75d06)

#define kColorBadgeNumBgColor    UIColorFromRGB(0xFEBC02)

#define kColorLightBlue          UIColorFromRGB(0x0099ff)

#define kColorReferenceTawnyColor       kColorTheme
#define kColorMall                      UIColorFromRGB(0xff5400)
#define kColorOrange                    kColorReferenceTawnyColor
#define kColorBRAVO                     UIColorFromRGB(0x4e6012)
#define kColorPrice                     UIColorFromRGB(0xff4600)
#define kColorCSX                       UIColorFromRGB(0X0e8b2f)

#define kVCViewBGColor                  UIColorFromRGB(0xf3f4f6)
#define kColorEmptyTitle                UIColorFromRGB(0x929394)
#define kColorGray                      UIColorFromRGB(0x959595)

#define kColorNavigationBarBg           UIColorFromRGB(0xf9f9f9)
#define kColorNavigationTitle           UIColorFromRGB(0x111111)
#define kColorNaviActionColor           kColorYHBrown


#define kColorOutsideLine               UIColorFromRGB(0xdddddd)
#define kColorBlakLight                 UIColorFromRGB(0x666666)
#define kColorTextFiledPlaceHolderLabel UIColorFromRGB(0xcccccc)

#define kColorTabTextColor              UIColorFromRGB(0x787878)

#define kColorTitleInfo                 UIColorFromRGB(0x333333)
#define kColorTitleDarkInfo             UIColorFromRGB(0x111111)
#define kColorSubTitleInfo              UIColorFromRGB(0x666666)
#define kColorSubTitleInfo_Desalination UIColorFromRGB(0x999999)

#define kSepLineColor                   UIColorFromRGB(0xdddddd)
#define kSepLine1Color                  UIColorFromRGB(0xececec)
#define kDarkSepLineColor               UIColorFromRGB(0xaaaaaa)
#define kAutoSepLineColor               iPhone6p ? kDarkSepLineColor : kSepLineColor


#define kColorSpeedDeliveryTag          UIColorFromRGB(0xf68181)
#define kColorSpeedDeliveryEnableTag    [UIColor colorWithRed:246/255.0 green:129/255.0 blue:129/255.0 alpha:0.5]
#define kColorNextDayDeliveryTag        UIColorFromRGB(0x89c33a)
#define kColorNextDayDeliveryEnableTag  [UIColor colorWithRed:141/255.0 green:193/255.0 blue:69/255.0 alpha:0.5]

#define kColorUnPay                     UIColorFromRGB(0xff5000)

#define kColorGreen                     UIColorFromRGB(0x589c3e)
#define kColorCouposCouponBlue          UIColorFromRGB(0x5fb2e1)
#define kColorRed                       UIColorFromRGB(0xfc4916)


#define kColorLightBgColor              UIColorFromRGB(0xf3f3f3)
#define kColorSectionTitleBgColor       UIColorFromRGB(0xf8f8f8)

#define kColorYellowish                 UIColorFromRGB(0xfff5cc)


#endif /* AppColorDefine_h */

