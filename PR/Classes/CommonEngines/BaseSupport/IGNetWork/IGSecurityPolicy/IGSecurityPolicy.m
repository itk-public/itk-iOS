//
//  IGSecurityPolicy.m
//  PR
//
//  Created by 黄小雪 on 23/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "IGSecurityPolicy.h"

@implementation IGSecurityPolicy

+ (NSString *)pathForResource:(NSString *)name ofType:(NSString *)type
{
    return  [[NSBundle mainBundle] pathForResource:name  ofType:type inDirectory:@"IGNResource.bundle"];
}

+(IGSecurityPolicy *)customSecurityPolicy
{
    return (IGSecurityPolicy *)[AFSecurityPolicy defaultPolicy];
}
@end
