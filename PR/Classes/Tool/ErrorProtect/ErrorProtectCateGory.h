//
//  ErrorProtectCateGory.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (ErrorProtectMDicCateGory)

-(NSString *)stringByAppendingString:(NSString *)aString;

-(id)safeObjectForKey:(id)aKey;

- (id)safeObjectForKey:(id)aKey hintClass:(Class)cls;

- (BOOL)safeSetObject:(id)obj forKey:(id)key;

@end

@interface NSDictionary (ErrorProtectDicCateGory)

-(NSString *)stringByAppendingString:(NSString *)aString;

-(id)safeObjectForKey:(NSString *)aKey;

- (id)safeObjectForKey:(NSString*)aKey hintClass:(Class)cls;

- (id)safeObjectForKey:(NSString *)aKey hstringClass:(id)cls;
@end

@interface NSUserDefaults (ErrorProtectUserDCateGory)

-(id)safeObjectForKey:(NSString *)aKey;

- (id)safeObjectForKey:(NSString*)aKey hintClass:(Class)cls;

@end

@interface NSString (ErrorProtectNSStringCateGory)

+ (id)safeStringWithString:(NSString *)string;

@end

@interface NSArray (Safe)

- (id)safeObjectAtIndex:(NSUInteger)index;
- (NSInteger)safeIndexOfObject:(id)object;

- (id)safeObjectAtIndex:(NSUInteger)index hintClass:(Class)cls;

@end

@interface NSMutableArray (Safe)

- (void)safeRemoveObjectAtIndex:(NSUInteger)index;

- (void)safeAddObject:(id)obj;
-(void)safeAddObjectsFromArray:(NSArray *)array;

@end


