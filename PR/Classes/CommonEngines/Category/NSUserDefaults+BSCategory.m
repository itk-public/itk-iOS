//
//  NSUserDefaults+BSCategory.m
//  PR
//
//  Created by 黄小雪 on 17/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "NSUserDefaults+BSCategory.h"
#import "NSObject+BSCategory.h"

@implementation NSUserDefaults (BSCategory)
-(id)bsSafeObjectForKey:(NSString *)aKey
{
    
    if (aKey == nil || [self isNilOrNull]) {
        return nil;
    }
    id object = [self objectForKey:aKey];
    if (object==nil || object == [NSNull null]) {
        return @"";
    }
    return object;
    
}

- (id)bsSafeObjectForKey:(NSString *)aKey hintClass:(id)cls
{
    id obj = [self bsSafeObjectForKey:aKey];
    if (cls && [obj isKindOfClass:cls])
    {
        return obj;
    }
    return nil;
}


@end
