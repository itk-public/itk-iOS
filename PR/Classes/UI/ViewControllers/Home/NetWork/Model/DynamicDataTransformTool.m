//
//  DynamicDataTransformTool.m
//  PR
//
//  Created by 黄小雪 on 14/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "DynamicDataTransformTool.h"

@implementation DynamicDataTransformTool
+ (NSDictionary *)transformDynamicData:(NSDictionary *)originData
{
    
    // 获取平台首页中隐藏在floor数组中的商家信息楼层中的配送不到的文案描述
    NSString * deliveryDes = nil;
    
    NSMutableDictionary * operationDic = [NSMutableDictionary dictionaryWithDictionary:originData];
    NSArray * allFloorsDic = [operationDic safeObjectForKey:@"floors" hintClass:[NSArray class]];
    // 将单个楼层(楼层中没有重复元素的类型)的数据从数组中解套出来
    NSMutableArray * transToArr = [NSMutableArray array];
    for (int i = 0; i < allFloorsDic.count; i++) {
        NSDictionary * opDic = allFloorsDic[i];
        
        // 3.0.2 对新的key、value结构处理
        NSString * keyStr = [opDic safeObjectForKey:@"key" hintClass:[NSString class]];
        if (keyStr.length > 0) {
            id value = [opDic objectForKey:@"value"];
            opDic = [NSDictionary dictionaryWithObject:value forKey:keyStr];
        }
        [transToArr addObject:opDic];
    }
    [operationDic removeAllObjects];
    return @{@"floors":transToArr};
}


+ (NSArray *)analysisImageUrlFormDictionary:(NSDictionary *)sDataDic
{
    return nil;
}
@end
