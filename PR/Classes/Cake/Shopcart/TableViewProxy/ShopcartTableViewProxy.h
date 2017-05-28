//
//  ShopcartTableViewProxy.h
//  YHClouds
//
//  Created by 黄小雪 on 2017/4/26.
//  Copyright © 2017年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartTableViewDataSource.h"
#import "CartInfoDefine.h"

typedef void (^ShopcartProxyProductSelectBlock)(BOOL isSelected,NSIndexPath *indexPath);
typedef void (^ShopcartProxySellerSelectBlock)(BOOL isSelected,NSInteger section);
typedef void (^ShopcartProxyChangeCountBlock)(NSInteger count,NSIndexPath *indexPath);
typedef void (^ShopcartProxyDeleteBlock)(NSIndexPath *indexPath);
typedef void (^ShopcartProxySellerEditBlock)(ShopcartEditType editType,NSInteger section);
typedef void (^ShopcartProxyDeleteSellerProductBlock)(NSInteger section);
typedef void (^ShopcartProxyCommitSellerProductBlock)(NSInteger section);
typedef void (^ShopcartProxyProductBeginEditBlock)(UITextField *textfiled);


@interface ShopcartTableViewProxy : NSObject<UITableViewDelegate,UITableViewDataSource>

//数据源
@property (strong,nonatomic) CartTableViewDataSource           * cartDataSoure;
//勾选商品
@property (copy,nonatomic) ShopcartProxyProductSelectBlock       shopcartProxyProductSelectBlock;
//全选或全非选操作
@property (copy,nonatomic) ShopcartProxySellerSelectBlock         shopcartProxySellerSelectBlock;
//修改个数
@property (copy,nonatomic) ShopcartProxyChangeCountBlock          shopcartProxyChangeCountBlock;
//删除一个商品
@property (copy,nonatomic) ShopcartProxyDeleteBlock               shopcartProxyDeleteBlock;
//点击编辑
@property (copy,nonatomic) ShopcartProxySellerEditBlock           shopcartProxySellerEditBlock;
//删除选中的商品
@property (copy,nonatomic) ShopcartProxyDeleteSellerProductBlock  shopcartProxyDeleteSellerProductBlock;
//去结算
@property (copy,nonatomic) ShopcartProxyCommitSellerProductBlock  shopcartProxyCommitSellerProductBlock;
@property (copy,nonatomic) ShopcartProxyProductBeginEditBlock     shopcartProxyProductBeginEditBlock;




@end
