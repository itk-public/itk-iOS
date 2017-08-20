//
//  CartSeparateModel.h
//  YHClouds
//
//  Created by 黄小雪 on 16/9/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartModelDefine.h"

@interface CartSeparateModel : NSObject
@property (readonly,nonatomic ) NSString       *prompt;
@property (readonly,nonatomic ) NSString       *title;
@property (nonatomic, assign  ) PTDeliveryType type;
@end
