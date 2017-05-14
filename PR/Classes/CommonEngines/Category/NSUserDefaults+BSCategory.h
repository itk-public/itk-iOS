//
//  NSUserDefaults+BSCategory.h
//  PR
//
//  Created by 黄小雪 on 17/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (BSCategory)
- (id)bsSafeObjectForKey:(NSString *)aKey;
- (id)bsSafeObjectForKey:(NSString*)aKey hintClass:(Class)cls;
@end
