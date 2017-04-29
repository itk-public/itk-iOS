//
//  WTCellDataPipe.h
//  PR
//
//  Created by 黄小雪 on 13/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHTableViewCellItemProtocol.h"
#import "YHDataModel.h"

@interface WTCellDataPipe : NSObject
@property (strong,nonatomic) YHDataModel *contentModel;

-(id)init;
- (id)initWithDataModel:(YHDataModel *)dataModel cellClass:(Class)cellClass cellType:(NSString *)cellType;
@end
