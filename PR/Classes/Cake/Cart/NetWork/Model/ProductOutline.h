//
//  ProductInfo.h
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"
#import "Action.h"
#import "ImageInfo.h"
#import "CartModelDefine.h"

@interface PriceInfo:YHDataModel
//市场价
@property (readonly,nonatomic) NSString *marketPrice;

@end

@interface ProductOutline : YHDataModel
//product调整action
@property (readonly,nonatomic) Action *action;

//商品id
@property (readonly,nonatomic)  NSString *cid;
//商品图片
@property (readonly,nonatomic)  ImageInfo *imageInfo;

//是否不在配送范围内，或者不支持自提
@property (readonly,nonatomic)  BOOL isOutDelivered;
//是否下架
@property (readonly,nonatomic) BOOL isOffTheShelf;
//是否库存不足
@property (readonly,nonatomic) BOOL isOutOfStock;
//商品的选中状态
@property (assign,nonatomic) BOOL isSelected;

//商品个数
@property (assign,nonatomic)  NSInteger num;
//库存
@property (readonly,nonatomic) NSInteger stocknum;

//价格
@property (readonly,nonatomic)  PriceInfo *priceInfo;
//商家id
@property (readonly,nonatomic) NSString *shopid;
//规格
@property (readonly,nonatomic) NSString *spec;
//title
@property (readonly,nonatomic) NSString *title;
//subtitle
@property (readonly,nonatomic) NSString *subtitle;

@property (nonatomic, assign  ) PTDeliveryType      deliverySupportType;// 该商品支持 次日达还是当日达， 当日达为1， 次日达为2

@end
