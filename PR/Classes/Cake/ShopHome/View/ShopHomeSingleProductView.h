//
//  ShopHomeSingleProductView.h
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMiddleMargin  5
@class ProductOutline;

@interface ShopHomeSingleProductView : UIView
@property (strong,nonatomic) ProductOutline *product;
+(CGFloat)heightWithProduct:(ProductOutline *)product;
@end
