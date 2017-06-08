//
//  AdditionalInfoCell.h
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
#import "YHDataModel.h"

@interface GoodDetailAdditionalInfo : YHDataModel
@property (strong,nonatomic) NSArray *additionalInfo;
@end

@interface GoodDetailAdditionalInfoCell : WTTableViewCell

@end
