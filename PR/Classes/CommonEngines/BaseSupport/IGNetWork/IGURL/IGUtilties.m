//
//  IGUtilties.m
//  PR
//
//  Created by 黄小雪 on 10/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "IGUtilties.h"

@implementation IGUtilties

+(NSString *)decodeURL:(NSString *)string
{
    return (NSString*)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)string,CFSTR(""),kCFStringEncodingUTF8));
}

+(NSString *)encodeURL:(NSString *)string
{
    NSString *newString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return @"";
}
@end
