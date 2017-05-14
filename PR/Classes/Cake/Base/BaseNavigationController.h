//
//  BaseNavigationController.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController
<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL inTransition;

@property (nonatomic, assign) BOOL disablePanToBack;

@end
