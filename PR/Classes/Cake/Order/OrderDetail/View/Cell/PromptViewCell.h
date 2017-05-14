//
//  PromptViewCell.h
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
#import "YHDataModel.h"

@interface PromptModel :YHDataModel
@property (strong,nonatomic) NSString *promptString;
@property (strong,nonatomic) NSString *valueString;
@property (strong,nonatomic) UIColor *valueColor;
@property (assign,nonatomic) BOOL hideLineView;
@end

@interface PromptViewCell : WTTableViewCell

@end
