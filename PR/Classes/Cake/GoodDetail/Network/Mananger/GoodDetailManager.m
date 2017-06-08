//
//  GoodDetailManager.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "GoodDetailManager.h"
#import "GoodDetailAPIInteract.h"

@interface GoodDetailManager ()
@property (strong,nonatomic) GoodDetailAPIInteract *goodDetailAPI;
@end
@implementation GoodDetailManager
-(void)getGoodDetailWithId:(NSString *)goodId;
{
    if (self.goodDetailAPI == nil) {
        self.goodDetailAPI = [[GoodDetailAPIInteract alloc]init];
    }
    [self.goodDetailAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:data:)]) {
            [self.delegate loadDataSuccessful:self data:modelData];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:error:)]) {
            [self.delegate loadDataFailed:self error:error];
        }
    }];
}
@end
