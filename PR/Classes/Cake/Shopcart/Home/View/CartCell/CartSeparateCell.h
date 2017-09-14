//
//  CartSeparateCellTableViewCell.h
//  YHClouds
//
//  Created by 黄小雪 on 16/9/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartSeparateModel.h"
#import "CartDataHandle.h"

@interface CartSeparateCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)getHeight;
@end
