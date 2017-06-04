//
//  SelectAddressDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SelectAddressDataConstructor.h"
#import "SelectAddressCell.h"
#import "AddressManager.h"
#import "AddressListModel.h"
#import "SelectAddressHeaderCell.h"

@interface SelectAddressDataConstructor()<AddressManagerDelegate>
@property (strong,nonatomic) AddressManager *manager;
@property (strong,nonatomic) AddressListModel *addressList;

@end

@implementation SelectAddressDataConstructor


-(void)loadData
{
    PRLOG(@"选择收货地址请求");
     [self.manager addressList];
}

-(void)constructData
{
    if ([self.addressList.addressList count]) {
        [self.items removeAllObjects];
        AddressHeaderCellModel *headerModel = [[AddressHeaderCellModel alloc]init];
        headerModel.identifier                = @"SelectAddressHeaderCell";
        headerModel.cellClass               = [SelectAddressHeaderCell class];
        [self.items addObject:headerModel];
        
        for (AddressModel *address in self.addressList.addressList) {
            if ([address isKindOfClass:[AddressModel class]]) {
                address.identifier = @"SelectAddressCell";
                address.cellClass = [SelectAddressCell class];
                [self.items addObject:address];
            }
        }
    }
}

#pragma mark --getter ---
-(AddressManager *)manager
{
    if (!_manager) {
        _manager = [[AddressManager alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}

#pragma mark AddressManagerDelegate
-(void)loadDataSuccessful:(AddressManager *)cartShopApi dataType:(AddressManagerType)dataType  data:(id)data  isCache:(BOOL)isCache
{
    self.addressList = data;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
        [self.delegate dataConstructor:self didFinishLoad:data];
    }
}

-(void)loadDataFailed:(AddressManager *)cartShopApi dataType:(AddressManagerType)dataType error:(NSError*)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}
@end
