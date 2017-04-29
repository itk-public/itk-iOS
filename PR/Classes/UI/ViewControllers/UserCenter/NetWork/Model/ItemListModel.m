//
//  ItemListModel.m
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ItemListModel.h"

@implementation ItemListModel

+ (instancetype)modelFromDictionary:(NSDictionary *)dic
{
    return [[self alloc]initWithDictionary:dic];
}


- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    CONDITION_CHECK_RETURN_VAULE([dic isKindOfClass:[NSDictionary class]], nil);
    if (self = [super initWithDictionary:dic]) {
        _type     = [[dic safeObjectForKey:@"type" hintClass:[NSNumber class]]integerValue];
        _iconName = [dic safeObjectForKey:@"icon" hintClass:[NSString class]];
        _title    = [dic safeObjectForKey:@"title" hintClass:[NSString class]];
        _action   = [dic safeObjectForKey:@"action" hintClass:[NSString class]];
    }
    return self;
}
@end
