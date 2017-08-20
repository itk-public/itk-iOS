//
//  SubCategoryModel.m
//  PR
//
//  Created by 黄小雪 on 2017/6/5.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SubCategoryModel.h"

@implementation SubCategoryModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _subCategoryName = [dic safeObjectForKey:@"subCategoryName"];
        _subCategoryId   = [dic safeObjectForKey:@"subCategoryId"];
        NSArray *tempSkus = [dic safeObjectForKey:@"subCategorySkus" hintClass:[NSArray class]];
        NSMutableArray *tempSubCategorySkus = [NSMutableArray arrayWithCapacity:[tempSkus count]];
        if (tempSkus && [tempSkus count]) {
            for (NSDictionary *dict in tempSkus) {
                ProductOutline *product = [ProductOutline modelFromDictionary:dict];
                [tempSubCategorySkus addObject:product];
            }
        }
        _subCategorySkus = [NSMutableArray arrayWithArray:tempSubCategorySkus];
    }
    return self;
}
@end
