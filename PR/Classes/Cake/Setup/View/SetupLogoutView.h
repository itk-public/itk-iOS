//
//  SetupLogoutView.h
//  YHClouds
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidClickedLogoutBtnBlock)();
@interface SetupLogoutView : UIView
@property (copy,nonatomic) DidClickedLogoutBtnBlock returnBlock;
+(CGFloat)getHeight;
@end
