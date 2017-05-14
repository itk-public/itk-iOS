//
//  NSString+Category.h
//  PR
//
//  Created by 黄小雪 on 12/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

/**
 *  判断是否是正确的手机号
 *
*/
+(BOOL)isValidatePhoneNum:(NSString *)phoneNum;

/**
 *  判断是否是空字符串
*/
+(BOOL)isBlankString:(NSString *)string;

/**
 *  去字符串中的前后空格
 */
-(NSString *)trimmingSpaceOfString;

/**
 *  对字符串添加url参数
 */
-(NSString *)stringByAddingURLParams:(NSDictionary *)param;

// 对字符串URLencode编码
- (NSString *)urlEncoding;

// 对字符串URLdecode解码
- (NSString *)urlDecoding;

//获取url里面的参数
- (NSDictionary *)getURLParams;

@end
