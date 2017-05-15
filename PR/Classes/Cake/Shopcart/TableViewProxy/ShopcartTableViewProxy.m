//
//  ShopcartTableViewProxy.m
//  YHClouds
//
//  Created by 黄小雪 on 2017/4/26.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "ShopcartTableViewProxy.h"
#import "CartSectionData.h"
#import "CartSellerHeaderView.h"
#import "CartSellerFooterView.h"
#import "CartSeparateModel.h"
#import "CartSeparateCell.h"
#import "ActionHandler.h"
#import "ShopCartCell.h"

@implementation ShopcartTableViewProxy

#pragma mark UITableViewDelegate UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.cartDataSoure) {
        return [self.cartDataSoure.sellerList.sellerArray count];
    }
    return 0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CartSectionData *setionData = [self.cartDataSoure sellerProductAtSection:section];
    if([setionData isKindOfClass:[CartSectionData class]]){
        return [setionData.sortedSellerProducts count];
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    static NSString *headerViewId = @"cartShopHeaderView";
    CartSellerHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
    if (headerView == nil) {
        headerView = [[CartSellerHeaderView alloc]initWithReuseIdentifier:headerViewId];
    }
    CartSectionData *setionData = [self.cartDataSoure sellerProductAtSection:section];
    if ([setionData isKindOfClass:[CartSectionData class]]) {
        [headerView updateWithSellerInfoModel:setionData.sellerProductModel.sellerInfo
                                       isEdit:setionData.isEdit
                               CartDataHandle:setionData.dataHandle
                                      section:section
                                        freightPromotionMsg:setionData.sellerProductModel.infoModel.freightPromotionMsg];
        __weak typeof(self)weakSelf = self;
        headerView.shopcartSelectSellerAllProductBlock = ^(BOOL isSelected,NSInteger section){
            if (weakSelf.shopcartProxySellerSelectBlock) {
                weakSelf.shopcartProxySellerSelectBlock(isSelected, section);
            }
        };
        
        headerView.shopcartEditSellerBlock  = ^(BOOL isEdit,NSInteger section){
            if (weakSelf.shopcartProxySellerEditBlock) {
                weakSelf.shopcartProxySellerEditBlock(isEdit, section);
            }
        };
        return headerView;
    }
    return nil;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    static NSString *footerViewId = @"cartShopfooterView";
    CartSellerFooterView *footerView = [[CartSellerFooterView alloc]initWithReuseIdentifier:footerViewId];
    if (footerView == nil) {
        footerView = [[CartSellerFooterView alloc]initWithReuseIdentifier:footerViewId];
    }
    CartSectionData *setionData = [self.cartDataSoure sellerProductAtSection:section];
    if ([setionData isKindOfClass:[CartSectionData  class]]) {
#warning commitBtnIsEnable
        [footerView updateWithCartDataHandle:setionData.dataHandle
                                 cartAllInfo:setionData.sellerProductModel
                                      isEdit:setionData.isEdit
                                    isEnable:YES
                                    section:section];
        
        __weak typeof(self)weakSelf = self;
        footerView.shopcartDeleteSellerProductBlock = ^(NSInteger section){
            if (weakSelf.shopcartProxyDeleteSellerProductBlock) {
                weakSelf.shopcartProxyDeleteSellerProductBlock(section);
            }
        };
        
        footerView.shopcartCommitSellerProductBlock = ^(NSInteger section){
            if (weakSelf.shopcartProxyCommitSellerProductBlock) {
                weakSelf.shopcartProxyCommitSellerProductBlock(section);
            }
        };
        return footerView;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CartSectionData *setionData = [self.cartDataSoure sellerProductAtSection:section];
    if ([setionData isKindOfClass:[CartSectionData class]] && [setionData.sortedSellerProducts count]) {
        return [CartSellerFooterView getHeightWithCartDataHandle:setionData.dataHandle
                                                          isEdit:setionData.isEdit];
    }
    return 1.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     CartSectionData *setionData = [self.cartDataSoure sellerProductAtSection:section];
    if ([setionData isKindOfClass:[CartSectionData class]] && [setionData.sortedSellerProducts count]) {
        return [CartSellerHeaderView getHeight:setionData.sellerProductModel.infoModel.freightPromotionMsg cartDataHandle:setionData.dataHandle];
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CartSectionData *setionData = [self.cartDataSoure sellerProductAtSection:indexPath.section];
    CartOrderCellViewModel *vM = [setionData.dataHandle.sortedSellerProducts safeObjectAtIndex:indexPath.row];
    if ([vM isKindOfClass:[CartOrderCellViewModel class]]) {
        return [ShopCartCell getHeightWithCartOrderCellViewModel:vM];
    }else if ([vM isKindOfClass:[CartSeparateModel class]]){
        return [CartSeparateCell getHeight];
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartSectionData *setionData = [self.cartDataSoure sellerProductAtSection:indexPath.section];
    id  vM = [setionData.dataHandle.sortedSellerProducts safeObjectAtIndex:indexPath.row];
    if ([vM isKindOfClass:[CartOrderCellViewModel class]]) {
        ProductOutline *model = ((CartOrderCellViewModel *)vM).product;
        if ([model isKindOfClass:[ProductOutline class]]) {
            ShopCartCell *cell         = [ShopCartCell cellWithTableView:tableView];
            cell.vM                     = vM;
            __weak typeof(self)weakSelf = self;
            cell.shopcartCellBlock      = ^(BOOL isSelected){
                if (weakSelf.shopcartProxyProductSelectBlock) {
                    weakSelf.shopcartProxyProductSelectBlock(isSelected, indexPath);
                }
            };
            cell.shopcartCellEditBlock  = ^(NSInteger count){
                if (weakSelf.shopcartProxyChangeCountBlock) {
                    weakSelf.shopcartProxyChangeCountBlock(count, indexPath);
                }
            };
            cell.shopcartCellBeginEditBlock = ^(UITextField *textfiled){
                if (weakSelf.shopcartProxyProductBeginEditBlock) {
                    weakSelf.shopcartProxyProductBeginEditBlock(textfiled);
                }
            };
            return cell;
        }
    }else if ([vM isKindOfClass:[CartSeparateModel class]]){
        CartSeparateCell *cell = [CartSeparateCell cellWithTableView:tableView];
        [cell updateWithSellerInfoModel:vM isEdit:setionData.isEdit CartDataHandle:setionData.dataHandle];
        return cell;
    }
    return nil;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartSectionData *setionData = [self.cartDataSoure sellerProductAtSection:indexPath.section];
    id data = [setionData.dataHandle.sortedSellerProducts safeObjectAtIndex:indexPath.row];
    if ([data isKindOfClass:[CartOrderCellViewModel class]]) {
        return UITableViewCellEditingStyleDelete;
    }
    return  UITableViewCellEditingStyleNone;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
   forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shopcartProxyDeleteBlock) {
        self.shopcartProxyDeleteBlock(indexPath);
    }
}



- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartSectionData *setionData = [self.cartDataSoure sellerProductAtSection:indexPath.section];
    id data = [setionData.dataHandle.sortedSellerProducts safeObjectAtIndex:indexPath.row];
    if ([data isKindOfClass:[CartOrderCellViewModel class]]) {
        return @"删除";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartSectionData *setionData  = [self.cartDataSoure sellerProductAtSection:indexPath.section];
    id info = [setionData.dataHandle.sortedSellerProducts safeObjectAtIndex:indexPath.row];
    if ([info isKindOfClass:[CartOrderCellViewModel class]]) {
        CartOrderCellViewModel *data = (CartOrderCellViewModel *)info;
        if (data.product.isOffTheShelf || data.product.isOutDelivered) return;
        ActionHandler *actionHandler = [ActionHandler handlerWithAction:data.product.action];
        [actionHandler run];
    }else if ([info isKindOfClass:[CartSeparateModel class]]){ //超出配送范围
    }
}



@end