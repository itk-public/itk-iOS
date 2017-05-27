//
//  AdjustQuantityView.h
//  YHClouds
//
//  Created by 黄小雪 on 15/10/28.
//  Copyright © 2015年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kWidth  (177 * DDDisplayScale)
#define kHeight 38

@class CartOrderCellViewModel;
typedef void (^QuantityViewEditBlock)(NSInteger count);
typedef void (^QuantityViewBeginEditBlock)(UITextField *textfiled);

@interface QuantityView : UIButton

@property (nonatomic,strong) CartOrderCellViewModel  *tempModel;
@property (copy,nonatomic) QuantityViewEditBlock      quantityViewEditBlock;
@property (copy,nonatomic) QuantityViewBeginEditBlock quantityViewBeginEditBlock;

-(void)quantityViewEnable:(BOOL)isEnable addBtnEnable:(BOOL)addBtnEnable;
-(void)updateQuantityViewCount:(NSInteger)count;
-(NSInteger)quantityViewCount;
@end
