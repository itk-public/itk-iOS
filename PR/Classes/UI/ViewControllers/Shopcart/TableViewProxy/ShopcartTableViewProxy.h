//
//  ShopcartTableViewProxy.h
//  PR
//
//  Created by 黄小雪 on 2017/4/6.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ShopcartProxyProductSelectBlock)(BOOL isSelected,NSIndexPath *indexPath);

typedef void (^ShopcartProxyBrandSelectBlock)(BOOL isSelected,NSInteger section);

typedef void (^ShopcartProxyChangeCountBlock)(NSInteger count,NSIndexPath *indexPath);

typedef void (^ShopcartProxyDeleteBlock)(NSIndexPath *indexPath);

typedef void (^ShopcartProxyStarBlock)(NSIndexPath *indexPath);

@interface ShopcartTableViewProxy : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (nonatomic, copy) ShopcartProxyProductSelectBlock shopcartProxyProductSelectBlock;
@property (nonatomic, copy) ShopcartProxyBrandSelectBlock shopcartProxyBrandSelectBlock;
@property (nonatomic, copy) ShopcartProxyChangeCountBlock shopcartProxyChangeCountBlock;
@property (nonatomic, copy) ShopcartProxyDeleteBlock shopcartProxyDeleteBlock;
@property (nonatomic, copy) ShopcartProxyStarBlock shopcartProxyStarBlock;
@end
