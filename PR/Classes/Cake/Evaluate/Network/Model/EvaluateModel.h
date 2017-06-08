//
//  EvaluateModel.h
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

@interface EvaluateModel : YHDataModel
@property (readonly,nonatomic) NSString *content;
@property (readonly,nonatomic) NSString *nickName;
@property (readonly,nonatomic) NSString *cid;
//评分
@property (readonly,nonatomic) CGFloat score;
@end
