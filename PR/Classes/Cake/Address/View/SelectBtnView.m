//
//  SelectBtnView.m
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SelectBtnView.h"
#import "OnePixelSepView.h"
#import "OnePixelSepView.h"

@interface SelectBtnView()

@property (strong,nonatomic) UILabel *promptLabel;
@property (strong,nonatomic) UIButton *selectBtn;
@property (strong,nonatomic) UIImageView *arrowImage;
@property (assign,nonatomic) SelectBtnViewType type;

@end

@implementation SelectBtnView
-(instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _promptLabel = [[UILabel alloc]init];
        [_promptLabel setFont:KFontNormal(16)];
        [_promptLabel setTextAlignment:NSTextAlignmentLeft];
        [_promptLabel  setTextColor:UIColorFromRGB(0x030303)];
        [self addSubview:_promptLabel];
        
        _selectBtn = [[UIButton alloc]init];
        [_selectBtn addTarget:self action:@selector(selectBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_selectBtn setTitle:@"点击选择" forState:UIControlStateNormal];
        [_selectBtn setTitleColor:UIColorFromRGB(0xcdcdcd) forState:UIControlStateNormal];
        [_selectBtn.titleLabel setFont:KFontNormal(16)];
        _selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:_selectBtn];
        
        _arrowImage = [[UIImageView alloc]init];
        [_arrowImage setImage:[UIImage imageNamed:@"icon_right_arrow"]];
        [self addSubview:_arrowImage];
        
        [self setPixelSepSet:PSRectEdgeBottom];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    self.promptLabel.frame = CGRectMake(kLeftMargin, 0, 115, self.height);
    
    CGFloat kArrowImageW = 8;
    CGFloat kArrowImageH = 13;
    self.arrowImage.frame = CGRectMake(self.width - kArrowImageW - kLeftMargin, (self.height - kArrowImageH)/2.0, kArrowImageW, kArrowImageH);
    CGFloat kSelectBtnW   = self.arrowImage.left - self.promptLabel.right;
    self.selectBtn.frame  = CGRectMake(self.promptLabel.right, 0, kSelectBtnW, self.height);
}


-(void)updatePrompt:(NSString *)prompt type:(SelectBtnViewType)type
{
    self.promptLabel.text = prompt;
    self.type = type;
}

-(void)selectBtnOnClicked
{
    if (self.returnBlock) {
        self.returnBlock(self.type);
    }
}

@end
