//
//  ShopCartCell.h
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
@class CartOrderCellViewModel;

typedef void (^ShopcartCellBlock)(BOOL isSelected);
typedef void (^ShopcartCellEditBlock)(NSInteger count);
typedef void (^ShopcartCellBeginEditBlock)(UITextField *textfiled);

@interface ShopCartCell : WTTableViewCell
+(CGFloat)getHeightWithCartOrderCellViewModel:(CartOrderCellViewModel *)vM;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong ) CartOrderCellViewModel  *vM;
@property (copy,nonatomic) ShopcartCellBlock          shopcartCellBlock;
@property (copy,nonatomic) ShopcartCellEditBlock      shopcartCellEditBlock;
@property (copy,nonatomic) ShopcartCellBeginEditBlock shopcartCellBeginEditBlock;

@end
