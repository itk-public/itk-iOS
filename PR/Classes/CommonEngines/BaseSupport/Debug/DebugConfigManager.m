//
//  DebugConfigManager.m
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifdef ISDebugOptionValid
#import <UIKit/UIKit.h>
#import "DebugConfigManager.h"
#import "DebugManager.h"
#import "FileManager.h"
#import "DebugItem.h"
#import "Utilities.h"
#import "ErrorProtectCateGory.h"

@interface DebugConfigManager()
{
    NSMutableDictionary *	dgConfig;
    NSMutableArray      *   dgItems;
}
@end

#define kDebugConfigVersion	@"2.0"
#define kDebugVersionKey	@"dVersion"

@implementation DebugConfigManager

#pragma mark -
#pragma mark interface

+ (BOOL)isDebugOpen
{
    DebugManager * loadingDebug = [DebugManager sharedDebugMananger];
    return [loadingDebug isAllDebugOpen];
}

+ (id)sharedDebugConfigManager
{
    static DebugConfigManager * configer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configer = [DebugConfigManager new];
    });
    return configer;
}

+ (NSString *)valueForDid:(NSString *)did
{
    return [[[DebugConfigManager sharedDebugConfigManager] itemForDId:did] value];
}

- (NSString *)debugConfigPath
{
    return [[FileManager shareManager] filePath:@"debugCfg.plist" inPart:FMPart_GeneralConfig forType:FM_APPFileByPreseist];
}

- (void)loadConfigFromFile
{
    dgConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:[self debugConfigPath]];
    NSString * theValue = [dgConfig valueForKey:kDebugVersionKey];
    if ([theValue isEqualToString:kDebugConfigVersion] == NO){
        dgConfig = nil;
    }
    
    if (nil == dgConfig){
        dgConfig = [[NSMutableDictionary alloc] initWithObjectsAndKeys:kDebugConfigVersion,kDebugVersionKey,nil];
    }
}

- (void)restore
{
    [dgConfig removeAllObjects];
    [dgConfig safeSetObject:kDebugConfigVersion forKey:kDebugVersionKey];
    for (DebugItem * aItem in [self allDebugConfigItems]) {
        if (aItem.value) {
            [dgConfig safeSetObject:aItem.value forKey:aItem.dId];
        }
    }
    [dgConfig writeToFile:[self debugConfigPath] atomically:YES];
}

- (instancetype)init
{
    if (self = [super init]) {
        dgItems = [NSMutableArray array];
        [self loadConfigFromFile];
        [self addMasterSwitch];
    }
    return self;
}

- (void)addMasterSwitch
{
    DebugItem * allControl = [DebugItem itb:@"测试开关" id:DebugOption_AllControl a:nil];
#ifdef kAutoToTestInEnvir
    [allControl changeDebugValue:@"1"];
#endif
    [self registerDebugItem:allControl];
}

- (NSArray *)allDebugConfigItems
{
    return dgItems;
}

- (void)resetRegisterItems
{
    [dgItems removeAllObjects];
    [self addMasterSwitch];
}

- (void)registerDebugItem:(DebugItem *)item
{
    CONDITION_CHECK_RETURN([dgItems containsObject:item] == NO);
    
    [dgItems addObject:item];
    if ([dgConfig valueForKey:item.dId] != nil) {
        [item changeDebugValue:[dgConfig valueForKey:item.dId]];
    }
}

- (DebugItem *)itemForDId:(NSString *)did
{
    for (DebugItem * item in dgItems) {
        if ([did isEqualToString:item.dId]) {
            return item;
        }
    }
    return nil;
}
#pragma mark - private mothods
+ (void)loadDefaultDebugStatus
{
    DebugManager * loadingDebug = [DebugManager sharedDebugMananger];
    [loadingDebug  loadAllDebugOperation];
}

+ (void)displayScrollViewChain:(UIScrollView *)scrollView
{
    NSMutableArray * desChain = [NSMutableArray array];
    
    [desChain addObject:[scrollView description]];
    
    UIView * theView = scrollView;
    while (1)
    {
        if (NO == [[theView superview] isKindOfClass:[UIWindow class]])
        {
            theView = [theView superview];
            [desChain insertObject:[theView description] atIndex:0];
        }else{
            break;
        }
    }
    
    NSString * theChain = [desChain componentsJoinedByString:@"\r\n"];
    NSLog(@"------------------------------------------------");
    NSLog(@"The Scroll View is able to scrolls to top : %@",theChain);
}

+ (void)checkScrollToTopView:(UIView *)theView
{
    for (UIView * aSubView in [theView subviews]) {
        if ([aSubView isKindOfClass:[UIScrollView class]])
        {
            if ([(UIScrollView *)aSubView scrollsToTop] == YES)
            {
                [self displayScrollViewChain:(UIScrollView *)aSubView];
            }
        }
        
        [self checkScrollToTopView:aSubView];
    }
}

+ (void)testScrollToTopDisable
{
    UIWindow * ourWindow = [[UIApplication sharedApplication] keyWindow];
    [self checkScrollToTopView:ourWindow];
}
@end
#endif
