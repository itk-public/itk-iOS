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
@property(nonatomic,readonly) NSArray* items;
@property(nonatomic,readonly) int totalCount;
@property(nonatomic,readonly) int curPage;
@property(nonatomic,readonly) int pageSize;
@property (nonatomic,assign)  BOOL isFirstPage;

-(instancetype)initWithItemParser:(id<PartDataResponseItemParser>)parser;
-(void)loadDict:(NSDictionary *)dataDict;

@end


@interface PartPageResponse : PartDataResponse
@property (readonly,nonatomic) int totalPage;

@end
