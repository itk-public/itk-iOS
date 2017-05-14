//
//  NSObject+BSCategory.h
//  PR
//
//  Created by 黄小雪 on 17/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BSCategory)
/*!
 @method
 @abstract      判断对象是否未nil或[NSNull null]对象
 @return        BOOL
 */
- (BOOL)isNilOrNull;
@end
