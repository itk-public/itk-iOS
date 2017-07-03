//
//  PartDataResponse.h
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

@protocol PartDataResponseItemParser <NSObject>
@required
-(NSString *)itemsParseKey;
-(NSArray *)parseItemWithInfo:(NSArray *)info;
@end

@interface PartDataResponse : YHDataModel
@property (readonly,nonatomic) NSArray   *items;
@property (readonly,nonatomic) NSInteger  totalCount;
@property (readonly,nonatomic) NSInteger  curPage;
@property (readonly,nonatomic) NSInteger  pageSize;
@property (assign,nonatomic)   BOOL       isFirstPage;

-(instancetype)initWithItemParser:(id<PartDataResponseItemParser>)parser;
-(void)loadDict:(NSDictionary *)dataDict;

@end


@interface PartPageResponse : PartDataResponse
@property (readonly,nonatomic) NSInteger totalPage;

@end
