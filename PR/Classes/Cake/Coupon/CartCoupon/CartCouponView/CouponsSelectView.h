//
//  CouponsSelectView.h
//  PR
//
//  Created by 黄小雪 on 28/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartCoupons.h"

@interface CouponsSelectView : UIView
+(instancetype)defaultCouponsSelectView;
@property (strong,nonatomic) CartCoupons *cartCoupons;
-(void)show;

@end
