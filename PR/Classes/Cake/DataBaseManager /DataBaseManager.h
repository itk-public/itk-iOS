//
//  DataBaseManager.h
//  PR
//
//  Created by 黄小雪 on 27/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartShopDataBaseModel.h"


@interface DataBaseManager : NSObject

+(instancetype)sharedDataBaseManager;

//增
-(BOOL)insertCartShopDataBaseModel:(CartShopDataBaseModel *)cartShop;
//删除
-(BOOL)deleteCartShopDataBaseModel:(CartShopDataBaseModel *)cartShop;
//更新
-(BOOL)updateCartShopDataBaseModel:(CartShopDataBaseModel *)cartShop;
//查
-(CartShopDataBaseModel *)queryCartShopDataBaseModel:(CartShopDataBaseModel *)cartShop;
//删除所有
- (BOOL)deleteAllProducts;
-(NSArray *)queryCartShop;
@end
