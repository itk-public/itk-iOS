//
//  AddressModel.h
//  PR
//
//  Created by 黄小雪 on 2017/5/16.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

@interface AddressDetailModel : YHDataModel
@property (readwrite,nonatomic) NSString *city;
@property (readwrite,nonatomic) NSString *area;
@property (readwrite,nonatomic) NSString *town;
@property (readwrite,nonatomic) NSString *detail;
@property (readwrite,nonatomic) NSString *cityId;
@property (readwrite,nonatomic) NSString *areaId;
@property (readwrite,nonatomic) NSString *townId;
@property (readwrite,nonatomic) NSString *cid;


-(NSString *)addressDesc;
@end

@interface AddressModel : YHDataModel
@property (readwrite,nonatomic) AddressDetailModel *address;
@property (readonly,nonatomic) NSString *cid;
//收货人姓名
@property (readwrite,nonatomic) NSString *name;
//收货人电话
@property (readwrite,nonatomic) NSString *phone;

@end
