//
//  ProductImageView2.h
//  PR
//
//  Created by 黄小雪 on 16/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInfo.h"
/*
 * 一行显示三个商品的cell中使用
 */

@interface ProductImageView2 : UIView
@property (strong,nonatomic) ProductInfo *info;
@end
