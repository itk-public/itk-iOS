//
//  CartDataHandle.m
//  YHClouds
//
//  Created by 黄小雪 on 16/5/5.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartDataHandle.h"
#import "CartOrderCellViewModel.h"
#import "ServiceCenter.h"
#import "CartSellerListModel.h"
#import "CartSeparateModel.h"
#import "CartViewDJStructure.h"
#import "CartViewData.h"
#import "LocalShopcartDataHandler.h"


@interface CartDataHandle()

@property (strong,nonatomic) LocalShopcartDataHandler   *dataBaseHandle;
//需要去删除的商品
@property (strong,nonatomic) NSMutableArray        *deleteProducts;
//排序后的商品
@property (strong,nonatomic)  NSMutableArray        *sortedProducts;

@property (strong,nonatomic)  CartViewDJStructure    *DJStructure;
@property (strong,nonatomic)  CartViewData           *cartViewData;

@end

@implementation CartDataHandle

#pragma mark 赋值方法
-(void)setSellerProduct:(ShopCartSellerProductModel *)sellerProduct isEdit:(BOOL)isEdit{
    CONDITION_CHECK_RETURN([sellerProduct isKindOfClass:[ShopCartSellerProductModel  class]]);
    _seller  = sellerProduct;
    [self.sortedProducts removeAllObjects];
    self.cartViewData =  [self.DJStructure viewDataArray:sellerProduct.productArr];
    // 将数据中库存不足、下架的情况筛选出来类型排序
    NSArray *temp = sellerProduct.productArr;
    for(CartOrderCellViewModel *viewModel in temp){
        if ([temp isKindOfClass:[CartOrderCellViewModel class]] &&
            (viewModel.product.isOutOfStock ||
             viewModel.product.isOffTheShelf ||
             viewModel.product.isOutDelivered)){
        //更新本地数据库中的商品的选中状态（库存不足、已下架、超出配送范围的选中状态置为NO）
            [self.dataBaseHandle updateProductWithProductId:viewModel.product.cid
                                                        num:viewModel.product.num
                                                 isSelected:NO
                                                     shopId:viewModel.product.shopid
                                                  extraInfo:nil];
        }
    }
    [self.sortedProducts safeAddObjectsFromArray:self.cartViewData.dataArray];
    [self upDateDataArrayBaseOnDelectedArray:isEdit];
    [self adjustFinalCellBottomLineView];
}


-(NSMutableArray *)sortedSellerProducts
{
    return self.sortedProducts;
}

#pragma mark public method
#pragma mark 获取各种状态下的商品总个数
//可正常购买的商品个数
-(NSInteger)countOfNormalArr{
    NSInteger sumnum = 0;
    for (CartOrderCellViewModel *vm in self.cartViewData.dataArray)
    {
        if (vm && [vm isKindOfClass:[CartOrderCellViewModel class]] &&
            vm.product.isOutOfStock == NO &&
            vm.product.isOffTheShelf == NO &&
            vm.product.isOutDelivered == NO )
            sumnum ++;
    }
    return sumnum;
}

//库存不足的商品个数
-(NSInteger)countOfOutOfStockArr{
    NSInteger sumnum = 0;
    for (CartOrderCellViewModel *vm in self.cartViewData.dataArray) {
        if (vm && [vm isKindOfClass:[CartOrderCellViewModel class]] &&
            vm.product.isOutOfStock == YES &&
            vm.product.isOutDelivered == NO &&
            vm.product.isOffTheShelf == NO) {
            sumnum ++;
        }
    }
    return sumnum;
}

//下架商品的个数
-(NSInteger)countOfOffTheShelfArr{
    NSInteger sumnum = 0;
    for (CartOrderCellViewModel *vm in self.cartViewData.dataArray) {
        if (vm && [vm isKindOfClass:[CartOrderCellViewModel class]] &&
            vm.product.isOffTheShelf == YES &&
            vm.product.isOutDelivered == NO ){
            sumnum ++;
        }
    }
    return sumnum;
}

//删除的商品的个数
-(NSInteger)countOfSeletedToDeletedArr{
    return [self.deleteProducts count];
}

//超出配送范围的个数
-(NSInteger)countOfOutOfDelivered{
    return [self.cartViewData countOfOutOfDeliveredWithType:PTDeliverySlow] +
   [self.cartViewData countOfOutOfDeliveredWithType:PTDeliveryFast] +
    [self.cartViewData countOfOutOfDeliveredWithType:PTDeliveryEP];
}

// 获取选中的商品数组
-(NSArray *)productSeleted
{
    NSMutableArray *temp = [NSMutableArray array];
    for (CartOrderCellViewModel *vM in self.seller.productArr) {
        if ([vM isKindOfClass:[CartOrderCellViewModel class]]) {
            if (vM.product.isOutOfStock == NO &&
                vM.product.isOffTheShelf == NO &&
                vM.product.isOutDelivered == NO &&
                vM.product.isSelected) {
                [temp addObject:vM];
            }
        }
    }
    return temp;
}


//调整最后一个cell的底部的线条的长度
-(void)adjustFinalCellBottomLineView
{
    if([self.sortedProducts count]){
        CartOrderCellViewModel *lastVm = [self.sortedProducts lastObject];
        if ([lastVm isKindOfClass:[CartOrderCellViewModel class]]) {
            lastVm.bottomLineHide          = YES;
        }
    }
}

//清空删除的商品
-(void)emptyDeleteProducts
{
    [self.deleteProducts removeAllObjects];
}

-(void)removeProduct:(CartOrderCellViewModel *)model;
{
    CONDITION_CHECK_RETURN([model isKindOfClass:[CartOrderCellViewModel class]]);
    NSArray *temp    = [NSArray arrayWithArray:self.sortedProducts];
    for (NSInteger i = temp.count - 1;i >= 0; i --) {
        CartOrderCellViewModel *vM = [temp
                                      safeObjectAtIndex:i
                                      hintClass:[CartOrderCellViewModel class]];
        if ([vM.product.cid isEqualToString:model.product.cid]) {
            if ( [self.dataBaseHandle deleteProductWithProductId:model.product.cid
                                                          shopId:model.product.shopid]) {
                [self removerItem:vM inArray:self.sortedProducts];
                [self.seller.productArr removeObject:vM];
            }
            break;
        }
        
    }
}
//当前商家的中的所有商品种类数
-(NSInteger)countOfSellerProduct
{
    NSInteger count = 0;
    for (CartOrderCellViewModel *vM in self.sortedProducts) {
        if ([vM isKindOfClass:[CartOrderCellViewModel class]]) {
            count ++;
        }
    }
    return count;
}

#pragma mark private method
//从数组里删除商品
-(BOOL)removerItem:(CartOrderCellViewModel *)model inArray:(NSMutableArray *)array
{
    CONDITION_CHECK_RETURN_VAULE([array count], NO);
    for (CartOrderCellViewModel *vm in array) {
        if ([vm isKindOfClass:[CartOrderCellViewModel class]] &&
            [vm.product.cid isEqualToString:model.product.cid]) {
            [array removeObject:model];
            return YES;
        }
    }
    return NO;
}

//添加商品到删除数组
-(BOOL)deleteProductsAddItem:(CartOrderCellViewModel *)model
{
    CONDITION_CHECK_RETURN_VAULE([model isKindOfClass:[CartOrderCellViewModel class]], NO);
    if (model.product.cid.length == 0) return NO;
    for (CartOrderCellViewModel *vm in self.deleteProducts) {
        if ([vm isKindOfClass:[CartOrderCellViewModel class]]) {
            if ([vm.product.cid isEqualToString:model.product.cid])
                return NO;
        }
    }
    [self.deleteProducts safeAddObject:model];
    return YES;
}

//删除所有选中的商品
-(BOOL)deleteAllSeletedProducts
{
    NSArray *tempArray = [NSArray arrayWithArray:self.deleteProducts];
    for (CartOrderCellViewModel *vm in tempArray) {
        if ([vm isKindOfClass:[CartOrderCellViewModel class]]) {
            if ([self.dataBaseHandle deleteProductWithProductId:vm.product.cid
                                                           shopId:vm.product.shopid]) {
                [self removerItem:vm inArray:self.sortedProducts];
                [self removerItem:vm inArray:self.deleteProducts];
                [self.seller.productArr removeObject:vm];
            }
        }
    }
    return YES;
}

//指定type下选中的商品
-(NSArray *)productSelectedWithType:(PTDeliveryType)type
{
    NSArray *tempArr = [self.cartViewData.productSort acquireDataOfCategory:type];
    CONDITION_CHECK_RETURN_VAULE([tempArr isKindOfClass:[NSArray class]]
                                 && tempArr.count, nil);
    NSMutableArray * gays = [NSMutableArray array];
    for (CartOrderCellViewModel *vM in tempArr) {
        if ([vM isKindOfClass:[CartOrderCellViewModel class]]) {
            ProductOutline * aProduct = vM.product;
            if (aProduct.isSelected &&!aProduct.isOffTheShelf&& !aProduct.isOutOfStock &&  !aProduct.isOutDelivered) {
                [gays safeAddObject:vM];
            }
        }
    }
    return gays;
}

//更新所有商品的编辑状态
-(BOOL)upDateAllProductEditState:(BOOL)isEdit
{
    [self emptyDeleteProducts];
    for (CartOrderCellViewModel *vM  in self.sortedProducts) {
        if ([vM isKindOfClass:[CartOrderCellViewModel class]]) {
            vM.isEdit                  = isEdit;
            vM.deletedState            = NO;
        }
    }
    return YES;
}
//更新商品的编辑状态和是否删除状态
-(BOOL)upDateModel:(CartOrderCellViewModel *)vm isEdit:(BOOL)isEdit seletedState:(BOOL)seletedState
{
    vm.isEdit  = isEdit;
    if (isEdit) { //编辑状态下
        vm.deletedState = seletedState;
        if (seletedState) {
            [self  deleteProductsAddItem:vm];
        }else{
            [self removerItem:vm inArray:self.deleteProducts];
        }
    }else{ //结算状态下
        vm.product.isSelected = seletedState;
    }
    return YES;
}

// 根据self.seletedToDeletedArr的值，修改vm的中的isSelectedToDeleted的值
-(void)upDateDataArrayBaseOnDelectedArray:(BOOL)isEdit
{
    if(!isEdit) return;
    CONDITION_CHECK_RETURN([self.sortedProducts count]);
    for (CartOrderCellViewModel *vM in self.sortedProducts) {
        if ([vM isKindOfClass:[CartOrderCellViewModel class]]) {
            vM.isEdit                  = isEdit;
            for (CartOrderCellViewModel *deleteVm in self.deleteProducts ) {
                if ([deleteVm isKindOfClass:[CartOrderCellViewModel class]] && [deleteVm.product.cid isEqualToString:vM.product.cid]) {
                     vM.deletedState = YES;
                }
            }
        }
    }
}

#pragma mark 懒加载
-(NSMutableArray *)sortedProducts
{
    if (!_sortedProducts) {
        _sortedProducts = [[NSMutableArray alloc]init];
    }
    return _sortedProducts;
}

-(NSMutableArray *)deleteProducts
{
    if (!_deleteProducts) {
        _deleteProducts = [[NSMutableArray alloc]init];
    }
    return _deleteProducts;
}

-(LocalShopcartDataHandler *)dataBaseHandle
{
    if (!_dataBaseHandle) {
        _dataBaseHandle = [LocalShopcartDataHandler sharedInstance];
    }
    return _dataBaseHandle;
}

-(CartViewDJStructure *)DJStructure{
    if (!_DJStructure) {
        _DJStructure = [[CartViewDJStructure alloc]init];
    }
    return _DJStructure;
}

@end
