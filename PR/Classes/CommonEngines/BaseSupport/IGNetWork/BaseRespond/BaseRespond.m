//
//  BaseRespond.m
//  PR
//
//  Created by 黄小雪 on 23/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "BaseRespond.h"
#import "Utilities.h"

@interface BaseRespond()

@property(nonatomic,readwrite)HttpResponseStatusCode    httpCode;
@property(nonatomic,readwrite)IGRespondStatus           status;
@property(nonatomic,strong)NSString *                   promptInfo;
@property(nonatomic,strong)NSError *                    error;
@property(nonatomic,readwrite)NSTimeInterval             timeStamp;
@property(nonatomic,weak)id<IGParserInterface>          parser;

@end
@implementation BaseRespond

+ (instancetype)objWithRespondJson:(id)jsonData
                           taskTag:(NSInteger)tag
                       modelParser:(id<IGParserInterface>)parser
                    isOutsideVisit:(BOOL)outside
{
    CONDITION_CHECK_RETURN_VAULE([jsonData isKindOfClass:[NSDictionary class]], nil);
    return [[BaseRespond alloc]initWithResponseDictionary:jsonData
                                                  taskTag:tag
                                              modelParser:parser
                                           isOutsideVisit:outside];
}


+ (instancetype)objWithError:(NSError *)errorInfo
                 respondInfo:(id)respondInfo
{
    BaseRespond *resp = [[BaseRespond alloc]init];
    [resp doParserError:errorInfo respondData:respondInfo];
    return resp;
}


- (id)initWithResponseDictionary:(NSDictionary *)dic
                         taskTag:(NSInteger)tag
                     modelParser:(id<IGParserInterface>)parser isOutsideVisit:(BOOL)outside
{
    if (self = [super init]) {
        _taskTag = tag;
        _parser = parser;
        _outsideRsp = outside;
        [self doRespondParser:dic parser:parser];
    }
    return self;
}

-(void)setHttpCode:(HttpResponseStatusCode)httpCode
{
    _httpCode = httpCode;
}
- (void)doRespondParser:(NSDictionary *)dic parser:(id<IGParserInterface>)parser
{
    NSNumber *respondedStatus = [dic safeObjectForKey:@"code" hintClass:[NSNumber class]];
    self.status = [respondedStatus integerValue];
    self.promptInfo = [dic safeObjectForKey:@"message" hintClass:[NSString class]];
    NSError *tError = nil;
    if (self.status != noErr && self.promptInfo) {
        tError = [NSError errorWithDomain:[self.promptInfo length]?self.promptInfo:@""
                                     code:self.status
                                 userInfo:nil];
    }
    [self doParserError:tError respondData:dic];
    self.timeStamp = ((long long)([[dic safeObjectForKey:@"now" hintClass:[NSNumber class]] longLongValue]) / 1000);
    
    NSDictionary *theInfo = [dic safeObjectForKey:@"data" hintClass:[NSDictionary class]];
    if (theInfo) {
        if ([self.parser respondsToSelector:@selector(parserSourceData:forRespondObj:)]) {
            _parsedModel = [self.parser parserSourceData:theInfo forRespondObj:self];
        }else{
            _parsedModel = theInfo;
        }
    }
}

- (void)doParserError:(NSError *)error respondData:(id)respondData
{
    NSError *theIGError = nil;
    if ([respondData isKindOfClass:[NSDictionary class]]) {
        NSDictionary *userInfo = nil;
        self.promptInfo = [(NSDictionary *)respondData safeObjectForKey:@"message" hintClass:[NSString class]];
        if (self.promptInfo) {
            userInfo = @{NSLocalizedDescriptionKey:self.promptInfo?:@""};
        }
        NSNumber *respondedStatus =[(NSDictionary *)respondData  safeObjectForKey:@"code" hintClass:[NSNumber class]];
        if (respondedStatus == nil) {
            theIGError = [NSError errorWithDomain:@"Wrong respod"
                                             code:IGInnerErrorCodeNoValidRespond
                                         userInfo:userInfo];
        }else{
            self.status = [respondedStatus integerValue];
            theIGError = [NSError errorWithDomain:@"Service error" code:self.status userInfo:userInfo];
        }
    }
    if (nil == theIGError) {
        theIGError = error;
    }
    self.error = theIGError;
}
@end
