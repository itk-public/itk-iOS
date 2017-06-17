//
//  ShopHomeManager.h
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShopHomeManager;
@protocol ShopHomeManagerDelegate <NSObject>
@required
-(void)loadDataSuccessful:(ShopHomeManager *)manager  data:(id)data  isCache:(BOOL)isCache;

-(void)loadDataFailed:(ShopHomeManager *)manager error:(NSError*)error;
@end

@interface ShopHomeManager : NSObject
@property (weak,nonatomic) id<ShopHomeManagerDelegate> delegate;
-(void)shopHomeInfo;
@end
