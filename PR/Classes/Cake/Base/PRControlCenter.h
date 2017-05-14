//
//  PRControlCenter.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRSingleton.h"


@interface PRControlCenter : NSObject
DEF_SINGLETON(PRControlCenter)

/*!
 @method
 @abstract 获取根viewcontroller，即window根viewcontroller
 @return   根viewcontroller
 */
- (UIViewController *)rootViewController;

- (NSArray *)tabbarVCsIdentify;
@end
