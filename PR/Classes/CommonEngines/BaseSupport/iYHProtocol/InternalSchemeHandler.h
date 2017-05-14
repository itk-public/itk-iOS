//
//  InternalSchemeHandler.h
//  PR
//
//  Created by 黄小雪 on 13/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InternalSchemeHandler : NSObject
DEF_SINGLETON(InternalSchemeHandler)

+ (id)defaultHandler;

+ (BOOL)isInternalScheme:(NSString*)urlStr;

- (void)handleURL:(NSString*)urlStr;

- (void)handleUrl:(NSString *)urlStr withSignalName:(NSString *)singalName;

/**
 *  申请一个noficication id，这个id是当期唯一
 *
 *  @return 一个新的nofication name
 */
- (NSString *)applySignalID;


@end
