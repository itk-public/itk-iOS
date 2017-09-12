//
//  DateViewCell.h
//  YHClouds
//
//  Created by 黄小雪 on 2017/3/30.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "WTTableViewCell.h"
#import "ODDeliveryTimeInfo.h"
@class DateViewCell;

@protocol DateViewCellDelegate <NSObject>
-(void)dateViewCellDidClicked:(DateViewCell *)cell
           ODDeliveryTimeInfo:(ODDeliveryTimeInfo *)timeInfo;
@end

@interface DateViewCell : WTTableViewCell
@property (weak,nonatomic) id<DateViewCellDelegate> delegate;
@end
