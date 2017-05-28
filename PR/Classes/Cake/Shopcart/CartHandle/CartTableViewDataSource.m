//
//  CartTableViewDataSource.m
//  YHClouds
//
//  Created by 黄小雪 on 16/8/15.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartTableViewDataSource.h"
#import "CartDataHandle.h"
#import "ShopCartSellerProductModel.h"

@interface CartTableViewDataSource()
@property (strong,nonatomic)  NSMutableArray      *sectionDatas;
@end

@implementation CartTableViewDataSource

-(NSMutableArray *)cartDataHandles{
    if (!_sectionDatas) {
        _sectionDatas = [NSMutableArray array];
    }
    return _sectionDatas;
}

-(void)setUnEidt
{
    CONDITION_CHECK_RETURN(self.sectionDatas.count);
    for (CartSectionData *sectionData in self.sectionDatas) {
        if ([sectionData isKindOfClass:[CartSectionData class]]) {
             sectionData.editType           = ShopcartEditTypeNone;
        }
    }
}


-(void)setSellerList:(CartSellerListModel *)sellerList{
    CONDITION_CHECK_RETURN([sellerList isKindOfClass:[CartSellerListModel class]]);
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.sectionDatas];
    [self.sectionDatas removeAllObjects];
    _sellerList = sellerList;
    for (ShopCartSellerProductModel  *cartAllInfo in sellerList.sellerArray) {
        if ([cartAllInfo isKindOfClass:[ShopCartSellerProductModel class]]) {
            CartSectionData *section  = [self getSectionDataWithSellerid:cartAllInfo.sellerInfo.cid
                                                            sectionDatas:temp];
            if (section == nil) {
                section = [[CartSectionData alloc]init];
                section.sellerid = cartAllInfo.sellerInfo.cid;
            }
            [section setSellerProducts:cartAllInfo];
            [self.cartDataHandles safeAddObject:section];
        }
    }
}


-(CartSectionData *)getSectionDataWithSellerid:(NSString *)sellerid sectionDatas:(NSMutableArray *)array
{
    CONDITION_CHECK_RETURN_VAULE(sellerid.length, nil);
    for (CartSectionData *sellerData in array) {
        if ([sellerData isKindOfClass:[CartSectionData class]] && sellerData.sellerid.length && [sellerData.sellerid isEqualToString:sellerid]) {
             return sellerData;
        }
    }
    return nil;
}

-(CartSectionData *)sellerProductAtSection:(NSInteger)section
{
    CONDITION_CHECK_RETURN_VAULE(self.sectionDatas || self.sectionDatas.count, nil);
    return [self.sectionDatas safeObjectAtIndex:section hintClass:[CartSectionData class]];
}

@end
