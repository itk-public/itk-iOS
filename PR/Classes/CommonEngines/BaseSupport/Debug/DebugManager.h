//
//  DebugManager.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifdef ISDebugOptionValid
#import <Foundation/Foundation.h>
#import "DebugItem.h"
#import "DebugConfigManager.h"

@interface DebugManager : NSObject
@property(nonatomic,readonly) BOOL   isAllDebugOpen;
@property(nonatomic,retain)NSArray * allDebugOptions;

+ (id)sharedDebugMananger;

- (void)loadAllDebugOperation;

- (BOOL)isValidForDID:(NSString *)optionID;
- (void)changeStaus:(NSString *)theNewValue forDID:(NSString *)optionID;
@end
#endif
