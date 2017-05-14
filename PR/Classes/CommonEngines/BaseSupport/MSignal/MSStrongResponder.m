//
//  MSStrongResponder.m
//  PR
//
//  Created by 黄小雪 on 25/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "MSStrongResponder.h"

@implementation MSStrongResponder

-(instancetype)initWithHandler:(id<MSignalInterface>)handler
{
    if (self = [super init]) {
        self.signalHandler = handler;
    }
    return self;
}

-(BOOL)addHandler:(id<MSignalInterface>)handler forSignal:(MSignalType)signalType
{
    CONDITION_CHECK_RETURN_VAULE(handler == self.signalHandler, NO);
    if (nil == self.signalSet) {
        _signalSet = [NSMutableSet set];
    }
    
    __block BOOL isSingleRegisted = [self queryExistSignleObserve:signalType];
    if(isSingleRegisted == NO){
        [_signalSet addObject:signalType];
    }
    return YES;
}

-(BOOL)queryExistSignleObserve:(MSignalType)signalType
{
    __block BOOL isObserved = NO;
    [_signalSet enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        MSignalType existType = (MSignalType)obj;
        if (existType ==  signalType) {
            isObserved = YES;
            *stop            = YES;
        }
    }];
    return isObserved;
}
@end

@implementation NSObject(MSignalStrongResponder)

static char *queryObjKey = "queryObjKey";

-(MSStrongResponder *)querySignalStrongHandler
{
    return objc_getAssociatedObject(self, queryObjKey);
}

-(void)setStrongSignalHandler:(MSStrongResponder *)handler
{
    objc_setAssociatedObject(self, queryObjKey, handler, OBJC_ASSOCIATION_RETAIN);
}

-(void)registerStrongHandler:(id<MSignalInterface>)handler signal:(MSignalType)signalName
{
    MSStrongResponder *signalObj = [self querySignalStrongHandler];
    if ( nil == signalObj) {
        signalObj = [[MSStrongResponder alloc]initWithHandler:handler];
        [self setStrongSignalHandler:signalObj];
    }
    [signalObj addHandler:handler forSignal:signalName];
}
@end
