//
//  RegisterAPIInteract.h
//  PR
//
//  Created by 黄小雪 on 2017/5/15.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "BaseAPIInteract.h"
@interface RegisterAPIInteract : BaseAPIInteract
@property (strong,nonatomic) NSString *phoneNum;
@property (strong,nonatomic) NSString *securityCode;
@property (strong,nonatomic) NSString *pwd;
@end
