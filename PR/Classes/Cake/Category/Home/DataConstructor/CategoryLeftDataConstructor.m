//
//  CategoryLeftDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 2017/6/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CategoryLeftDataConstructor.h"
#import "CategoryMananger.h"
#import "ShopCategoryCell.h"
#import "ShopCategoryModel.h"

@interface CategoryLeftDataConstructor()<CategoryManangerDelegate>
@property (strong,nonatomic) CategoryMananger *manager;
@property (strong,nonatomic) NSArray *categorys;
@end

@implementation CategoryLeftDataConstructor
-(void)loadData
{
    [self.manager shopCategoryWithShopId:nil];
}

-(CategoryMananger *)manager
{
    if (_manager == nil) {
        _manager = [[CategoryMananger alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}

-(void)constructData
{
    if ([self.categorys count]) {
        [self.items removeAllObjects];
        for (ShopCategoryModel *model in self.categorys) {
            if ([model isKindOfClass:[ShopCategoryModel class]]) {
                model.cellClass = [ShopCategoryCell class];
                model.cellIdentifier = @"ShopCategoryCell";
                [self.items addObject:model];
            }
        }
    }
}
#pragma mark CategoryManangerDelegate
-(void)loadDataSuccessful:(CategoryMananger *)manager dataType:(CategoryManangerType)dataType  data:(id)data  isCache:(BOOL)isCache
{
    self.categorys = data;
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
