//
//  HomeCarouselView.m
//  PR
//
//  Created by 黄小雪 on 2017/6/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "HomeCarouselView.h"
#import "CarouselItemView.h"

@implementation HomeCarouselView
-(instancetype)init
{
    if (self = [super init]) {
        self.singleViewW = kCarouselItemViewW;
        self.carouselSingleViewClass = [CarouselItemView class];
    }
    return self;
}
@end
