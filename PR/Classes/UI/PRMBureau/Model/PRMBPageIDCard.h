//
//  PRMBPageIDCard.h
//  PR
//
//  Created by 黄小雪 on 14/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

/**
 *  view相关数据封装，这些数据用于viewcontroller全局跳转使用
 */

@interface PRMBPageIDCard : YHDataModel

//view 的类
@property (strong,nonatomic) Class               viewClass;
//view 初始化方法
@property (strong,nonatomic) NSValue             *viewInitMethod;
//view 实例方法
@property (strong,nonatomic) NSValue             *viewInstanceMethod;
//初始化方法参数，是字典类型
@property (strong,nonatomic) NSMutableDictionary *queryForInitMethod;
//实例方法参数，字典类型
@property (strong,nonatomic) NSMutableDictionary *queryForInstanceMethod;
//identifier
@property (copy,nonatomic  ) NSString            *identifier;
//字典，用来存放属性健值对
@property (strong,nonatomic) NSDictionary        *propertyDictionary;

/*!
 @method
 @abstract      viewcontroller是否遵守协议
 @param         protocol: 协议
 @return        NSNumber,是否遵守协议
 */
-(NSNumber *)viewConformsToProtocol:(Protocol *)protocol;

@end
