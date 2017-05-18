//
//  SecretPhoneLabel.m
//  PR
//
//  Created by 黄小雪 on 2017/5/16.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SecretPhoneLabel.h"

@implementation SecretPhoneLabel

- (void)setText:(NSString *)text
{
    if ([text length] > 4){
        NSMutableString * telInfo = [text mutableCopy];
        [telInfo replaceCharactersInRange:NSMakeRange([telInfo length] - 8, 4) withString:@"****"];
        [super setText:telInfo];
    }
}

@end
