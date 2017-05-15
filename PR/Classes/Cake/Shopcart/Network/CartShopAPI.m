 //
//  CartMananger.m
//  YHClouds
//
//  Created by 黄小雪 on 15/10/23.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "CartShopAPI.h"
#import "RefreshCartAPIInteract.h"
#import "UserManager.h"

@interface CartShopAPI()
@property (strong,nonatomic) RefreshCartAPIInteract *refreshCartAPI;

@end
@implementation CartShopAPI

-(void)refreshCartDataWithProductArr:(NSArray *)produtctArr{
    if (self.refreshCartAPI == nil) {
        self.refreshCartAPI =  [[RefreshCartAPIInteract alloc] init];
    }
//    interact.productsArr             = produtctArr;
    [self.refreshCartAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:CartDetailDataType data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error,id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:CartDetailDataType error:error];
        }
    }];
}


@end
