//
//  NSObject+MSignal.m
//  PR
//
//  Created by 黄小雪 on 24/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "NSObject+MSignal.h"
#import "MSStrongResponder.h"
#import "MSignalBus.h"

@implementation NSObject (MSignal)
-(void)registerHandler:(id<MSignalInterface>)handler signal:(MSignalType)signalName
{
    [self registerHandler:handler signal:signalName];
}

-(void)triggerSignal:(MSignalType)signal withObj:(id)param
{
    MSignal *theSignal = [MSignal signalWithSource:self type:signal param:param];
    [[MSignalBus sharedInstance] send:theSignal];
}
@end
