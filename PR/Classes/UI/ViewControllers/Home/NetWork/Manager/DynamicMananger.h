//
//  DynamicMananger.h
//  PR
//
//  Created by 黄小雪 on 12/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DynamicUIModel;

@protocol DynamicManangerDelegate <NSObject>
@required
- (void)requestDynamicUIModelSuccess:(DynamicUIModel *)modelData isCache:(BOOL)isCache;
- (void)requestDynamicUIModelFailed:(id)error;
@end

@interface DynamicMananger : NSObject
@property (weak,nonatomic) id<DynamicManangerDelegate> delegate;

//平台首页
- (void)requestDynamicUIModel:(BOOL)needCache;
@end
