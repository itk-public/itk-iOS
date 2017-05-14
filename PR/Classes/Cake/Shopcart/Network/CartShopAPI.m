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


@implementation CartShopAPI

-(void)refreshCartDataWithProductArr:(NSArray *)produtctArr{
    RefreshCartAPIInteract *interact = [[RefreshCartAPIInteract alloc] init];
    interact.productsArr             = produtctArr;
//    interact.isPickself              = [ShipAddrManager sharedInstance].deliveryInfo.pickselfStyle;
    [interact interactScuess:^(BaseAPIInteract *interact, id modelData) {
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
