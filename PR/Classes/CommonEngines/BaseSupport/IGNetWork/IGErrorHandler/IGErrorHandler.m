//
//  IGErrorHandler.m
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "IGErrorHandler.h"
#import <objc/runtime.h>

char * ErrorDisposedKey = "errorDisposedKey";

@implementation NSError(ErrorHandler)
- (BOOL)isErrorDisposed
{
    id disposedMarkObj =   objc_getAssociatedObject(self, ErrorDisposedKey);
    if (disposedMarkObj != nil) {
        return YES;
    }
    return NO;
}

- (void)maskErrorDisposed
{
    id disposedMarkObj =   objc_getAssociatedObject(self, ErrorDisposedKey);
    if (nil == disposedMarkObj) {
        objc_setAssociatedObject(self, ErrorDisposedKey, [NSNull null], OBJC_ASSOCIATION_ASSIGN);
    }
}

@end

@implementation IGErrorHandler
- (void)defaultErrorHandle:(NSError *)error
{
    // do nothings
}
@end
