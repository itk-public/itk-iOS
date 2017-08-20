//
//  CategoryMananger.m
//  PR
//
//  Created by 黄小雪 on 2017/6/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CategoryMananger.h"
#import "ShopCategoryAPIInteract.h"
#import "CategorySkuAPIInteract.h"

@interface CategoryMananger()
@property (strong,nonatomic) ShopCategoryAPIInteract *shopCategoryApi;
@property (strong,nonatomic) CategorySkuAPIInteract *categorySkuApi;

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

-(void)categorySkuWithCategoryId:(NSString *)categoryId
{
    if (self.categorySkuApi == nil) {
        self.categorySkuApi = [[CategorySkuAPIInteract alloc]init];
    }
    [self.categorySkuApi interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:CategoryManangerTypeCategorySku data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:CategoryManangerTypeCategorySku error:error];
        }
    }];
    
}
@end
