//
//  GoodNumController.m
//  PR
//
//  Created by 黄小雪 on 28/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "GoodNumController.h"
#import "NoMenueTextField.h"
#import "OnePixelSepView.h"


@interface GoodNumController()<UITextFieldDelegate>

@property (strong,nonatomic) UIButton         *minusBtn;
@property (strong,nonatomic) UIButton         *addBtn;
@property (strong,nonatomic) NoMenueTextField *textfiled;

@end


@implementation GoodNumController

-(instancetype)init
{
    if (self = [super init]) {
        
        self.layer.cornerRadius = 2.0;
        self.layer.borderColor  = UIColorFromRGB(0xdddddd).CGColor;
        self.layer.borderWidth  = OnePoint;
        self.layer.masksToBounds= YES;
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"icon_cartplus"] forState:UIControlStateNormal];
        [_addBtn setBackgroundColor:[UIColor clearColor]];
        [_addBtn addTarget:self action:@selector(addBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn setContentMode:UIViewContentModeRight];
        [_addBtn setPixelSepSet:PSRectEdgeLeft];
        [self addSubview:_addBtn];
        
        
        _minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minusBtn setImage:[UIImage imageNamed:@"icon_cartminus"] forState:UIControlStateNormal];
        [_minusBtn setBackgroundColor:[UIColor clearColor]];
        [_minusBtn setContentMode:UIViewContentModeLeft];
        [_minusBtn addTarget:self action:@selector(minusBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        [_minusBtn setPixelSepSet:PSRectEdgeRight];
        [self addSubview:_minusBtn];
        
        _textfiled = [[NoMenueTextField alloc]init];
        [_textfiled setTextAlignment:NSTextAlignmentCenter];
        [_textfiled setBorderStyle:UITextBorderStyleNone];
        [_textfiled setFont:KFontNormal(16)];
        [_textfiled setTextColor:kColorTheme];
        [_textfiled setBackgroundColor:[UIColor clearColor]];
        _textfiled.delegate = self;
        [self addSubview:_textfiled];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW           = 42;
    self.minusBtn.frame    = CGRectMake(0, 0, btnW, self.height);
    self.textfiled.frame   = CGRectMake(self.minusBtn.right, 0,self.width-2*btnW, self.height);

    self.addBtn.frame      = CGRectMake(self.textfiled.right,0, btnW,self.height);
}

-(void)setProduct:(ProductInfo *)product
{
    CONDITION_CHECK_RETURN([product isKindOfClass:[ProductInfo class]]);
    
    self.textfiled.text  = [NSString stringWithFormat:@"%zd",product.num];
    
}
#pragma mark 按钮事件
-(void)addBtnOnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodNumControllerNumChanged:changeToNum:)]) {
        [self.delegate goodNumControllerNumChanged:self changeToNum:[self.textfiled.text integerValue] + 1];
    }
}

-(void)minusBtnOnClick
{
    NSInteger changeNum = [self.textfiled.text integerValue] - 1;
    if (self.product.stocknum &&
        [self.textfiled.text integerValue] > self.product.stocknum) {
        changeNum = self.product.stocknum;
    }
    [self.delegate goodNumControllerNumChanged:self changeToNum:self.product.stocknum];
}

#pragma mark textfiled的代理

//限制只能输入数字
-(BOOL)validateNumber:(NSString *)numberString
{
    BOOL res = YES;
    NSCharacterSet *temSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSInteger i = 0;
    while (i < [numberString length]) {
        NSString *string = [numberString substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:temSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i ++;
    }
    return res;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodNumControllerTextFiledDidBeginEditing:)]) {
        [self.delegate goodNumControllerTextFiledDidBeginEditing:self];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodNumControllerTextFiledDidFinshedEdited:)]) {
        [self.delegate goodNumControllerTextFiledDidFinshedEdited:self];
    }
}
@end
