//
//  InPutView.h
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface InPutView : UIView
@property (strong,nonatomic) AddressModel *model;
-(void)updatePrompt:(NSString *)prompt placeholder:(NSString *)placeholder;
@end
