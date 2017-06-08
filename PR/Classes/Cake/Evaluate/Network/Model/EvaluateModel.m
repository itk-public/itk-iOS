//
//  EvaluateModel.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "EvaluateModel.h"

@implementation EvaluateModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super initWithDictionary:dic]) {
        _content  = [dic safeObjectForKey:@"content"];
        _nickName = [dic safeObjectForKey:@"nickName"];
        _score    = [[dic safeObjectForKey:@"score"]floatValue];
        _cid      = [dic safeObjectForKey:@"id"];
    }
    return self;
}
@end
