//
//  FarmSearchReustDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 2017/8/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "FarmSearchReustDataConstructor.h"
#import "SearchManager.h"
#import "SearchResultModel.h"
#import "FarmSearchProductViewCell.h"

@interface FarmSearchReustDataConstructor()<SearchManagerDelegate>
@property (strong,nonatomic) SearchManager *manager;
@property (strong,nonatomic) NSArray *searchList;
@end


@implementation FarmSearchReustDataConstructor
-(void)loadData
{
    [self.manager searchSku];
}

-(void)constructData
{
    if (self.searchList) {
        [self.items removeAllObjects];
        for (SearchResultModel *resutModel in self.searchList) {
            if ([resutModel isKindOfClass:[SearchResultModel class]]) {
                for (ProductOutline *product in resutModel.products) {
                    if ([product isKindOfClass:[ProductOutline class]]) {
                        //商品信息
                        product.cellClass = [FarmSearchProductViewCell class];
                        product.cellIdentifier = @"SearchProductViewCell";
                        [self.items safeAddObject:product];
                    }
                }
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
