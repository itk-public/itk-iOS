//
//  IGErrorHandler.h
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError(ErrorHandler)
- (BOOL)isErrorDisposed;

- (void)maskErrorDisposed;
@end

@interface IGErrorHandler : NSObject
- (void)defaultErrorHandle:(NSError *)error;
@end
