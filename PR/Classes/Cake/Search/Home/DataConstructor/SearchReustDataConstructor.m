//
//  SearchReustDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SearchReustDataConstructor.h"
#import "SearchManager.h"
#import "SearchResultModel.h"
#import "SearchShopDescInfo.h"
#import "SearchShopViewCell.h"
#import "SearchSeeMoreViewCell.h"
#import "SearchProductViewCell.h"
#import "SeparateCell.h"

@interface SearchReustDataConstructor()<SearchManagerDelegate>
@property (strong,nonatomic) SearchManager *manager;
@property (strong,nonatomic) NSArray *searchList;
@end


@implementation SearchReustDataConstructor
-(void)loadData
{
    [self.manager searchSku];
}

-(void)constructData
{
    if (self.searchList) {
        [self.items removeAllObjects];
        
        NSInteger index = 0;
        for (SearchResultModel *resutModel in self.searchList) {
            if ([resutModel isKindOfClass:[SearchResultModel class]]) {
                //分割cell
                if (index == 0) {
                    SeparateModel *model = [[SeparateModel alloc]init];
                    [self.items addObject:model];
                }
                //店铺信息
                SearchShopDescInfo *shopInfo = resutModel.shopInfo;
                shopInfo.cellClass = [SearchShopViewCell class];
                shopInfo.cellIdentifier = @"SearchShopViewCell";
                [self.items addObject:shopInfo];
                
                for (ProductOutline *product in resutModel.products) {
                    if ([product isKindOfClass:[ProductOutline class]]) {
                        //商品信息
                        product.cellClass = [SearchProductViewCell class];
                        product.cellIdentifier = @"SearchProductViewCell";
                        [self.items safeAddObject:product];
                    }
                }
                //查看更多
                SearchSeeMoreModel *moreInfo = [[SearchSeeMoreModel alloc]init];
                [moreInfo updateTotalNum:resutModel.totalNum action:nil];
                moreInfo.cellClass = [SearchSeeMoreViewCell class];
                moreInfo.cellIdentifier = @"SearchSeeMoreViewCell";
                [self.items safeAddObject:moreInfo];
                
                //分割cell
                if (index + 1 < [self.searchList count]) {
                    SeparateModel *model = [[SeparateModel alloc]init];
                    [self.items addObject:model];
                }
                index ++;
            }
        }
       
    }
}

-(SearchManager *)manager
{
    if (_manager == nil) {
        _manager = [[SearchManager alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}

#pragma mark SearchManagerDelegate
-(void)loadDataSuccessful:(SearchManager *)manager  data:(id)data  isCache:(BOOL)isCache
{
    self.searchList = data;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
        [self.delegate dataConstructor:self didFinishLoad:data];
    }
}

-(void)loadDataFailed:(SearchManager *)manager error:(NSError*)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}

@end
