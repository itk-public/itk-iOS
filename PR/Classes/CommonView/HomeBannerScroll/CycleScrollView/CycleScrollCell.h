//
//  CycleScrollCell.h
//  YHClouds
//
//  Created by YH on 15/12/7.
//  Copyright © 2015年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleScrollCell : UICollectionViewCell
@property (weak, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) NSString *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;

@property (nonatomic, assign) BOOL hasConfigured;


@end
