//
//  IGDataOperator.m
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "IGDataOperator.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>

#define CHUNK_SIZE 1024*8

@implementation IGDataOperator

+(NSString *)rawSignTxt:(NSString *)content{
    NSString *result = nil;
    if (content.length > 0) {
        result = [GTMBase64 stringByEncodingData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return result;
}

+ (NSString *)md5:(NSString *)content
{
    const char *cStr = [content UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    NSString *md5Str= [NSString stringWithFormat:
                       @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                       result[0], result[1], result[2], result[3],
                       result[4], result[5], result[6], result[7],
                       result[8], result[9], result[10], result[11],
                       result[12], result[13], result[14], result[15]
                       ];
    return [md5Str  lowercaseString];
}

+ (NSString*)getFileMD5:(NSString*)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil )
        return nil;
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: CHUNK_SIZE ];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}

+ (NSString *)getMD5WithData:(NSData*)data
{
    /*
     const char * original_str = (const char*)[data bytes];
     unsigned char digist[CC_MD5_DIGEST_LENGTH];
     CC_MD5(original_str, (CC_LONG)strlen(original_str), digist);
     NSMutableString * outPutStr = [NSMutableString stringWithCapacity:10];
     for(int  i=0; i<CC_MD5_DIGEST_LENGTH; i++){
     [outPutStr appendFormat:@"%02x",digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
     }
     */
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    CC_MD5_Update(&md5, [data bytes], (CC_LONG)[data length]);
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}

@end
