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

@interface PriceInfo:YHDataModel
//市场价
@property (readonly,nonatomic) NSString *marketPrice;

@end

@interface ProductInfo : YHDataModel
//product调整action
@property (readonly,nonatomic) Action *action;

//商品id
@property (readonly,nonatomic)  NSString *cid;
//商品图片
@property (readonly,nonatomic)  ImageInfo *imageInfo;

//是否不在配送范围内，或者不支持自提
@property (readonly,nonatomic)  BOOL isOutDelivery;
//是否下架
@property (readonly,nonatomic) BOOL isOffShelf;
//是否库存不足
@property (readonly,nonatomic) BOOL isOutStock;
//商品的选中状态
@property (readonly,nonatomic) BOOL isSelect;

//商品个数
@property (readonly,nonatomic)  NSInteger num;
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

@end
