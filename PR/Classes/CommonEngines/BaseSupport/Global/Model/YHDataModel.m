//
//  YHDataModel.m
//  PR
//
//  Created by 黄小雪 on 05/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

@implementation YHDataModel

#pragma mark - protocol synthesize
@synthesize cellClass           = _cellClass;
@synthesize cellType            = _cellType;
@synthesize cellHeight          = _cellHeight;
@synthesize cellSelResponse     = _cellSelResponse;
@synthesize cellTag             = _cellTag;
@synthesize groupedCellPosition = _groupedCellPosition;
@synthesize useNib              = _useNib;
@synthesize cellBackgroundColor = _cellBackgroundColor;

+ (instancetype)modelFromDictionary:(NSDictionary *)dic
{
    YHDataModel * instance = [[self alloc] initWithDictionary:dic];
    if (instance) {
        // 按需实现
    }
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    CONDITION_CHECK_RETURN_VAULE([dic isKindOfClass:[NSDictionary class]], nil);
    self = [self init];
    if (self) {
        // 按需实现
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    YHDataModel * model = [(YHDataModel *)[[self class] allocWithZone:zone] init];
    
    return model;
}

@end
