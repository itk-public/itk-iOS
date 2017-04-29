//
//  NSObject+YJSON.h
//  YHClouds
//
//  Created by biqiang.lai on 15/10/6.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "NSObject+YJSON.h"

@implementation NSObject (NSObject_FLJSON)

- (NSString *)JSONFragment
{
	NSData * theJsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
	return [[NSString alloc] initWithData:theJsonData encoding:NSUTF8StringEncoding];
}

- (NSString *)JSONRepresentation
{
	NSData * theJsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
	return [[NSString alloc] initWithData:theJsonData encoding:NSUTF8StringEncoding];
}
@end
