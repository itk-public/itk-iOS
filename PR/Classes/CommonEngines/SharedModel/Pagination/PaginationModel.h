//
//  PaginationModel.h
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

extern const int  kDefaultPageSize;
extern const int  kInvaliaPageIndex;

@class PartDataResponse;

//带分页功能
@interface PaginationModel : YHDataModel
{
@protected
    NSArray*       m_items;
    int            m_totalCount;
    int            m_totalPage;
    int            m_pageSize;
    int            m_curPage;//当前页面
}

//获取所有item
-(NSArray *)items;

//当前的所有item数量
-(NSInteger)itemCount;

//接收新的请求，return 是否真的接收了数据
-(BOOL)receiveResponse:(PartDataResponse *)response;

//是否嗨哟更多item需要请求
-(BOOL)hasMore;

//需要请求的下一个pageIndex,异常情况下返回KInvalidPageIndex
-(int)nextPage;

//清除所有数据
-(void)clear;

/*
 *根据返回的结果清理，当返回的数据时第一页调用本方法
 *默认实现调用【self clear】
 *如果子类重写这个方法，请在方法开始调用【super clearWithResponse:reponse】
 */
-(void)clearWithResponse:(PartDataResponse *)reponse;

//第一页的index
-(int)firstPageIndex;

//所有的个数
-(NSInteger)getTotalCount;
@end
