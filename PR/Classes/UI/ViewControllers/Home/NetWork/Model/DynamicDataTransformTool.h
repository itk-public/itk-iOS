//
//  DynamicDataTransformTool.h
//  PR
//
//  Created by 黄小雪 on 14/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DynamicDataTransformTool : NSObject
+ (NSDictionary *)transformDynamicData:(NSDictionary *)originData;

+ (NSArray *)analysisImageUrlFormDictionary:(NSDictionary *)sDataDic;
@end
