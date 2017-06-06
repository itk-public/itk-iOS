//
//  CategoryRightDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 2017/6/5.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CategoryRightDataConstructor.h"
#import "CategoryMananger.h"
#import "CategoryProductViewCell.h"
#import "SubCategoryHeaderViewCell.h"
#import "SubCategoryModel.h"

@interface CategoryRightDataConstructor()<CategoryManangerDelegate>
@property (strong,nonatomic) CategoryMananger *manager;
@property (strong,nonatomic) NSArray *categoryskus;
@end

@implementation CategoryRightDataConstructor

-(void)loadData
{
    [self.manager categorySkuWithCategoryId:nil];
}

-(void)constructData
{
    if (self.categoryskus) {
        [self.items removeAllObjects];
        for (SubCategoryModel *category in self.categoryskus) {
            if ([category isKindOfClass:[SubCategoryModel class]]) {
                SubCategoryModel *newModel = [[SubCategoryModel alloc]init];
                newModel.cellClass = [SubCategoryHeaderViewCell class];
                newModel.cellIdentifier = @"SubCategoryHeaderViewCell";
                newModel.subCategoryName = category.subCategoryName;
                [self.items addObject:newModel];
                
                category.cellClass = [CategoryProductViewCell class];
                category.cellIdentifier = @"CategoryProductViewCell";
                [self.items addObject:category];
            }
        }
    }
}
-(CategoryMananger *)manager
{
    if (_manager == nil) {
        _manager = [[CategoryMananger alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}

#pragma mark CategoryManangerDelegate
-(void)loadDataSuccessful:(CategoryMananger *)cartShopApi dataType:(CategoryManangerType)dataType  data:(id)data  isCache:(BOOL)isCache
{
    self.categoryskus = data;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
        [self.delegate dataConstructor:self didFinishLoad:data];
    }
}

-(void)loadDataFailed:(CategoryMananger *)cartShopApi dataType:(CategoryManangerType)dataType error:(NSError*)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}

@end
