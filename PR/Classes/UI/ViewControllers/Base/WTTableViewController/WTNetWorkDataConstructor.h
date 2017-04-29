//
//  WTNetWorkDataConstructor.h
//  PR
//
//  Created by 黄小雪 on 18/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTNetWorkDataConstructorDelegate;
/*!
 @class
 @abstract      网络数据构造器，子类可以实现相关方法实现网络数据构造
 */

@interface WTNetWorkDataConstructor : NSObject

/*!
 @property
 @abstract      可变数组，用来存放构造出来的数据
 */
@property (nonatomic, retain) NSMutableArray * items;


@property (nonatomic, weak) id responder;

/*!
 @method
 @abstract      构造数据
 @discussion    可以是静态数据，也可以是网络请求数据，或缓存数据，由子类来实现这个方法
 @return        void
 */
- (void)constructData;

@property (nonatomic, weak) id<WTNetWorkDataConstructorDelegate> delegate;

/*!
 @method
 @abstract      加载数据
 @discussion    子类覆盖此方法，若有多次请求，可封装为多个请求方法，然后在此处调用，具体情况具体对待
 @return        void
 */
- (void)loadData;

/**
 *  获取更多数据
 */


@end

@protocol WTNetWorkDataConstructorDelegate <NSObject>

@optional
- (void)dataConstructorDidStartLoadData:(id)dataConstructor;
- (void)dataConstructor:(id)dataConstructor didFinishLoad:(NSObject *)dataModel;
- (void)dataConstructorDidFailLoadData:(id)dataConstructor withError:(NSObject *)errorDataModel;

@end