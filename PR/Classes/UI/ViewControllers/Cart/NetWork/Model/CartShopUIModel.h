//
//  CartSellerUIModel.h
//  PR
//
//  Created by 黄小雪 on 15/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"
#import "ShopDescInfo.h"

@interface CartShopUIModel : YHDataModel
@property (readonly,nonatomic)ShopDescInfo   *shopInfo;
@property (readonly,nonatomic) NSArray        *products;
@end
