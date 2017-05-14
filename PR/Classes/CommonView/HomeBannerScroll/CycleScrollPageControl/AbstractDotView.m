//
//  AbstractDotView .m
//  YHClouds
//
//  Created by YH on 15/12/7.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "AbstractDotView.h"


@implementation AbstractDotView


- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}


- (void)changeActivityState:(BOOL)active
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}

@end
