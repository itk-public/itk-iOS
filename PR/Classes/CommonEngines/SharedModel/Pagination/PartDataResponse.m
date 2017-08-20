//
//  PartDataResponse.m
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "PartDataResponse.h"

@interface PartDataResponse()
{
@protected
    NSArray*              m_items;
    int                   m_totalCount;
    int                   m_curPage;
    int                   m_pageSize;
}
@property (weak,nonatomic) id<PartDataResponseItemParser> parser;
@end


@implementation PartDataResponse
@synthesize items      = m_items;
@synthesize totalCount = m_totalCount;
@synthesize curPage    = m_curPage;
@synthesize pageSize   = m_pageSize;

-(instancetype)initWithItemParser:(id<PartDataResponseItemParser>)parser
{
    if (self = [super init]) {
        _parser = parser;
    }
    return self;
}

-(void)loadDict:(NSDictionary *)dataDict
{
    m_curPage = [[dataDict safeObjectForKey:@"page" hintClass:[NSNumber class]]intValue];
    m_pageSize = [[dataDict safeObjectForKey:@"pageCount" hintClass:[NSNumber class]]intValue];
    m_totalCount = [[dataDict safeObjectForKey:@"count" hintClass:[NSNumber class]]intValue];
    
    if (self.parser) {
        m_items = [self.parser parseItemWithInfo:[dataDict safeObjectForKey:[self.parser itemsParseKey] hintClass:[NSArray class]]];
    }else{
        NSAssert(0, @"构建了一个未设置item解析的 response,无法构建Item model");
    }
}
@end

@implementation PartPageResponse
-(void)loadDict:(NSDictionary *)dataDict
{
    CONDITION_CHECK_RETURN([dataDict isKindOfClass:[NSDictionary class]]);
    [super loadDict:dataDict];
    _totalPage = [[dataDict safeObjectForKey:@"totalPages" hintClass:[NSNumber class]] intValue];
    m_totalCount = -1;
}
@end
