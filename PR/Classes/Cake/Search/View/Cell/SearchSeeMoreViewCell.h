//
//  SearchSeeMoreViewCell.h
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
#import "YHDataModel.h"

@interface  SearchSeeMoreModel:YHDataModel
@property (readonly,nonatomic) NSString *moreString;
@property (readonly,nonatomic) NSString *actionStr;
-(void)updateTotalNum:(NSInteger)totalNum action:(NSString *)action;
@end

@interface SearchSeeMoreViewCell : WTTableViewCell

@end
