//
//  CartManager.h
//  PR
//
//  Created by 黄小雪 on 15/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CartManagerDelegate <NSObject>
@required
- (void)requestSuccess:(id)modelData isCache:(BOOL)isCache;
- (void)requestFailed:(id)error;
@end


@interface CartManager : NSObject
-(BOOL)refreshCart;
@property (weak,nonatomic) id<CartManagerDelegate> delegate;
@end
