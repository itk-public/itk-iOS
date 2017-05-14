//
//  InternalSchemeHandler.m
//  PR
//
//  Created by 黄小雪 on 13/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "InternalSchemeHandler.h"
#import "NHProcessorFactory.h"
#import "NHProcessorBase.h"
#import "ServiceCenter.h"
#import "PRMBWantedOffice.h"

#import "NSString+Category.h"

@interface InternalSchemeHandler()
{
    NHProcessorFactory * m_nhProcessorMger; // processor 的管理中心
}
@property (nonatomic,readwrite,retain) NSMutableDictionary *callback;
@end

@implementation InternalSchemeHandler
IMP_SINGLETON

- (instancetype)init
{
    if (self = [super init])
    {
        m_nhProcessorMger = [[NHProcessorFactory alloc] init];
    }
    
    return self;
}

+ (id)defaultHandler
{
    return [[ self alloc]init];
}

+(BOOL)isInternalScheme:(NSString *)urlStr
{
    if ([NSURL URLWithString:urlStr] == nil) {
        return NO;
    }
    
    if (urlStr.length && [(NSString*)[[NSURL URLWithString:urlStr] scheme] rangeOfString:SCHEME_MYYH].length != 0) {
        return YES;
    }
    
    return NO;
}

- (NSString *)applySignalID
{
    static long ntBaseID = 0;
    
    return [NSString stringWithFormat:@"ISNT_id_%ld",ntBaseID++];
    
}

// H: handle
// U: URL
#define kHUURLKey		@"url"
#define kHUNotifyIDKey		@"nid"

- (void)handleURL:(NSString*)urlStr
{
    if (urlStr.length > 0)
    {
        [self handleURLWithParam:@{kHUURLKey:urlStr}];
    }
}


- (void)handleUrl:(NSString *)urlStr withSignalName:(NSString *)singalName;
{
    if(singalName.length == 0)
    {
        [self handleURL:urlStr];
    }
    else if (urlStr.length > 0)
    {
        [self handleURLWithParam:@{kHUURLKey:urlStr,
                                   kHUNotifyIDKey:singalName}];
    }
}

- (void)handleURLWithParam:(NSDictionary *)parmas
{
    NSString * urlStr = [parmas safeObjectForKey:kHUURLKey hintClass:[NSString class]];
    NSString * ntID  = [parmas safeObjectForKey:kHUNotifyIDKey];
    
    // 获取其他命令的processor
    id handleProcessor =  [m_nhProcessorMger generateProcessorFor:urlStr];
    if (handleProcessor)
    {
        if ([handleProcessor isKindOfClass:[NHProcessorBase class]])
        {
            NHProcessorBase * innerProcessor = (NHProcessorBase *)handleProcessor;
            innerProcessor.finishNotifyID = ntID;
            [innerProcessor disposeCommand];
        }
    }
    
}

@end
