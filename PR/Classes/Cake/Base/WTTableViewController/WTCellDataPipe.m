//
//  WTCellDataPipe.m
//  PR
//
//  Created by 黄小雪 on 13/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "WTCellDataPipe.h"

@implementation WTCellDataPipe
- (id)initWithDataModel:(YHDataModel *)dataModel cellClass:(Class)cellClass cellType:(NSString *)cellType
{
    if (self = [super init]) {
        if (dataModel && [dataModel isKindOfClass:[YHDataModel class]]) {
            self.contentModel           = dataModel;
            self.contentModel.cellType  = cellType?:@"";
            self.contentModel.cellClass = cellClass;
        }
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        self.contentModel = [[YHDataModel alloc] init];
    }
    return self;
}

@end
