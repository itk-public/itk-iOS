//
//  YHDataModel.h
//  PR
//
//  Created by 黄小雪 on 05/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHTableViewCellItemProtocol.h"

@interface YHDataModel : NSObject <YHTableViewCellItemProtocol,NSCopying>


/**
 *  通过dictionary初始化
 *
 *  @param dic
 *
 *  @return
 */
+ (instancetype)modelFromDictionary:(NSDictionary *)dic;

/**
 *  通过dictionary初始化
 *
 *  @param dic
 *
 *  @return
 */
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

