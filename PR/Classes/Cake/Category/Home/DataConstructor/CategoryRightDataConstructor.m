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
                NSInteger index = 0;
                CategoryProductViewCellModel *cellModel = nil;
                for (ProductOutline *product in category.subCategorySkus) {
                    if ([product isKindOfClass:[ProductOutline class]]) {
                        if (index%3 == 0) {
                            PRLOG(@"===当前index====%zd",index);
                            cellModel = [[CategoryProductViewCellModel alloc]init];
                            cellModel.cellClass = [CategoryProductViewCell class];
                            cellModel.cellIdentifier = @"CategoryProductViewCell";
                        }
                        [cellModel.products safeAddObject:product];
                        if (index%3 == 2 || index + 1 == [category.subCategorySkus count]) {
                             [self.items addObject:cellModel];
                        }
                        index ++;
                    }
                }
               
//                [cellModel.products safeAddObject:]
//                category.cellClass = [CategoryProductViewCell class];
//                category.cellIdentifier = @"CategoryProductViewCell";
//                [self.items addObject:category];
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
-(void)loadDataSuccessful:(CategoryMananger *)manager dataType:(CategoryManangerType)dataType  data:(id)data  isCache:(BOOL)isCache
{
    self.categoryskus = data;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
        [self.delegate dataConstructor:self didFinishLoad:data];
    }
}

-(void)loadDataFailed:(CategoryMananger *)manager dataType:(CategoryManangerType)dataType error:(NSError*)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}

@end
