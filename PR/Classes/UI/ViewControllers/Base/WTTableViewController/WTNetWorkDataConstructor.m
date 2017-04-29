//
//  WTNetWorkDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 18/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "WTNetWorkDataConstructor.h"

@implementation WTNetWorkDataConstructor
#pragma mark - generate data
-(void)constructData{
    
}

#pragma mark --setter/getter
-(NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

#pragma mark - methods
- (void)loadData
{
    
}

- (void)loadMoreData
{
    
}

#pragma mark - dealloc
- (void)dealloc
{
    _delegate = nil;
}

@end
