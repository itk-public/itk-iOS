//
//  OrderStatusView.m
//  YHClouds
//
//  Created by 黄小雪 on 16/2/29.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "MutiTitleHeaderView.h"
#import "AppUIUtil.h"
#import "AppColorDefine.h"
#import "OnePixelSepView.h"
#import "NSString+Category.h"

#define KNumVisibleBtnInScreen  5
#define kBaseTag                1000
#define kSeletedFlagLineWidth   60

@interface MutiTitleHeaderView()
@property (strong,nonatomic) UIScrollView   *scrollView;
@property (strong,nonatomic) UIButton       *seletedBtn;
@property (strong,nonatomic) UIView         *seletedFlagLine;
@end

@implementation MutiTitleHeaderView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _scrollView                 = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrollView.scrollsToTop    = NO;
        [self addSubview:_scrollView];
        
        _seletedFlagLine            = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-2.5, kSeletedFlagLineWidth, 2.2)];
        [_seletedFlagLine setBackgroundColor: kColorReferenceTawnyColor];
        [_scrollView addSubview:_seletedFlagLine];
        
        [self setPixelSepSet:PSRectEdgeBottom];
    }
    
    return self;
}

-(void)setStatusBtnTitles:(NSArray *)statusBtnTitles
{
    _statusBtnTitles        = statusBtnTitles;
    CONDITION_CHECK_RETURN([self.statusBtnTitles isKindOfClass:[NSArray class]] && self.statusBtnTitles.count);
    for (NSInteger i = 0; i < statusBtnTitles.count ; i ++) {
        NSString *title           = [statusBtnTitles objectAtIndex:i];
        UIButton *statusBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
        [statusBtn setTitleColor:kColorNormal  forState:UIControlStateNormal];
        [statusBtn setTitleColor:kColorReferenceTawnyColor forState:UIControlStateSelected];
        [statusBtn setTitle:title forState:UIControlStateNormal];
        statusBtn.tag             = i + kBaseTag;
        [statusBtn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:statusBtn];
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    CGFloat btnW          = self.width*1.0/KNumVisibleBtnInScreen;
    CGFloat btnH          = self.height-1;
    if (KNumVisibleBtnInScreen > self.statusBtnTitles.count) {
        btnW                = self.width*1.0/self.statusBtnTitles.count;
    }
    _scrollView.contentSize = CGSizeMake(self.statusBtnTitles.count * btnW, btnH);
    for (NSInteger i = 0; i < self.statusBtnTitles.count ; i ++) {
        CGFloat btnX              = btnW * i;
        UIButton *statusBtn       = (UIButton *)[self.scrollView findASubViewWithTag:i + kBaseTag];
        statusBtn.frame           = CGRectMake(btnX, 0, btnW, btnH);
    }
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.seletedFlagLine.centerX = self.seletedBtn.centerX;
    }];
}


-(void)btnOnClicked:(UIButton *)btn
{
    if (btn == self.seletedBtn) {
        return;
    }
    btn.selected                = YES;
    self.seletedBtn.selected    = NO;
    self.seletedBtn             = btn;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.seletedFlagLine.centerX = btn.centerX;
    }];
    
    CONDITION_CHECK_RETURN(btn.tag >= kBaseTag);
    if (_buttonBlock && btn.tag - kBaseTag < self.statusBtnTitles.count) {
        _buttonBlock(btn.tag - kBaseTag);
    }
}


- (void)setSeletedIndex:(NSInteger)titleIndex
{
    NSInteger seletedBtnTag = kBaseTag + titleIndex;
    UIButton  *seletedBtn   = (UIButton *)[self.scrollView findASubViewWithTag:seletedBtnTag];
    [self btnOnClicked:seletedBtn];
}


-(void)setFontSize:(CGFloat)fontSize
{
    _fontSize  = fontSize;
    for (UIButton *btn in self.scrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.titleLabel.font  = KFontNormal(fontSize);
        }
    }
}

-(void)upDateButtonTitle:(NSString *)title  index:(NSInteger)index;
{
    if (![NSString isBlankString:title]) {
        UIButton *btn =  (UIButton *)[self.scrollView  findASubViewWithTag:index + kBaseTag];
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setTitle:title forState:UIControlStateNormal];
        }
    }
}


-(void)setSelectedColor:(UIColor *)selectedColor  normalColor:(UIColor *)normalColor
{
    for (NSInteger i = 0; i < self.scrollView.subviews.count ; i ++) {
        UIButton *statusBtn = (UIButton *)[self.scrollView.subviews safeObjectAtIndex:i];
        if ([statusBtn isKindOfClass:[UIButton class]]) {
            [statusBtn setTitleColor:normalColor  forState:UIControlStateNormal];
            [statusBtn setTitleColor:selectedColor forState:UIControlStateSelected];
        }
    }
}

-(void)setLineViewWidth:(CGFloat)width{
    self.seletedFlagLine.width = width;
}
@end
