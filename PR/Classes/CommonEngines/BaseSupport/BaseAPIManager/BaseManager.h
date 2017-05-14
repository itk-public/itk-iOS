//
//  BaseManager.h
//  PR
//
//  Created by 黄小雪 on 20/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ManagerDelegate <NSObject>
@required
- (void)requestSuccess:(id)modelData isCache:(BOOL)isCache;
- (void)requestFailed:(NSError *)error;
@end

@interface BaseManager : NSObject
@property (weak,nonatomic) id<ManagerDelegate> delegate;
@end
