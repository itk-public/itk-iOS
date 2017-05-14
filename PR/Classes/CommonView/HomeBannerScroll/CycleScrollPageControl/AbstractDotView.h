//
//  AbstractDotView.h
//  YHClouds
//
//  Created by YH on 15/12/7.
//  Copyright © 2015年 YH. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface AbstractDotView : UIView


/**
 *  A method call let view know which state appearance it should take. Active meaning it's current page. Inactive not the current page.
 *
 *  @param active BOOL to tell if view is active or not
 */
- (void)changeActivityState:(BOOL)active;


@end

