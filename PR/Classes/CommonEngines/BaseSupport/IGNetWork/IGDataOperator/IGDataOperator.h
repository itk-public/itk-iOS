//
//  IGDataOperator.h
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGDataOperator : NSObject

+ (NSString *)rawSignTxt:(NSString *)content;
+ (NSString *)md5:(NSString *)content;
+ (NSString*)getFileMD5:(NSString*)path;
+ (NSString*)getMD5WithData:(NSData*)data;

@end
