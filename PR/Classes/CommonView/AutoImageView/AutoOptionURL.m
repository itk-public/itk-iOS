//
//  AutoOptionUR.m
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "AutoOptionURL.h"
#import "AFNetworkReachabilityManager.h"
#ifdef ISDebugOptionValid
#import "DebugConfigManager.h"
#endif

@interface AutoOptionURL()
{
    NSURL *  urlUponWifi;
    NSURL *  urlUponWWAN;
}
@end

#define kWEBPAppendString @"imageView2/0/format/webp"
#define KWEBPWidthAppendString @"/format/webp/interlace/1"
#define kThumbNailString  @"imageMogr2/thumbnail/"

@implementation AutoOptionURL
@synthesize urlUponWifi = urlUponWifi;
@synthesize urlUponWWAN = urlUponWWAN;

+ (AutoOptionURL *)optionURLWithImageURL:(NSString *)imgURL
{
    if (nil == imgURL) {
        return nil;
    }
    NSURLComponents * component = [[NSURLComponents alloc] initWithString:imgURL];
    
    if ([component.query rangeOfString:kWEBPAppendString].length > 0 ||
        [component.query rangeOfString:KWEBPWidthAppendString].length > 0 ||
        [component.query rangeOfString:kThumbNailString].length > 0) {
        component.query = nil;
        NSURL * highQulityURL = [component URL];
        return [self optionUrlInWifi:[highQulityURL absoluteString] andInWWAN:imgURL];
    }else{
        return [self optionUrlInWifi:nil andInWWAN:imgURL];
    }
    
    //    NSString * queryInURL = [[NSURL URLWithString:imgURL] query];
    //    if ([queryInURL rangeOfString:kWEBPAppendString].length > 0 ||
    //        [queryInURL isEqualToString:KWEBPWidthAppendString] ||
    //        [queryInURL isEqualToString:kThumbNailString]) {
    //
    //        NSString * adjustURLStr = [imgURL stringByReplacingOccurrencesOfString:kWEBPAppendString withString:@""];
    //        adjustURLStr = [adjustURLStr stringByReplacingOccurrencesOfString:KWEBPWidthAppendString withString:@""];
    //        adjustURLStr = [adjustURLStr stringByReplacingOccurrencesOfString:kThumbNailString withString:@""];
    //
    //        NSURL * highQualityURL = [NSURL URLWithString:adjustURLStr];
    //        return [self optionUrlInWifi:[highQualityURL absoluteString] andInWWAN:imgURL];
    //    }else{
    //        return [self optionUrlInWifi:nil andInWWAN:imgURL];
    //    }
    return nil;
}


+ (AutoOptionURL *)optionUrlInWifi:(NSString *)urlWifiStr andInWWAN:(NSString *)urlWWANStr
{
    AutoOptionURL * aOptionURL = [[AutoOptionURL alloc] init];
    
    if ([urlWifiStr length] > 0) {
        aOptionURL->urlUponWifi = [NSURL URLWithString:urlWifiStr];
    }
    if ([urlWWANStr length] > 0){
        aOptionURL->urlUponWWAN = [NSURL URLWithString:urlWWANStr];
    }
    return aOptionURL;
}

- (id)init
{
    if (self = [super init])
    {
        self.aop = AOP_NetworkEnvir;
    }
    return self;
}

/**
 *  根据当前网络环境自定选择一个URL
 *
 *  @return 返回选择后的 URL
 */
- (NSURL *)autoSelectURLWithEnvir
{
    if (self.urlUponWifi && self.urlUponWWAN == nil)
    {
        return self.urlUponWifi;
    }
    
    if (self.urlUponWifi == nil && self.urlUponWWAN)
    {
        return self.urlUponWWAN;
    }
    
    if (AFNetworkReachabilityStatusReachableViaWiFi == [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus])
    {
        // 当前是wifi网络环境
        // 防止 urlUponWifi 为空，但是 urlUponWWAN 不为空得情况
        return (self.urlUponWifi ? self.urlUponWifi : self.urlUponWWAN);
    }else if (AFNetworkReachabilityStatusReachableViaWWAN == [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus])
    {
        // 当前是移动网络环境
        // 防止 urlUponWWAN 为空，但是 urlUponWifi 不为空得情况
        return (self.urlUponWWAN ? self.urlUponWWAN : self.urlUponWifi);
    }
    
    // 无网络下，随便选择一个。
    return self.urlUponWifi;
}

- (NSURL *)autoSelectedURL
{
    if (self.aop == AOP_NetworkEnvir){
        return [self autoSelectURLWithEnvir];
    }else if(self.aop == AOP_LowFlow){
        return (self.urlUponWWAN ? self.urlUponWWAN : self.urlUponWifi);
    }else if(self.aop == AOP_HightExperience){
        return (self.urlUponWifi ? self.urlUponWifi : self.urlUponWWAN);
    }
    return nil;
}


- (BOOL)isEqual:(id)object
{
    if(NO == [object isKindOfClass:[AutoOptionURL class]]){
        return NO;
    }
    
    if (self == object) {
        return YES;
    }
    
    if (self.aop != [(AutoOptionURL *)object aop]) {
        return NO;
    }
    
    if (self.urlUponWifi) {
        if ([self.urlUponWifi isEqual:((AutoOptionURL *)object)->urlUponWifi] == NO) {
            return NO;
        }
    }
    
    if (self.urlUponWWAN) {
        if ([self.urlUponWWAN isEqual:((AutoOptionURL *)object)->urlUponWWAN] == NO) {
            return NO;
        }
    }
    
    return YES;
}

@end
