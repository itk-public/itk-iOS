//
//  OrderStatusView.h
//  YHClouds
//
//  Created by 黄小雪 on 16/2/29.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonOnClickedBlock) (NSInteger titleBtnIndex);

@interface MutiTitleHeaderView : UIView
/**
 *  订单状态按钮的title
 */
@property (strong,nonatomic) NSArray           *statusBtnTitles;
@property (copy,nonatomic)   ButtonOnClickedBlock  buttonBlock;
@property (assign,nonatomic) CGFloat             fontSize;

- (void)setSeletedIndex:(NSInteger)titleIndex;
-(void)upDateButtonTitle:(NSString *)title  index:(NSInteger)index;
-(void)setSelectedColor:(UIColor *)selectedColor  normalColor:(UIColor *)normalColor;
-(void)setLineViewWidth:(CGFloat)width;
@end
