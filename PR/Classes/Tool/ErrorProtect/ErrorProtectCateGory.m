//
//  ErrorProtectCateGory.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ErrorProtectCateGory.h"
#import "NSObject+Category.h"

@implementation NSMutableDictionary (ErrorProtectMDicCateGory)

-(NSString *)stringByAppendingString:(NSString *)aString
{
    return aString;
}

-(id)safeObjectForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    
    if (object == [NSNull null]) {
        object = nil;
    }
    
    return object;
}

- (id)safeObjectForKey:(id)aKey hintClass:(id)cls
{
    id obj = [self safeObjectForKey:aKey];
    if (cls && [obj isKindOfClass:cls])
    {
        return obj;
    }
    return nil;
}

- (BOOL)safeSetObject:(id)obj forKey:(id)key
{
    if (nil == obj || nil == key)
    {
        return NO;
    }
    else
    {
        [self setObject:obj forKey:key];
    }
    return YES;
}

@end

@implementation NSDictionary (ErrorProtectDicCateGory)

-(NSString *)stringByAppendingString:(NSString *)aString
{
    return aString;
}

-(id)safeObjectForKey:(NSString *)aKey
{
    id object = [self objectForKey:aKey];
    
    if (object == [NSNull null]) {
        object = nil;
    }
    
    return object;
}

- (id)safeObjectForKey:(NSString *)aKey hintClass:(id)cls
{
    id obj = [self safeObjectForKey:aKey];
    if (cls && [obj isKindOfClass:cls])
    {
        return obj;
    }
    return nil;
}

- (id)safeObjectForKey:(NSString *)aKey hstringClass:(id)cls
{
    id obj = [self safeObjectForKey:aKey];
    if (cls && [obj isKindOfClass:cls])
    {
        return obj;
    }else if (cls && [obj isKindOfClass:[NSNumber class]])
    {
        return [obj stringValue];
    }
    return nil;
}

@end

@implementation NSUserDefaults (ErrorProtectUserDCateGory)

-(id)safeObjectForKey:(NSString *)aKey
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

- (id)safeObjectForKey:(NSString *)aKey hintClass:(id)cls
{
    id obj = [self safeObjectForKey:aKey];
    if (cls && [obj isKindOfClass:cls])
    {
        return obj;
    }
    return nil;
}

@end

@implementation NSString (ErrorProtectNSStringCateGory)

+ (id)safeStringWithString:(NSString *)string
{
    if (!string) {
        return @"";
    }
    
    return [NSString stringWithString:string];
}

@end

@implementation NSArray (Safe)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if(index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (id)safeObjectAtIndex:(NSUInteger)index hintClass:(id)cls
{
    id obj = [self safeObjectAtIndex:index];
    if (cls && [obj isKindOfClass:cls])
    {
        return obj;
    }
    return nil;
}

- (NSInteger)safeIndexOfObject:(id)object
{
    if (object != nil) {
        return [self indexOfObject:object];
    }
    else {
        return -1;
    }
}

@end


@implementation NSMutableArray (Safe)

- (void)safeRemoveObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        [self removeObjectAtIndex:index];
        return;
    }
    NSLog(@"warning: NSMutableArray out of bounds!");
}

- (void)safeAddObject:(id)obj
{
    if (nil != obj)
    {
        [self addObject:obj];
    }
    else
    {
        //	NSLog(@"warning:NSMutableArray try to add nil !");
    }
}
-(void)safeAddObjectsFromArray:(NSArray *)array
{
    if (array && array.count) {
        [self addObjectsFromArray:array];
    }
}

@end

