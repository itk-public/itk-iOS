//
//  TimeSelectorViewController.h
//  YHClouds
//
//  Created by 黄小雪 on 2017/3/30.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "BaseViewController.h"
#import "CKVMDeliveryTimeInfo.h"

typedef void(^TimeSelectorReturnBlock)();
typedef void(^TimeSelectorDisappearedBlock)();
@interface TimeSelectorView : UIView
-(void)setCKVMDeliveryTimeInfo:(CKVMDeliveryTimeInfo *)deliveryInfo;
-(void)show;
@property (copy,nonatomic) TimeSelectorReturnBlock returnBlock;
@property (copy,nonatomic) TimeSelectorDisappearedBlock disappearedBlock;
@end

