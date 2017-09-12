//
//  CKVMDeliveryTimeInfo.h
//  PR
//
//  Created by 黄小雪 on 2017/9/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDetail.h"
#import "CartModelDefine.h"


@interface CKVMDeliveryTimeInfo : NSObject
@property(nonatomic,readonly)NSArray             *delivertTimeInfo;
@property(nonatomic,getter = isInUserChoose) BOOL inUserChoose;
@property(nonatomic,strong)    ODDSoltTime        *selectTime;
@property(nonatomic,readwrite) ODDeliveryTimeInfo *selectGroup;
@property(nonatomic,readwrite) OrderType           orderType;
@property (copy,nonatomic)     NSString            *seletedTimeStr;
@property (readonly,nonatomic) PTDeliveryType       type;
@property (assign,nonatomic)   BOOL                 showLineMargin;
@property (readonly,nonatomic)   NSInteger timeIndex;
@property (readonly,nonatomic)   NSInteger  groupIndex;
//3.1.0 是否可以去旋转着时间段，如果可选的时间的个数为1，而且是选中状态 则为NO
@property (readonly,nonatomic)   BOOL canToSeleted;
/**
 *  控制显不显示选择时间前面的icon和橙色的竖线
 */
@property (assign,nonatomic)   BOOL                 showTimeIcon;


- (instancetype)initWithDelivertTimeInfo:(NSArray *)timeInfo;
@end
