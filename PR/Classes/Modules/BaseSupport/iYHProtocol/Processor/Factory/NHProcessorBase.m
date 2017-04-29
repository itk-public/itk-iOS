//
//  NHProcessorBase.m
//  PR
//
//  Created by 黄小雪 on 13/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "NHProcessorBase.h"
#import "InternalSchemeHandlerDefine.h"

@implementation NHProcessorBase
@synthesize cmdURL;

+(BOOL)matchCMDPath:(NSString *)path inCMDURL:(NSString *)url
{
    return NO;
}

+(BOOL)isSingleton
{
    return YES;
}

-(instancetype)initWithHandleCMD:(NSString *)theCMDURL
{
    if (self =[super init]) {
        cmdURL = theCMDURL;
    }
    return self;
}

-(void)disposeCommand
{
    assert(false);
}

- (void)notifyCMDResult:(NSDictionary *)theResultInfo
{
    if ([self.finishNotifyID length] > 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:self.finishNotifyID object:nil userInfo:theResultInfo];
    }
}

- (void)notifyJSONResult:(NSString *)jsstr
{
    if (jsstr.length > 0) {
        [self notifyCMDResult:@{CALL_BACK_JS_KEY:jsstr}];
    }
}
@end
