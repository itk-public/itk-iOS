//
//  PickSelfSiteModel.h
//  PR
//
//  Created by 黄小雪 on 2017/5/30.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

@interface PickSelfSiteModel : YHDataModel
//自提点
@property (readonly,nonatomic) NSString *pickSelfSiteName;
//自提点地址
@property (readonly,nonatomic) NSString *pickSelfSiteAddress;

@property (readonly,nonatomic) NSString *cid;
@end
