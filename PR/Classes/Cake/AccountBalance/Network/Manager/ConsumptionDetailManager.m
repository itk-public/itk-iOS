//
//  ConsumptionDetailManager.m
//  PR
//
//  Created by 黄小雪 on 2017/9/13.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ConsumptionDetailManager.h"
#import "ConsumptionDetailAPIInteract.h"

@interface ConsumptionDetailManager()
@property (strong,nonatomic) ConsumptionDetailAPIInteract *consumptionAPI;

@end
@implementation ConsumptionDetailManager
-(void)consumptionDetail
{
    if (self.consumptionAPI == nil) {
        self.consumptionAPI = [[ConsumptionDetailAPIInteract alloc]init];
    }
    [self.consumptionAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:error:)]) {
            [self.delegate loadDataFailed:self error:error];
        }
    }];
}

@end
