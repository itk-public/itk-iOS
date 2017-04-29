//
//  NSString+YJSON.m
//  YHClouds
//
//  Created by biqiang.lai on 15/10/6.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "NSString+YJSON.h"

@implementation NSString (NSString_FLJSON)

- (id)JSONFragmentValue
{
	NSData * theStrData = [self dataUsingEncoding:NSUTF8StringEncoding];
	return [NSJSONSerialization JSONObjectWithData:theStrData options:NSJSONReadingAllowFragments error:nil];
}

- (id)JSONValue
{
	NSData * theStrData = [self dataUsingEncoding:NSUTF8StringEncoding];
	return [NSJSONSerialization JSONObjectWithData:theStrData options:0 error:nil];
}

@end
