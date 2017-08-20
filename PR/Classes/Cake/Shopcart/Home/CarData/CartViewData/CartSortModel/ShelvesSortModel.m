//
//  ShelvesSortModel.m
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//

#import "ShelvesSortModel.h"

@implementation ShelvesSortModel


+ (instancetype)initWithArray:(NSArray *)array
{
    ShelvesSortModel *shelvesSortModel = [[ShelvesSortModel alloc]init];
    
    if (!array || array.count == 0) {
        return shelvesSortModel;
    }
    
    shelvesSortModel.productsArray = array;
    
    return shelvesSortModel;
}

@end
