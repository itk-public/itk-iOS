//
//  CarouselView.h
//  YHClouds
//
//  Created by 黄小雪 on 08/03/2017.
//  Copyright © 2017 YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHDataModel.h"

@interface CarouselSingleViewModel : YHDataModel
@property (strong,nonatomic) id data;
@end

@interface CarouselSingleView : UIView
@property (strong,nonatomic) CarouselSingleViewModel *model;

@end


@interface CarouselView : UIView
-(void)setUpDatalist:(NSArray *)dataList;
@property (assign,nonatomic) CGFloat singleViewW ;
@end
