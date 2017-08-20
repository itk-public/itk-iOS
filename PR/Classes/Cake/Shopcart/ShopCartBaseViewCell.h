//
//  ShopCartBaseViewCell.h
//  PR
//
//  Created by 黄小雪 on 2017/8/10.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"

@class CartOrderCellViewModel;

typedef void (^ShopcartCellBlock)(BOOL isSelected);
typedef void (^ShopcartCellEditBlock)(NSInteger count);
typedef void (^ShopcartCellBeginEditBlock)(UITextField *textfiled);

@interface ShopCartBaseViewCell : WTTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)getHeightWithCartOrderCellViewModel:(CartOrderCellViewModel *)vM;

@property (nonatomic, strong ) CartOrderCellViewModel  *vM;
@property (copy,nonatomic) ShopcartCellBlock          shopcartCellBlock;
@property (copy,nonatomic) ShopcartCellEditBlock      shopcartCellEditBlock;
@property (copy,nonatomic) ShopcartCellBeginEditBlock shopcartCellBeginEditBlock;

@end
