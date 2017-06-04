//
//  AddressManager.m
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "AddressManager.h"
#import "AddressListAPIInteract.h"
#import "PickSelfSiteListAPIInteract.h"

@interface AddressManager()
@property (strong,nonatomic) AddressListAPIInteract *listAPI;
@property (strong,nonatomic) PickSelfSiteListAPIInteract *pickSelfSiteListAPI;

@end
@implementation AddressManager
-(void)addressList;
{
    if (self.listAPI == nil) {
        self.listAPI = [[AddressListAPIInteract alloc]init];
    }
    [self.listAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:AddressManagerTypeList data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:AddressManagerTypeList error:error];
        }
    }];
}

-(void)pickSelfSiteList
{
    if (self.pickSelfSiteListAPI == nil) {
        self.pickSelfSiteListAPI = [[PickSelfSiteListAPIInteract alloc]init];
    }
    [self.pickSelfSiteListAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:AddressManagerTypePickSelfSite data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:AddressManagerTypePickSelfSite error:error];
        }
    }];
}
@end
