//
//  HYCartOrderCell.h
//  YHClouds
//
//  Created by 黄小雪 on 15/10/20.
//  Copyright © 2015年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartOrderCellViewModel.h"
//#import "QuantityView.h"
#import "AppUIUtil.h"


typedef void (^ShopcartCellBlock)(BOOL isSelected);
typedef void (^ShopcartCellEditBlock)(NSInteger count);
typedef void (^ShopcartCellBeginEditBlock)(UITextField *textfiled);


typedef NS_ENUM(NSInteger,CartOrderCellBtnType){
    CartOrderCellBtnTypeDeleted = 3,
    CartOrderCellBtnTypeSeleted,
};


@interface CartOrderCell : UITableViewCell
@property (nonatomic, strong ) CartOrderCellViewModel  *vM;
@property (copy,nonatomic) ShopcartCellBlock          shopcartCellBlock;
@property (copy,nonatomic) ShopcartCellEditBlock      shopcartCellEditBlock;
@property (copy,nonatomic) ShopcartCellBeginEditBlock shopcartCellBeginEditBlock;

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)getHeightWithCartOrderCellViewModel:(CartOrderCellViewModel *)vM;


@end
