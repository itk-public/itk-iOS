//
//  PRMBPageIDCard.m
//  PR
//
//  Created by 黄小雪 on 14/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PRMBPageIDCard.h"

@implementation PRMBPageIDCard

-(NSNumber *)viewConformsToProtocol:(Protocol *)protocol{
    NSNumber *flag = nil;
    if (self.viewClass) {
        flag        = [NSNumber numberWithBool:[self.viewClass conformsToProtocol:protocol]];
    }
    return flag;
}
@end
