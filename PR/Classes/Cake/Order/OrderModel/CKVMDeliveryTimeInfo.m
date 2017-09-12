//
//  CKVMDeliveryTimeInfo.m
//  PR
//
//  Created by 黄小雪 on 2017/9/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CKVMDeliveryTimeInfo.h"

@implementation CKVMDeliveryTimeInfo

- (instancetype)initWithDelivertTimeInfo:(NSArray *)timeInfo
{
    if (self = [super init]) {
        _delivertTimeInfo = timeInfo;
        _selectGroup = [timeInfo safeObjectAtIndex:0];
        if (_selectGroup) {
            _selectTime  = [_selectGroup.soltTimes safeObjectAtIndex:0];
        }else{
            _selectTime  = nil;
        }
    }
    return self;
}

- (void)setSelectTime:(ODDSoltTime *)selectTime
{
    _selectTime = selectTime;
}


-(NSString *)seletedTimeStr{
    if (_selectTime) {
        if ([self toSelectTimeCount] == 1) {
            return [NSString stringWithFormat:@"%@ %@",[self.selectGroup monthDayDesc],[self.selectTime orderCommintpromptTitle]];
        }
        return [NSString stringWithFormat:@"%@ %@",[self.selectGroup monthDayDesc],[self.selectTime orderCommintpromptTitle]];
    }
    return @"请选择";
}

-(NSInteger)toSelectTimeCount
{
    NSInteger count = 0;
    for (ODDeliveryTimeInfo *groupTime in self.delivertTimeInfo) {
        if (groupTime) {
            count += [groupTime.soltTimes count];
        }
    }
    return count;
}


-(BOOL)canToSeleted
{
    if([self toSelectTimeCount]  == 1 && self.selectTime){
        return NO;
    }
    return YES;
}
@end
