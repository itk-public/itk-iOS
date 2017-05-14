//
//  YHNavigatorProtocol.h
//  PR
//
//  Created by 黄小雪 on 05/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kInitMethod                                     @"__INITMETHOD__"
#define kInstanceMethod                                 @"__INSTANCEMETHOD__"
#define kClass                                          @"__CLASS__"

/*!
 @protocol
 @abstract      使用导航器进行导航的类需要实现次协议
 */
@protocol YHNavigatorProtocol <NSObject>

@required
/*!
 @method
 @abstract      初始化
 @param         query: 初始化参数，字典形式
 @return        实例对象
 */
- (instancetype)initWithQuery:(NSDictionary *)query;

@optional

/*!
 @method
 @abstract      做初始化工作
 @param         query: 初始化参数，字典形式
 @return        void
 */
- (void)doInitializeWithQuery:(NSDictionary *)query;

@optional

/**
 *  当前页面是否支持返回手势
 */
- (BOOL)canUserPopGesture;

@end

