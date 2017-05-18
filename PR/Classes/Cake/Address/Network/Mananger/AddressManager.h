//
//  AddressManager.h
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AddressManager;

typedef NS_ENUM(NSInteger,AddressManagerType)
{
    AddressManagerTypeList = 1,       //地址列表
};

@protocol AddressManagerDelegate <NSObject>
@required
-(void)loadDataSuccessful:(AddressManager *)cartShopApi dataType:(AddressManagerType)dataType  data:(id)data  isCache:(BOOL)isCache;

-(void)loadDataFailed:(AddressManager *)cartShopApi dataType:(AddressManagerType)dataType error:(NSError*)error;
@end

@interface AddressManager : NSObject
@property (weak,nonatomic) id<AddressManagerDelegate> delegate;
//获取地址列表
-(void)addressList;
@end
