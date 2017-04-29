//
//  IGSecurityPolicy.h
//  PR
//
//  Created by 黄小雪 on 23/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface IGSecurityPolicy : AFSecurityPolicy
+(IGSecurityPolicy *)customSecurityPolicy;
@end
