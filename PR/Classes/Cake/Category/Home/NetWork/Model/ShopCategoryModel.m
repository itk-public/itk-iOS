//
//  ShopCategoryModel.m
//  PR
//
//  Created by 黄小雪 on 2017/6/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopCategoryModel.h"

@implementation ShopCategoryModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _categoryId = [dic safeObjectForKey:@"categoryId"];
        _categoryName = [dic safeObjectForKey:@"categoryName"];
    }
    return self;
}
@end
