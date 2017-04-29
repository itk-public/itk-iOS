//
//  CartManager.m
//  PR
//
//  Created by 黄小雪 on 15/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartManager.h"
#import "CartAPIInteract.h"

@interface CartManager()
@property (strong,nonatomic) CartAPIInteract *cartAPI;

@end
@implementation CartManager
-(BOOL)refreshCart
{
    if (self.cartAPI == nil) {
        self.cartAPI = [[CartAPIInteract alloc] init];
    }
     [self.cartAPI interactScuess:^(BaseAPIInteract *interact, id modelData){
         if (self.delegate && [self.delegate respondsToSelector:@selector(requestSuccess:isCache:)]) {
             [self.delegate requestSuccess:modelData isCache:NO];
         }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestFailed:)]) {
            [self.delegate requestFailed:error];
        }
    }];
    return YES;
}
@end
