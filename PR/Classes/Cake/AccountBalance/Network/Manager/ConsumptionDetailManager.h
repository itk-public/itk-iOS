//
//  ConsumptionDetailManager.h
//  PR
//
//  Created by 黄小雪 on 2017/9/13.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ConsumptionDetailManager;
@protocol ConsumptionDetailManagerDelegate <NSObject>
@required
-(void)loadDataSuccessful:(ConsumptionDetailManager *)manager  data:(id)data  isCache:(BOOL)isCache;

-(void)loadDataFailed:(ConsumptionDetailManager *)manager error:(NSError*)error;
@end

@interface ConsumptionDetailManager : NSObject
@property (weak,nonatomic) id<ConsumptionDetailManagerDelegate> delegate;
-(void)consumptionDetail;
@end

