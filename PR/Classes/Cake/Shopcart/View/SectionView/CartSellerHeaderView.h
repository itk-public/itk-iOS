//
//  CartSellerHeaderView.h
//  YHClouds
//
//  Created by 黄小雪 on 16/7/26.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDescInfo.h"
#import "CartDataHandle.h"

typedef void(^ShopcartSelectSellerAllProductBlock)(BOOL isSelected,NSInteger section);
typedef void (^ShopcartEditSellerBlock)(ShopcartEditType editType,NSInteger section);

@interface CartSellerHeaderView : UITableViewHeaderFooterView
@property (copy,nonatomic) ShopcartSelectSellerAllProductBlock shopcartSelectSellerAllProductBlock;
@property (copy,nonatomic) ShopcartEditSellerBlock             shopcartEditSellerBlock;

-(void)updateWithSellerInfoModel:(ShopDescInfo *)seller
                        editType:(ShopcartEditType)editType
                  CartDataHandle:(CartDataHandle *)dataHandle
                         section:(NSInteger)section
             freightPromotionMsg:(NSString *)freightPromotionMsg;

+(CGFloat)getHeight:(NSString *)freightPromotionMsg cartDataHandle:(CartDataHandle *)dataHandle;

@end
