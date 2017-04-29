//
//  DebugConfigManager.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifdef ISDebugOptionValid
#import <Foundation/Foundation.h>
#import "DebugItem.h"

@interface DebugConfigManager : NSObject

+ (id)sharedDebugConfigManager;
+ (BOOL)isDebugOpen;

- (NSArray *)allDebugConfigItems;

- (DebugItem *)itemForDId:(NSString *)did;
- (void)registerDebugItem:(DebugItem *)item;
- (void)resetRegisterItems;
- (void)restore;

+ (NSString *)valueForDid:(NSString *)did;
@end
#endif

