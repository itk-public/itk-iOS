//
//  NSString+Category.m
//  PR
//
//  Created by 黄小雪 on 12/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+(BOOL)isValidatePhoneNum:(NSString *)phoneNum
{
    //去掉手机号前面的空格
    NSString *phone = [phoneNum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *MOBILE = @"^1[0-9]{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:phone]) {
        
        return YES;
    }
    return NO;
}


+(BOOL)isBlankString:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    NSInteger length = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length];
    
    if (length==0) {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"null"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

-(NSString *)trimmingSpaceOfString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(NSString *)stringByAddingURLParams:(NSDictionary *)param
{
    NSString *string = self;
    if (param) {
        NSMutableArray *pairArray = [NSMutableArray array];
        for (NSString *key in param) {
            NSString *value = [NSString stringWithFormat:@"%@",[param safeObjectForKey:key]]?:@"";
            NSString *keyEscaped = [key urlEncoding];
            NSString *valueEscpaped = [value urlEncoding];
            NSString *pair    = [NSString stringWithFormat:@"%@=%@",keyEscaped,valueEscpaped];
            [pairArray addObject:pair];
        }
        NSString *query = [pairArray componentsJoinedByString:@"&"];
        string          = [NSString stringWithFormat:@"%@?%@",self,query];
    }
    return string;
}

// 对字符串URLencode编码
-(NSString *)urlEncoding
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

// 对字符串URLdecode解码
- (NSString *)urlDecoding
{
    NSString* result = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

//获取url里面的参数
-(NSDictionary *)getURLParams
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSRange range1 = [self rangeOfString:@"?"];
    NSRange range2 = [self rangeOfString:@"#"];
    NSRange range;
    if (range1.location != NSNotFound) {
        range = NSMakeRange(range1.location, range1.length);
    }else if (range2.location != NSNotFound){
        range = NSMakeRange(range2.location, range2.length);
    }else{
        range = NSMakeRange(-1, 1);
    }
    
    if (range.location != NSNotFound) {
        NSString *paramString = [self substringFromIndex:range.location + 1];
        NSArray *paramCouples = [paramString componentsSeparatedByString:@"&"];
        for (NSInteger i = 0; i < [paramCouples count]; i ++) {
            NSArray *param = [[paramCouples objectAtIndex:i]componentsSeparatedByString:@"="];
            if ([param count] == 2) {
                [dic setObject:[[param objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[[param objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        return dic;
    }
    return nil;
}

@end
