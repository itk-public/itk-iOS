//
//  ShopCartDiscountCell.h
//  PR
//
//  Created by 黄小雪 on 2017/9/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartDiscountModel.h"

@interface ShopCartDiscountCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)getHeightWithCartOrderCellViewModel:(id)vM;
@property (strong,nonatomic) ShopCartDiscountModel *discountModel;

@end
