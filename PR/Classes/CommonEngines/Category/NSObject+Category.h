//
//  NSObject+Category.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

/*!
 @method
 @abstract      判断对象是否未nil或[NSNull null]对象
 @return        BOOL
 */
- (BOOL)isNilOrNull;

/*!
 @method
 @abstract      执行selector方法
 @param         aSelector: 要执行的方法
 @param         objects: 参数
 @return        id
 */
- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;


@end
