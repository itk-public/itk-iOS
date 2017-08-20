//
//  CartSellerBaseHeaderView.m
//  PR
//
//  Created by 黄小雪 on 2017/8/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CartSellerBaseHeaderView.h"

@implementation CartSellerBaseHeaderView

-(void)updateWithSellerInfoModel:(ShopDescInfo *)seller
                        editType:(ShopcartEditType)editType
                  CartDataHandle:(CartDataHandle *)dataHandle
                         section:(NSInteger)section
             freightPromotionMsg:(NSString *)freightPromotionMsg
{
    
}


+(CGFloat)getHeight:(NSString *)freightPromotionMsg cartDataHandle:(CartDataHandle *)dataHandle;
{
    return 0;
}

@end
