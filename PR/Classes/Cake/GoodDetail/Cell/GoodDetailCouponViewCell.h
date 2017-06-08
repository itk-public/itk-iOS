//
//  GoodDetailCouponViewCell.h
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
#import "YHDataModel.h"

@interface GoodDetailCouponModel : YHDataModel
@property (strong,nonatomic) NSDictionary *couponDict;
@end

@interface GoodDetailCouponViewCell : WTTableViewCell

@end
