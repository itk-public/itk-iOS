//
//  PartDataResponse.m
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "PartDataResponse.h"

@interface PartDataResponse()
@property (weak,nonatomic) id<PartDataResponseItemParser> parser;
@end

@implementation PartDataResponse
-(instancetype)initWithItemParser:(id<PartDataResponseItemParser>)parser
{
    if (self = [super init]) {
        _parser = parser;
    }
    return self;
}

-(void)loadDict:(NSDictionary *)dataDict
{
    _curPage = [[dataDict safeObjectForKey:@"page" hintClass:[NSNumber class]]integerValue];
    _pageSize = [[dataDict safeObjectForKey:@"pageCount" hintClass:[NSNumber class]]integerValue];
    _totalCount = [[dataDict safeObjectForKey:@"count" hintClass:[NSNumber class]]integerValue];
    
    if (self.parser) {
        _items = [self.parser parseItemWithInfo:[dataDict safeObjectForKey:[self.parser itemsParseKey] hintClass:[NSArray class]]];
    }else{
        NSAssert(0, @"构建了一个未设置item解析的 response,无法构建Item model");
    }
#warning ????? _totalCount = -1;
     _totalCount = -1;
}
@end

@implementation PartPageResponse
-(void)loadDict:(NSDictionary *)dataDict
{
    CONDITION_CHECK_RETURN([dataDict isKindOfClass:[NSDictionary class]]);
    [super loadDict:dataDict];
    _totalPage = [[dataDict safeObjectForKey:@"totalPages" hintClass:[NSNumber class]] intValue];
}
@end
