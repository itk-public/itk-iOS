//
//  CategoryMananger.m
//  PR
//
//  Created by 黄小雪 on 2017/6/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CategoryMananger.h"
#import "ShopCategoryAPIInteract.h"

@interface CategoryMananger()
@property (strong,nonatomic) ShopCategoryAPIInteract *shopCategoryApi;

@end
@implementation CategoryMananger

-(void)shopCategoryWithShopId:(NSString *)shopId
{
    if (self.shopCategoryApi == nil) {
        self.shopCategoryApi = [[ShopCategoryAPIInteract alloc]init];
    }
    [self.shopCategoryApi interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:CategoryManangerTypeShopCategory data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:CategoryManangerTypeShopCategory error:error];
        }
    }];
}
@end
