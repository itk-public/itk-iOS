//
//  SetupLogoutView.m
//  YHClouds
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "SetupLogoutView.h"

@interface SetupLogoutView()
@property (strong,nonatomic)UIButton *logoutBtn;
@end

@implementation SetupLogoutView

-(instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor clearColor]];
        _logoutBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
        [_logoutBtn setBackgroundColor:[UIColor whiteColor]];
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutBtn.titleLabel setFont:KFontNormal(16)];
        [_logoutBtn setTitleColor:UIColorFromRGB(0x030303) forState:UIControlStateNormal];
        [_logoutBtn addTarget:self action:@selector(logoutBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_logoutBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.logoutBtn.frame = CGRectMake(0, 30, self.width, 46);
}

+(CGFloat)getHeight
{
    return 106;
}

-(void)logoutBtnOnClicked
{
    if (self.returnBlock) {
        self.returnBlock();
    }
}
@end
