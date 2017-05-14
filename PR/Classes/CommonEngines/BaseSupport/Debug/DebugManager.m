//
//  DebugManager.m
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifdef ISDebugOptionValid
#import "DebugManager.h"
#import "DebugItem.h"
#import "DebugConfigManager.h"


@implementation DebugManager
@synthesize allDebugOptions;

+ (id)sharedDebugMananger
{
#if defined(ISDebugOptionValid) || defined(kAutoToTestInEnvir)
    static DebugManager * __theManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __theManager = [[DebugManager alloc] init];
    });
    return __theManager;
#else
    return nil;
#endif
}


- (id)init
{
    if (self = [super init]){
        self.allDebugOptions = [[DebugConfigManager sharedDebugConfigManager] allDebugConfigItems];
    }
    return self;
}


- (void)loadAllDebugOperation
{
    for (DebugItem * operation in self.allDebugOptions)
    {
        [self doDebugOptionChange:operation.value forDID:operation.dId];
    }
}

#pragma mark chanage debug operation

- (void)doDebugOptionChange:(NSString *)theNewValue forDID:(NSString *)optionID
{
    if ([optionID isEqualToString:DebugOption_AllControl]) {
        if ([theNewValue isEqualToString:@"1"]) {
            _isAllDebugOpen = YES;
        }else{
            _isAllDebugOpen = NO;
        }
    }
    
}

- (DebugItem *)itemForDID:(NSString *)optionID
{
    for (DebugItem * operation in self.allDebugOptions)
    {
        if ([operation.dId isEqualToString:optionID])
        {
            return operation;
        }
    }
    return nil;
}

#pragma mark - interface
- (BOOL)isValidForDID:(NSString *)optionID
{
    if (optionID == nil){
        return NO;
    }
    
    return [[self itemForDID:optionID] isValid];
}

- (void)changeStaus:(NSString *)theNewValue forDID:(NSString *)optionID
{
    if (optionID == nil){
        return;
    }
    
    [self doDebugOptionChange:theNewValue forDID:optionID];
    
    DebugItem * theItem = [self itemForDID:optionID];
    if([theItem changeDebugValue:theNewValue]){
        [[DebugConfigManager sharedDebugConfigManager] restore];
    }
}
@end
#endif
