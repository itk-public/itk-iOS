//
//  PRMBWantedOffice.m
//  PR
//
//  Created by 黄小雪 on 12/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PRMBWantedOffice.h"
#import "PRMBEnquiry.h"
#import "InternalSchemeHandlerDefine.h"
#import "InternalSchemeHandler.h"

@implementation PRMBWantedOffice
+ (void)nativeArrestWarrant:(NSString *)pageID param:(NSDictionary *)params
{
    NSString *openNativeURL = [PRMBEnquiry urlForViewWithIdentifier:pageID params:params];
    [[InternalSchemeHandler defaultHandler] handleURL:openNativeURL];
    
}

+ (void)networkArrestWarrant:(NSString *)url param:(NSDictionary *)params;
{
    NSString * openNativeURL = [PRMBEnquiry urlForServiceWithIdentifier:url params:params];
    
    [[InternalSchemeHandler defaultHandler] handleURL:openNativeURL];
}
@end
