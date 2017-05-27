//
//  DetailView.m
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "DetailAddressView.h"
#import "OnePixelSepView.h"
#import "SceneMananger.h"
#import "ThemeButton.h"

@interface DetailAddressView()<UITextViewDelegate>
@property (strong,nonatomic) UILabel    *placeholder;
@property (strong,nonatomic) UITextView *textView;
@property (copy, nonatomic ) NSString   *lastContent;
@property (strong,nonatomic) UIView     *containerView;
@property (strong,nonatomic) ThemeButton *saveBtn;

@end

@implementation DetailAddressView



-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMargin = 15;
    CGFloat contentViewW = self.width - 2*leftMargin;
    self.containerView.frame = CGRectMake(0, 0, self.width, 100);
    self.textView.frame = CGRectMake(leftMargin, 10, contentViewW, self.containerView.height - 10);
    self.placeholder.frame = CGRectMake(0, 0, self.width - 2*leftMargin, 25);
    self.saveBtn.frame    = CGRectMake(20, self.containerView.bottom + 35, self.width - 40, 45);
}



-(void)addContainerView
{
    _containerView = [[UIView alloc]init];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_containerView];
}
-(void)addTextView
{
    _textView = [[UITextView alloc]init];
    _textView.delegate = self;
    [_textView setTextColor:UIColorFromRGB(0x030303)];
    [_textView setFont:KFontNormal(16)];
    [self addSubview:_textView];
}

-(void)addPlaceholder
{
    _placeholder               = [[UILabel alloc]init];
    _placeholder.text          = @"请填写详细地址";
    _placeholder.textAlignment = NSTextAlignmentLeft;
    _placeholder.font          = KFontNormal(16);
    _placeholder.textColor     = UIColorFromRGB(0xcdcdcd);
    [self.textView addSubview:self.placeholder];
    [self bringSubviewToFront:self.placeholder];
}


-(void)addInputAccessoryViewToContentText
{
    CGFloat inputViewH                  = 34;
    UIView *inputView                   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, inputViewH)];
    UIButton *btn                       = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, inputViewH)];
    [btn setContentMode:UIViewContentModeLeft];
    btn.right                           = ScreenWidth;
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:kColorNormal forState:UIControlStateNormal];
    btn.titleLabel.font                 = KFontNormal(15);
    [btn addTarget:self action:@selector(finishBtn) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:btn];
    
    [inputView setBackgroundColor:UIColorFromRGB(0xfafafa)];
    OnePixelSepView *topLine            = [[OnePixelSepView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    topLine.lineColor                   = UIColorFromRGB(0xacb3bd);
    [inputView addSubview:topLine];
    self.textView.inputAccessoryView = inputView;
}

-(void)addSaveBtn
{
    _saveBtn = [ThemeButton buttonWithType:UIButtonTypeSystem];
    _saveBtn.type = CustomBtnTypeGreenBg;
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(saveBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_saveBtn];
}
//点击完成
-(void)finishBtn
{
    [self.textView resignFirstResponder];
    if (self.textView.text.length == 0) {
        [self.textView addSubview:self.placeholder];
    }else{
        [self.placeholder removeFromSuperview];
    }
    UIView *currentView = [[SceneMananger shareMananger]topViewController].view;
    [UIView animateWithDuration:0.25 animations:^{
        [currentView  setTop:64];
    }];
}

-(void)saveBtnOnClicked
{
    PRLOG(@"点击了保存按钮");
}
-(NSString *)feedBackContentString;
{
    return [self.textView text];
}

#pragma mark textView deletegate
- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    [self.placeholder removeFromSuperview];
    UIView *currentView = [[SceneMananger shareMananger]topViewController].view;
    [UIView animateWithDuration:0.25 animations:^{
            [currentView  setTop:- 50];
        }];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self finishBtn];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        [textView addSubview:self.placeholder];
    }else{
        [self.placeholder removeFromSuperview];
    }
}

-(instancetype)init{
    if (self = [super init]) {
        [self addContainerView];
        [self addTextView];
        [self addPlaceholder];
        [self setPixelSepSet:PSRectEdgeTop];
        [self addInputAccessoryViewToContentText];
        [self addSaveBtn];
    }
    return self;
}
@end
