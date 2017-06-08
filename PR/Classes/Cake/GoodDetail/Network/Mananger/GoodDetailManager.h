//
//  GoodDetailManager.h
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodDetailManager;

@protocol GoodDetailManagerDelegate <NSObject>
@required
-(void)loadDataSuccessful:(GoodDetailManager *)mananger  data:(id)data;

-(void)loadDataFailed:(GoodDetailManager *)cartShopApi  error:(NSError*)error;
@end

@interface GoodDetailManager : NSObject
@property (weak,nonatomic) id<GoodDetailManagerDelegate> delegate;
-(void)getGoodDetailWithId:(NSString *)goodId;
@end
