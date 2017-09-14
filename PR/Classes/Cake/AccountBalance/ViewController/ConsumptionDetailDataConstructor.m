//
//  ConsumptionDetailDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 2017/9/13.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ConsumptionDetailDataConstructor.h"
#import "ConsumptionDetailManager.h"
#import "ConsumptionDetailCell.h"
#import "ConsumptionDetailModel.h"

@interface ConsumptionDetailDataConstructor()<ConsumptionDetailManagerDelegate>
@property (strong,nonatomic) ConsumptionDetailManager *manager;
@property (strong,nonatomic) NSArray *consumptionArray;
@end

@implementation ConsumptionDetailDataConstructor
-(void)loadData
{
    if (self.manager == nil) {
        self.manager = [[ConsumptionDetailManager alloc]init];
        self.manager.delegate = self;
    }
    [self.manager consumptionDetail];
}


-(void)constructData
{
    if (self.consumptionArray) {
        [self.items removeAllObjects];
        for (ConsumptionDetailModel *info in self.consumptionArray) {
            if ([info isKindOfClass:[ConsumptionDetailModel class]]) {
                info.cellClass = [ConsumptionDetailCell class];
                info.cellIdentifier = @"ConsumptionDetailCell";
                [self.items addObject:info];
            }
        }
    }
}
#pragma mark ConsumptionDetailManagerDelegate

-(void)loadDataSuccessful:(ConsumptionDetailManager *)manager  data:(id)data  isCache:(BOOL)isCache
{
    if ([data isKindOfClass:[NSArray class]]) {
        self.consumptionArray = data;
        if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
            [self.delegate dataConstructor:self didFinishLoad:data];
        }
    }

}

-(void)loadDataFailed:(ConsumptionDetailManager *)manager error:(NSError*)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}
@end
