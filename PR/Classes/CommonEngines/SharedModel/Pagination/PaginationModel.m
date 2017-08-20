//
//  PaginationModel.m
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "PaginationModel.h"
#import "PartDataResponse.h"
#import <objc/runtime.h>

const int kDefaultPageSize       = 5;
const int kInvaliaPageIndex      = -1;
const static int kFirstPageIndex = 0;

@interface PaginationModel()
@property (copy,nonatomic) NSArray *items;
@property (assign,nonatomic) int totalCount;
@property (assign,nonatomic) int totalPage;
@end

@implementation PaginationModel

@synthesize items      = m_items;
@synthesize totalCount = m_totalCount;
@synthesize totalPage  = m_totalPage;

-(instancetype)init
{
    if (self = [super init]) {
        m_items = nil;
        m_totalCount = 0;
        m_pageSize = kDefaultPageSize;
        m_curPage  = kInvaliaPageIndex;
        m_totalPage = 0;
    }
    return self;
}

-(NSArray *)items
{
    return m_items;
}

-(NSInteger)itemCount
{
    return [m_items count];
}

/*
 *检测到接收到的数据是第一页数据时，清空所有数据
 *否则，如果接受到的数据page index小于当前的page index，则丢失该数据
 */
-(BOOL)receiveResponse:(PartDataResponse *)response
{
    if ([response curPage] == [self firstPageIndex]) {
        [self clearWithResponse:response];
    }
    if ([response curPage] < [self nextPage]) {
        return NO;
    }
    
    m_totalCount = response.totalCount;
    if ([response isKindOfClass:[PartPageResponse class]]) {
        m_totalPage = [(PartPageResponse *)response totalPage];
    }
    
    if (m_items) {
        self.items = [m_items arrayByAddingObjectsFromArray:response.items];
    }else{
        self.items = response.items;
    }
    
    m_curPage = [ response curPage];
    return YES;
}

-(BOOL)hasMore
{
    if (m_curPage == kInvaliaPageIndex) {
        return YES;
    }
    
    if (m_totalCount >= 0) {
        return m_totalCount > [self itemCount] &&
        m_totalCount - (m_curPage - [self firstPageIndex] + 1) * m_pageSize > 0;
    }else{
         return (m_curPage + 1) < m_totalPage;
    }
}

-(int)nextPage
{
    if (m_curPage == kInvaliaPageIndex) {
        return kFirstPageIndex;
    }
    
    return m_curPage + 1;
}

-(void)clear
{
    m_items      = nil;
    m_totalCount = 0;
    m_curPage    = kInvaliaPageIndex;
}

-(void)clearWithResponse:(PartDataResponse *)reponse
{
    [self clear];
}

-(int)firstPageIndex
{
    return kFirstPageIndex;
}


-(NSInteger)getTotalCount{
    return m_totalCount;
}

@end
