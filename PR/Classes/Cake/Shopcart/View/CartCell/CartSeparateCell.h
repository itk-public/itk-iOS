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

@class CartSeparateCell;
@protocol CartSeparateCellDelegate <NSObject>
@required
-(void)CartSeparateCellSeletedBtnOnClicked:(UIButton *)sender
                          cartSeparateCell:(CartSeparateCell *)cell
                         cartSeparateModel:(CartSeparateModel *)separatemodel;
@end

@interface CartSeparateCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void)updateWithSellerInfoModel:(CartSeparateModel *)model
                          editType:(ShopcartEditType)editType
                  CartDataHandle:(CartDataHandle *)dataHandle;
+(CGFloat)getHeight;


@property (weak,nonatomic) id<CartSeparateCellDelegate> delegate;
@end
