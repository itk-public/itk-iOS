//
//  MSignalBus.h
//  PR
//
//  Created by 黄小雪 on 25/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MSignal.h"

@interface MSignalBus : NSObject
DEF_SINGLETON(MSignalBus)

-(void)send:(MSignal *)signal;

@end
