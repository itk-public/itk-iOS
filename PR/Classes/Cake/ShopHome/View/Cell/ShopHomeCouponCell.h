//
//  ShopHomeCouponCell.h
//  PR
//
//  Created by 黄小雪 on 2017/6/10.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
#import "YHDataModel.h"

@interface ShopHomeCouponCellModel : YHDataModel
@property (strong,nonatomic) NSArray *coupons;
@end

@interface ShopHomeCouponCell : WTTableViewCell

@end
