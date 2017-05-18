//
//  AddressListModel.m
//  PR
//
//  Created by 黄小雪 on 2017/5/16.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "AddressListModel.h"

@implementation AddressListModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        NSMutableArray *tempArray = [dic safeObjectForKey:@"list"hintClass:[NSArray class]];
        if (tempArray) {
            NSMutableArray *tempList = [NSMutableArray arrayWithCapacity:[tempArray count]];
            for (NSDictionary *tempDict in tempArray) {
                AddressModel *model = [AddressModel modelFromDictionary:tempDict];
                [tempList safeAddObject:model];
            }
            _addressList = [NSArray arrayWithArray:tempList];
        }
    }
    return self;
}
@end
