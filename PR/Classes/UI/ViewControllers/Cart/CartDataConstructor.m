//
//  CartDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 21/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartDataConstructor.h"
#import "ShopCartCell.h"
#import "CartShopInfoViewCell.h"
#import "SeparateCell.h"
#import "CartManager.h"
#import "CartUIModel.h"
#import "CartShopUIModel.h"
#import "CartProductInfo.h"
#import "ShopCartInfo.h"

def_msignal(ShopCardEditSignal);

@interface CartDataConstructor()<CartManagerDelegate>
@property (strong,nonatomic) CartManager *cartManager;
@property (strong,nonatomic) CartUIModel  *responseData;

@end
@implementation CartDataConstructor

-(void)loadData
{
    if (self.cartManager == nil) {
        self.cartManager = [[CartManager alloc]init];
        self.cartManager.delegate = self;
    }
    [self.cartManager refreshCart];
}
-(void)constructData
{
    CONDITION_CHECK_RETURN([self.responseData isKindOfClass:[CartUIModel class]]);
     [self.items removeAllObjects];
    NSInteger i = 0;
    for (CartShopUIModel *info in self.responseData.cartList) {
        if ([info isKindOfClass:[CartShopUIModel class]]) {
            ShopDescInfo *shopInfo = info.shopInfo;
            shopInfo.cellType      = @"cartshopInfoViewCell";
            shopInfo.cellClass     = [CartShopInfoViewCell class];
            [self.items safeAddObject:shopInfo];
            
            NSArray *products = info.products;
            for (CartProductInfo *product  in products) {
                if ([product isKindOfClass:[CartProductInfo class]]) {
                    product.cellType         = @"shopCartCell";
                    product.cellClass        = [ShopCartCell class];
                    [self.items addObject:product];
                }
            }
            if (i < [self.responseData.cartList count] - 1) {
                SeparateModel *separateModel = [[SeparateModel  alloc]init];
                separateModel.cellClass = [SeparateCell class];
                separateModel.cellType = @"separatecell";
                [self.items addObject:separateModel];
            }
            i ++;
        }
    }
    
}


#pragma mark  CartManagerDelegate
- (void)requestSuccess:(id)modelData isCache:(BOOL)isCache
{
    self.responseData = modelData;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
        [self.delegate dataConstructor:self didFinishLoad:(NSObject *)self.responseData];
    }
}

- (void)requestFailed:(id)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}

@end
