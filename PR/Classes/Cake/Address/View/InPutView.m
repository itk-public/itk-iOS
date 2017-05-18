//
//  InPutView.m
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "InPutView.h"
#import "OnePixelSepView.h"

@interface InPutView()
@property (strong,nonatomic) UILabel *promptLabel;
@property (strong,nonatomic) UITextField *textFiled;
@end

@implementation InPutView
-(instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _promptLabel = [[UILabel alloc]init];
        [_promptLabel setTextAlignment:NSTextAlignmentLeft];
        [_promptLabel setTextColor:UIColorFromRGB(0x030303)];
        [_promptLabel setFont:KFontNormal(16)];
        [self addSubview:_promptLabel];
        
        _textFiled = [[UITextField alloc]init];
        [_textFiled setTextColor:UIColorFromRGB(0x4c4c4c)];
        [_textFiled setTextAlignment:NSTextAlignmentLeft];
        [_textFiled setFont:KFontNormal(16)];
        [self addSubview:_textFiled];
        
        [self setPixelSepSet:PSRectEdgeBottom];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin    = 15;
    self.promptLabel.frame = CGRectMake(kLeftMargin, 0, 130 - kLeftMargin, self.height);
    self.textFiled.frame   = CGRectMake(self.promptLabel.right, 0, self.width - self.promptLabel.right - kLeftMargin, self.height);
}

-(void)updatePrompt:(NSString *)prompt placeholder:(NSString *)placeholder;
{
    self.promptLabel.text = prompt;
    self.textFiled.placeholder = placeholder;
}
-(void)setModel:(AddressModel *)model
{
    CONDITION_CHECK_RETURN([model isKindOfClass:[AddressModel class]]);
    _model = model;
}
@end
