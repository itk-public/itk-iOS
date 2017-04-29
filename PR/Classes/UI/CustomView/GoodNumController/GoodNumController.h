//
//  GoodNumController.h
//  PR
//
//  Created by 黄小雪 on 28/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInfo.h"

#define kWidth  156
#define kHeight 38

@class GoodNumController;

@protocol GoodNumControllerDelegate <NSObject>
@optional
-(void)goodNumControllerNumChanged:(GoodNumController *)goodNumController
                       changeToNum:(NSInteger)num;
-(void)goodNumControllerTextFiledDidBeginEditing:(GoodNumController *)goodNumController;
-(void)goodNumControllerTextFiledDidFinshedEdited:(GoodNumController *)goodNumController;

@end
@interface GoodNumController : UIButton
@property (weak,nonatomic) id<GoodNumControllerDelegate> delegate;
@property (strong,nonatomic) ProductInfo *product;

@end
