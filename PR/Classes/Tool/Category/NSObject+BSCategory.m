//
//  NSObject+BSCategory.m
//  PR
//
//  Created by 黄小雪 on 17/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "NSObject+BSCategory.h"

@implementation NSObject (BSCategory)
- (BOOL)isNilOrNull{
    BOOL flag = self && self != [NSNull null];
    return !flag;
}

@end
