//
//  CartTableViewDataSource.h
//  YHClouds
//
//  Created by 黄小雪 on 16/8/15.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartSectionData.h"
#import "CartSellerListModel.h"

@interface CartTableViewDataSource : NSObject
@property (strong,nonatomic)  CartSellerListModel *sellerList;

-(CartSectionData *)sellerProductAtSection:(NSInteger)section;
@property (assign,nonatomic)  ShopcartEditType editType;

@end
