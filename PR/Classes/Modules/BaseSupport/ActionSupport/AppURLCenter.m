//
//  AppURLCenter.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "AppURLCenter.h"
#import "InternalSchemeHandler.h"
#import "SceneMananger.h"
//#ifdef ISDebugOptionValid
//#import "DebugConfigEntry.h"
//#endif

@interface AppURLCenter()
@property (strong,nonatomic) UIWebView *phoneCallWebView;
@end

@implementation AppURLCenter

+ (BOOL)isWebURL:(NSURL*)URL
{
    return [URL.scheme caseInsensitiveCompare:@"http"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"https"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"ftp"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"ftps"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"data"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"file"] == NSOrderedSame;
}

+ (BOOL)openURL:(NSURL *)originURL
{
    if ([InternalSchemeHandler isInternalScheme:[originURL absoluteString]])
    {
        [[InternalSchemeHandler defaultHandler] handleURL:[originURL absoluteString]];
        return YES;
    }
    
    return [[UIApplication sharedApplication] openURL:originURL];
}

+ (BOOL)handleURL:(NSURL *)loadedURL
{
    if ([InternalSchemeHandler isInternalScheme:[loadedURL absoluteString]])
    {
        if ([[SceneMananger shareMananger] rootVCVaild] == NO) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [AppURLCenter handleURL:loadedURL];
            });
            return YES;
        }
        
        [[InternalSchemeHandler defaultHandler] handleURL:[loadedURL absoluteString]];
        return YES;
    }
    
//#ifdef ISDebugOptionValid
//    if([DebugConfigEntry isDebugConfigFilePath:loadedURL])
//    {
//        [DebugConfigEntry disposeInputEnvFile:loadedURL];
//        return YES;
//    }
//#endif
    return NO;
}


@end
