//
//  YHTableViewCellItemProtocol.h
//  PR
//
//  Created by 黄小雪 on 05/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YHGroupedCellPosition) {
    YHGroupedCellPositionNone,
    YHGroupedCellPositionFirst,
    YHGroupedCellPositionMiddle,
    YHGroupedCellPositionLast
};

@protocol CellResponseProtocol;

@protocol YHTableViewCellItemProtocol <NSObject>

/**
 *  cell 的类
 */
@property (nonatomic, strong) Class         cellClass;

/**
 *  cell 类型
 */
@property (nonatomic, copy  ) NSString      * cellType;

/**
 *  cell 高度
 */
@property (nonatomic, strong) NSNumber      * cellHeight;

/**
 *  cell 响应对象
 */
@property (nonatomic, assign) id            cellSelResponse;

/**
 *  cell 背景色
 */
@property (nonatomic, strong) UIColor       * cellBackgroundColor;

/**
 *  cell 数据源tag标示
 */
@property (nonatomic, assign) int           cellTag;


@property (nonatomic, assign) BOOL useNib;

/**
 *  cell的位置，用于指示画线类型，默认是YHGroupedCellPositionMiddle
 */
@property (nonatomic, assign) YHGroupedCellPosition groupedCellPosition;

@end

