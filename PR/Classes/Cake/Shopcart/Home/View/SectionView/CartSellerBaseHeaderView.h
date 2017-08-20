//
//  CartSellerBaseHeaderView.h
//  PR
//
//  Created by 黄小雪 on 2017/8/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDescInfo.h"
#import "CartDataHandle.h"
#import "CartSellerBaseHeaderView.h"

typedef void(^ShopcartSelectSellerAllProductBlock)(BOOL isSelected,NSInteger section);
typedef void (^ShopcartEditSellerBlock)(ShopcartEditType editType,NSInteger section);

@interface CartSellerBaseHeaderView : UITableViewHeaderFooterView
@property (copy,nonatomic) ShopcartSelectSellerAllProductBlock shopcartSelectSellerAllProductBlock;
@property (copy,nonatomic) ShopcartEditSellerBlock             shopcartEditSellerBlock;

-(void)updateWithSellerInfoModel:(ShopDescInfo *)seller
                        editType:(ShopcartEditType)editType
                  CartDataHandle:(CartDataHandle *)dataHandle
                         section:(NSInteger)section
             freightPromotionMsg:(NSString *)freightPromotionMsg;

+(CGFloat)getHeight:(NSString *)freightPromotionMsg cartDataHandle:(CartDataHandle *)dataHandle;


@end
