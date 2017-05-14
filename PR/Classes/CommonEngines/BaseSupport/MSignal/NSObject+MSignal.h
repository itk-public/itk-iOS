//
//  NSObject+MSignal.h
//  PR
//
//  Created by 黄小雪 on 24/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSignal.h"

@protocol MSignalInterface <NSObject>
@optional
-(void)handleSignal:(MSignal *)signal;
@end

@interface NSObject (MSignal)

-(void)registerHandler:(id<MSignalInterface>)handler signal:(MSignalType)signalName;
-(void)triggerSignal:(MSignalType)signal withObj:(id)param;

@end
