//
//  PhoneTextFiledView.m
//  PR
//
//  Created by 黄小雪 on 09/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "TextFiledView.h"
#import "OnePixelSepView.h"
#import "PRShowToastUtil.h"
#import "NSString+Category.h"

@implementation InputModel

-(instancetype)initWithIconName:(NSString *)iconName
                       placeStr:(NSString *)placeStr
                  textFiledType:(TextFiledType)type
               hiddenBottomLine:(BOOL)hiddenBottomLine
{
    if (self = [super init]) {
        _iconName         = iconName;
        _placeStr         = placeStr;
        _type             = type;
        _hiddenBottomLine = hiddenBottomLine;
    }
    
    return self;
}
+(instancetype)inputModelWithIconName:(NSString *)iconName
                             placeStr:(NSString *)placeStr
                        textFiledType:(TextFiledType)type
                     hiddenBottomLine:(BOOL)hiddenBottomLine
{
    return [[self alloc]initWithIconName:iconName
                                placeStr:placeStr
                           textFiledType:type
                        hiddenBottomLine:hiddenBottomLine];
}

@end


@interface TextFiledView()<UITextFieldDelegate>

@property (strong,nonatomic) UIImageView  *iconImg;
@property (strong,nonatomic) UIView       *lineView;
@property (strong,nonatomic) UITextField  *textFiled;
@property (strong,nonatomic) UIButton     *rightBtn;
@property (strong,nonatomic) InputModel   *inputModel;
@property (strong,nonatomic) OnePixelSepView *leftLineView;

@end

@implementation TextFiledView
-(instancetype)init{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _iconImg = [[UIImageView alloc]init];
        [_iconImg setBackgroundColor:UIColorFromRGB(0xdddddd)];
        [self addSubview:_iconImg];
        
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:UIColorFromRGB(0xdddddd)];
        [self addSubview:_lineView];
        
        _textFiled = [[UITextField alloc]init];
        [_textFiled setFont:KFontNormal(12)];
        _textFiled.delegate = self;
        [_textFiled setTextColor:UIColorFromRGB(0xdddddd)];
        [_textFiled setTextAlignment:NSTextAlignmentLeft];
        _textFiled.clearButtonMode = 4;
        [self addSubview:_textFiled];
        
        _rightBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightBtn.titleLabel.font = KFontNormal(12);
        [_rightBtn addTarget:self action:@selector(rightBtnOnClicked:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    CGFloat kIconImgW = 15;
    self.iconImg.frame = CGRectMake(kLeftMargin, 0, kIconImgW, kIconImgW);
    self.iconImg.centerY = self.height/2.0;
    
    CGFloat kBtnW  = 80;
    self.rightBtn.frame = CGRectMake(0, 0, kBtnW, self.height);
    self.rightBtn.right = self.width - kLeftMargin;
    
    self.lineView.frame  = CGRectMake(kLeftMargin, self.height - OnePoint, self.width - 2*kLeftMargin, OnePoint);
    
    CGFloat kTextFiledW = self.rightBtn.left - self.iconImg.right - kLeftMargin;
    if (self.rightBtn.hidden) {
        kTextFiledW   = self.width - self.iconImg.right - 2*kLeftMargin;
    }
    self.textFiled.frame = CGRectMake(self.iconImg.right + kLeftMargin, 0, kTextFiledW, self.height - OnePoint);
    
    if (self.inputModel.type == TextFiledTypeInputCode) {
        if (self.leftLineView == nil) {
            OnePixelSepView *leftLineView = [self.rightBtn psLeftSep];
            CGFloat leftLineViewTop       = 8;
            leftLineView.top              = leftLineViewTop;
            leftLineView.height           = self.rightBtn.height - 2*leftLineViewTop;
            self.leftLineView             = leftLineView;
        }
    }
}


+(instancetype)textFiledViewWithInputModel:(InputModel *)inputModel
{
    CONDITION_CHECK_RETURN_VAULE([inputModel isKindOfClass:[InputModel class]] , nil);
    TextFiledView *textFiledView = [[TextFiledView alloc]init];
    textFiledView.inputModel          = inputModel;
    return textFiledView;
}

-(void)setInputModel:(InputModel *)inputModel{
    CONDITION_CHECK_RETURN([inputModel isKindOfClass:[InputModel class]]);
    _inputModel   = inputModel;
    if (inputModel.iconName) {
        [self.iconImg setImage:[UIImage imageNamed:inputModel.iconName]];
    }
    self.textFiled.placeholder = inputModel.placeStr?:@"";
    
    self.rightBtn.hidden = NO;
    if (inputModel.type != TextFiledTypeInputCode && inputModel.type != TextFiledTypeSetPwd) {
        self.rightBtn.hidden = YES;
        if(inputModel.type == TextFiledTypeInputPhone){
            self.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            self.textFiled.returnKeyType = UIReturnKeyDone;
        }
    }else if (inputModel.type == TextFiledTypeInputCode){
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
        [self.rightBtn setPixelSepSet:PSRectEdgeLeft];
        self.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    }else if (inputModel.type == TextFiledTypeSetPwd){
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"不显示密码" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
    }
    self.lineView.hidden   = inputModel.hiddenBottomLine;
}



-(void)rightBtnOnClicked:(UIButton *)rightBtn
{
    
}

#pragma mark textfiled的代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFiledViewDidBeginEditing:)]) {
        [self.delegate textFiledViewDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.inputModel.type == TextFiledTypeInputPhone) {
        
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFiledViewDidEndEditing:)]) {
        [self.delegate textFiledViewDidEndEditing:textField];
    }
}

#pragma mark 判断信息输入的正确性
/**
 *  校验手机号
 */
-(BOOL)checkPhoneNum
{
    if ([NSString isBlankString:self.textFiled.text]) {
        [PRShowToastUtil showNotice:@"请输入手机号"];
        return NO;
    }else if (![NSString isValidatePhoneNum:self.textFiled.text]){
        [PRShowToastUtil showNotice:@"请输入正确的手机号"];
        return NO;
    }
    return YES;
}

/**
 *  校验验证码
 */
-(BOOL)checkSecurityCode
{
    if ([NSString isBlankString:self.textFiled.text]) {
        [PRShowToastUtil showNotice:@"请输入验证码"];
        return NO;
    }
    return YES;
}

/**
 *  校验密码
 */
-(BOOL)checkPwd
{
    if ([NSString isBlankString:self.textFiled.text]) {
        [PRShowToastUtil showNotice:@"请输入密码"];
        return NO;
    }
    return YES;
}

-(BOOL)checkInputInfo
{
    if (self.inputModel.type == TextFiledTypeInputPhone) {
        return [self checkPhoneNum];
    }else if (self.inputModel.type == TextFiledTypeSetPwd ||
              self.inputModel.type == TextFiledTypeInputPwd){
        return [self checkPwd];
    }else if (self.inputModel.type == TextFiledTypeInputCode){
        return [self checkSecurityCode];
    }
    return NO;
}

@end
