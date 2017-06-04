//
//  PickSelfSiteModel.m
//  PR
//
//  Created by 黄小雪 on 2017/5/30.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "PickSelfSiteModel.h"

@implementation PickSelfSiteModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _pickSelfSiteName = [dic safeObjectForKey:@"siteTitle"];
        _pickSelfSiteAddress = [dic safeObjectForKey:@"siteAddress"];
        _cid = [dic safeObjectForKey:@"id"];
    }
    return self;
}
@end
