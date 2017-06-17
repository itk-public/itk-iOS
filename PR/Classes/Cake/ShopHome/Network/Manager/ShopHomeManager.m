//
//  ShopHomeManager.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeManager.h"
#import "ShopHomeAPIInteract.h"

@interface ShopHomeManager()
@property (strong,nonatomic) ShopHomeAPIInteract *shopHomeAPI;
@end

@implementation ShopHomeManager
-(void)shopHomeInfo
{
    if (self.shopHomeAPI == nil) {
        self.shopHomeAPI = [[ShopHomeAPIInteract alloc]init];
    }
    [self.shopHomeAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
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
