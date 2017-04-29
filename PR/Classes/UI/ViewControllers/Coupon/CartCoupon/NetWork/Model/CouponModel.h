//
//  CouponModel.h
//  PR
//
//  Created by 黄小雪 on 21/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

@interface CouponModel : YHDataModel
@property (readonly,nonatomic) NSString *desc;
@property (readonly,nonatomic) NSString *cid;
@property (readonly,nonatomic) NSString *shopid;
//优惠券的面值
@property (readonly,nonatomic) NSInteger amount;
//开始时间 2016-07-03
@property (readonly,nonatomic) NSString *startDate;
//结束时间 2016-07-30
@property (readonly,nonatomic) NSString *endDate;

-(void)updateShopId:(NSString *)shopid;
-(NSMutableAttributedString *)titleAttributedString;
-(NSString *)dateString;
@end
