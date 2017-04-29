//
//  MSStrongResponder.h
//  PR
//
//  Created by 黄小雪 on 25/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MSignal.h"

@interface MSStrongResponder : NSObject
{
    NSMutableSet *_signalSet;
}

@property (weak,nonatomic) id<MSignalInterface> signalHandler;
@property (readonly,nonatomic) NSSet *signalSet;

-(BOOL)queryExistSignleObserve:(MSignalType)signalType;
@end

@interface NSObject(MSignalStrongResponder)

-(MSStrongResponder *)querySignalStrongHandler;
-(void)setStrongSignalHandler:(MSStrongResponder *)handler;
-(void)registerStrongHandler:(id<MSignalInterface>)handler signal:(MSignalType)signalName;

@end
