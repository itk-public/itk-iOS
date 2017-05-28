//
//  ShopCartTableFooterView.h
//  PR
//
//  Created by 黄小雪 on 2017/5/28.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartTableViewDataSource.h"

typedef void(^ShopCartTableFooterViewDidClickSelectBtnBlock)(BOOL isSelected);
typedef void(^ShopCartTableFooterViewDidClickCommitBtnBlock)();

@interface ShopCartTableFooterView : UIView
@property (copy,nonatomic) ShopCartTableFooterViewDidClickCommitBtnBlock commitBtnBlock;
@property (copy,nonatomic) ShopCartTableFooterViewDidClickSelectBtnBlock selectBtnBlock;
+(CGFloat)height;
-(void)updateWithCartTableViewDataSource:(CartTableViewDataSource *)dataSource;
@end
