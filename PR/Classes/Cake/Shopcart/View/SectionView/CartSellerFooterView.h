//
//  CartSellerFooterView.h
//  YHClouds
//
//  Created by 黄小雪 on 16/7/27.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartDataHandle.h"
#import "ShopCartSellerProductModel.h"
#import "CSXCartCellDefine.h"

@class CartSellerFooterView;
typedef void(^ShopcartDeleteSellerProductBlock)(NSInteger section);
typedef void(^ShopcartCommitSellerProductBlock)(NSInteger section);

@interface CartSellerFooterView : UITableViewHeaderFooterView
@property (copy,nonatomic) ShopcartDeleteSellerProductBlock  shopcartDeleteSellerProductBlock;
@property (copy,nonatomic) ShopcartCommitSellerProductBlock  shopcartCommitSellerProductBlock;


-(void)updateWithCartDataHandle:(CartDataHandle *)dataHandle
                    cartAllInfo:(ShopCartSellerProductModel *)cartAllInfo
                         isEdit:(BOOL)isEidt
                       isEnable:(BOOL)isEnable
                        section:(NSInteger)section;
+(CGFloat)getHeightWithCartDataHandle:(CartDataHandle *)dataHandle
                               isEdit:(BOOL)isEidt;



@end
