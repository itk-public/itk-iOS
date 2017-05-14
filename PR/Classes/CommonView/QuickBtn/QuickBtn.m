//
//  QuickBtn.m
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "QuickBtn.h"

@implementation QuickBtn

-(instancetype)init{
    if (self = [super init]) {
        [self.titleLabel setFont:KFontNormal(15)];
        [self setTitleColor:UIColorFromRGB(0x4a4a4a) forState:UIControlStateNormal];
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (!selected) {
        [self setBackgroundColor:UIColorFromRGB(0xf1f6f9)];
        [self setTitleColor:UIColorFromRGB(0x959595) forState:UIControlStateNormal];
    }else{
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTitleColor:UIColorFromRGB(0x4a4a4a) forState:UIControlStateNormal];
    }
}
@end
