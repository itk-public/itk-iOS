//
//  PhoneQuickLoginAPIInteract.h
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "BaseAPIInteract.h"

@interface PhoneQuickLoginAPIInteract : BaseAPIInteract
@property (strong,nonatomic) NSString *phoneNum;
@property (strong,nonatomic) NSString *safetyCode;
@end