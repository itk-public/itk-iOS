//
//  ThemeButton.m
//  PR
//
//  Created by 黄小雪 on 09/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ThemeButton.h"

@implementation ThemeButton

+(instancetype)buttonWithType:(UIButtonType)buttonType{
    ThemeButton *button = [super buttonWithType:buttonType];
    [button setUI];
    return button;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self setUI];
    }
    return self;
}


-(void)setUI
{
    self.backgroundColor = UIColorFromRGB(0x47d6cc);
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:KFontNormal(17)];
    self.layer.borderColor = UIColorFromRGB(0x47d6cc).CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
}


-(void)setType:(CustomBtnType)type{
    _type = type;
    self.layer.borderColor = UIColorFromRGB(0x47d6cc).CGColor;
    if (type == CustomBtnTypeWhiteBg) {
        self.backgroundColor   = [UIColor whiteColor];
        [self setTitleColor:UIColorFromRGB(0x47d6cc) forState:UIControlStateNormal];
    }else if (CustomBtnTypeGreenBg){
        self.backgroundColor = UIColorFromRGB(0x47d6cc);
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
@end
