//
//  HomeHeaderView.m
//  PR
//
//  Created by 黄小雪 on 2017/6/3.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "HomeHeaderView.h"
#import "PRMBWantedOffice.h"
@interface HomeHeaderView()

@property (strong,nonatomic) UITextField *textFiled;
@property (strong,nonatomic) UIButton    *messageBtn;
@property (strong,nonatomic) UIButton    *coverBtn;
@property (strong,nonatomic) UIImageView *leftImageView;
@end

@implementation HomeHeaderView
-(instancetype)init
{
    if (self = [super init]) {
        _textFiled = [[UITextField alloc]init];
        [_textFiled setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
        [_textFiled setText:@"搜索关键词"];
        [_textFiled setFont:KFontNormal(12)];
        [_textFiled setTextColor:[UIColor whiteColor]];
        _textFiled.layer.borderColor = [UIColor clearColor].CGColor;
        _textFiled.layer.borderWidth = OnePoint;
        _textFiled.layer.cornerRadius= 5.0;
        _textFiled.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:_textFiled];
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 33, 0)];
        [_leftImageView setBackgroundColor:[UIColor grayColor]];
        [_textFiled setLeftView:_leftImageView];
        _textFiled.leftViewMode = UITextFieldViewModeAlways;
        
        
        _coverBtn = [[UIButton alloc]init];
        [_coverBtn setBackgroundColor:[UIColor clearColor]];
        [_coverBtn addTarget:self action:@selector(coverBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_textFiled addSubview:_coverBtn];
        
        _messageBtn = [[UIButton alloc]init];
        [_messageBtn setImage:[UIImage imageNamed:@"icon_home-message"] forState:UIControlStateNormal];
        [_messageBtn addTarget:self action:@selector(messageBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_messageBtn];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 10;
    CGFloat kMessageBtnW = 24;
    self.messageBtn.frame = CGRectMake(self.width - kMessageBtnW - kLeftMargin, (self.height - kMessageBtnW)/2.0, kMessageBtnW, kMessageBtnW);
    self.textFiled.frame = CGRectMake(kLeftMargin, 0, self.messageBtn.left - 2*kLeftMargin, self.height);
    self.coverBtn.frame  = self.textFiled.bounds;
}

-(void)coverBtnOnClicked
{
    [PRMBWantedOffice nativeArrestWarrant:APPURL_VIEW_IDENTIFIER_Farm_SEARCHRESULT param:nil];
}

-(void)messageBtnOnClicked
{
    PRLOG(@"点击查看信息");
}
        
@end
