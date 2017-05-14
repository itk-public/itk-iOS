//
//  LocalShopCartProduct.h
//  YHClouds
//
//  Created by 黄小雪 on 16/8/2.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SellerDefine.h"

@interface LocalShopCartProduct : NSObject
@property (strong,nonatomic) NSString    *cid;         //商品ID
@property (assign,nonatomic) NSInteger    num;         //商品数量*100 数量为0 表示删除
@property (assign,nonatomic) BOOL         selectstate; //商品的选择状态 0:未选中 1：选中
@property (strong,nonatomic) NSString     *merid;
@property (assign,nonatomic) NSInteger     stocknum;
@property (strong,nonatomic) NSString     *stacktitle;
@property (strong,nonatomic) NSString     *updatetime;
@property (strong,nonatomic) NSString     *price;
@property (strong,nonatomic) NSString     *note;
- (NSDictionary *)convertToDict;
-(NSDictionary *)trackLogConvertToDict;


@end

