//
//  CategoryLeftViewController.h
//  PR
//
//  Created by 黄小雪 on 2017/6/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTTableViewController.h"
@class ShopCategoryModel;

typedef void (^DidSelectedCategoryBlock)(ShopCategoryModel *selectedCategroy);
@interface CategoryLeftViewController : WTTableViewController
-(void)loadData;
@property (copy,nonatomic) DidSelectedCategoryBlock returnBlock;

@end