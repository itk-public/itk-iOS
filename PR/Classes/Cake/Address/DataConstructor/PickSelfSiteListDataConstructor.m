//
//  PickSelfSiteListDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 2017/5/30.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "PickSelfSiteListDataConstructor.h"
#import "AddressManager.h"
#import "PickSelfSiteModel.h"
#import "SelectPickSelfSiteCell.h"

@interface PickSelfSiteListDataConstructor()<AddressManagerDelegate>
@property (strong,nonatomic) AddressManager *manager;
@property (strong,nonatomic) NSArray *siteList;
@end

@implementation PickSelfSiteListDataConstructor
-(void)loadData
{
    PRLOG(@"自提点列表请求");
    [self.manager pickSelfSiteList];
}

-(AddressManager *)manager
{
    if (_manager == nil) {
        _manager = [[AddressManager alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}

-(void)constructData
{
    if (self.siteList) {
        [self.items removeAllObjects];
        for (PickSelfSiteModel *model in self.siteList) {
            if ([model isKindOfClass:[PickSelfSiteModel class]]) {
                model.cellIdentifier = @"SelectPickSelfSiteCell";
                model.cellClass  = [SelectPickSelfSiteCell class];
                [self.items addObject:model];
            }
        }
    }
}

#pragma mark AddressManagerDelegate
-(void)loadDataSuccessful:(AddressManager *)manager dataType:(AddressManagerType)dataType  data:(id)data  isCache:(BOOL)isCache
{
    if([data isKindOfClass:[NSArray class]]){
        self.siteList = data;
        if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
            [self.delegate dataConstructor:self didFinishLoad:data];
        }
    }
}

-(void)loadDataFailed:(AddressManager *)manager dataType:(AddressManagerType)dataType error:(NSError*)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}


@end
