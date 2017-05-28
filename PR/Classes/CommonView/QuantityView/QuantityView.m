//
//  AdjustQuantityView.m
//  YHClouds
//
//  Created by 黄小雪 on 15/10/28.
//  Copyright © 2015年 YH. All rights reserved.
//  调整数量的view

#import "QuantityView.h"
#import "UIView+Category.h"
#import "NSString+Category.h"
#import "CartOrderCellViewModel.h"
#import "AlterView.h"
#import "NoMenueTextField.h"
#import "CartModelDefine.h"
#import "UIImage+Category.h"
#import "SceneMananger.h"
#import "AppDelegate.h"
#import "PRShowToastUtil.h"
#import "OnePixelSepView.h"

@interface QuantityView()<UITextFieldDelegate,AlterViewDelegate>
@property (strong, nonatomic)  UIButton                      *minusBtn;
@property (nonatomic,strong)   NSIndexPath                   *indexPath;
@property (nonatomic,strong)   NoMenueTextField              *goodNumtf;
@property (nonatomic, assign ) NSInteger                    lastQuantity;
@property (nonatomic, strong   ) UIButton                    *addBtn;
@property (assign,nonatomic)      BOOL                        addBtnEnable;
@end

@implementation QuantityView

#pragma  mark system method
-(instancetype)init
{
    if (self = [super init]) {
        self.layer.cornerRadius = 4.0;
        self.layer.borderColor  = UIColorFromRGB(0xe1e1e1).CGColor;
        self.layer.borderWidth  = OnePoint;
        self.layer.masksToBounds= YES;
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"icon_cart_plus"] forState:UIControlStateNormal];
        [_addBtn setBackgroundColor:[UIColor clearColor]];
        [_addBtn addTarget:self action:@selector(addBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn setContentMode:UIViewContentModeRight];
        [_addBtn setPixelSepSet:PSRectEdgeLeft];
        OnePixelSepView *leftLine = [_addBtn psLeftSep];
        [leftLine setBackgroundColor:UIColorFromRGB(0xe1e1e1)];
        [self addSubview:_addBtn];
        
        
        _minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minusBtn setImage:[UIImage imageNamed:@"icon_cart_reduce"] forState:UIControlStateNormal];
        [_minusBtn setBackgroundColor:[UIColor clearColor]];
        [_minusBtn setContentMode:UIViewContentModeLeft];
        [_minusBtn addTarget:self action:@selector(minusBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        [_minusBtn setPixelSepSet:PSRectEdgeRight];
        OnePixelSepView *rightLine = [_minusBtn psRightSep];
        [rightLine setBackgroundColor:UIColorFromRGB(0xe1e1e1)];
        [self addSubview:_minusBtn];
        
        _goodNumtf = [[NoMenueTextField alloc]init];
        [_goodNumtf setTextAlignment:NSTextAlignmentCenter];
        [_goodNumtf setBorderStyle:UITextBorderStyleNone];
        [_goodNumtf setFont:KFontNormal(16)];
        [_goodNumtf setTextColor:kColorTheme];
        [_goodNumtf setBackgroundColor:[UIColor clearColor]];
        _goodNumtf.delegate = self;
        [self addSubview:_goodNumtf];
        [self addInputAccessoryViewToContentText];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW           = 56;
    CGFloat btnH           = kHeight;
    self.minusBtn.frame    = CGRectMake(0, 0, btnW, btnH + 10);
    [self.minusBtn setBackgroundColor:[UIColor redColor]];
    self.minusBtn.centerY  = kHeight/2.0;
    self.goodNumtf.frame   = CGRectMake(self.minusBtn.right, 11.5,self.width-2*btnW, kHeight + 10);
    self.goodNumtf.centerY = kHeight/2.0;
    self.addBtn.frame      = CGRectMake(self.goodNumtf.right,0, btnW,kHeight + 10);
    self.addBtn.centerY    = kHeight/2.0;
    
}

#pragma  mark public method
-(void)quantityViewEnable:(BOOL)isEnable addBtnEnable:(BOOL)addBtnEnable
{
    addBtnEnable       = isEnable?addBtnEnable:isEnable;
    self.addBtnEnable  = addBtnEnable;
    _minusBtn.enabled  = isEnable;
    _goodNumtf.enabled = isEnable;
    
    UIColor *color     = UIColorFromRGB(0x333333);
    [_goodNumtf setTextColor:color];
}

-(void)updateQuantityViewCount:(NSInteger)count
{
    self.goodNumtf.text = [NSString stringWithFormat:@"%zd",count];
}
-(NSInteger)quantityViewCount
{
    return [self.goodNumtf.text integerValue];
}
#pragma mark textfiled的代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.quantityViewBeginEditBlock) {
        self.quantityViewBeginEditBlock(textField);
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self finishBtn];
}

- (void)alterViewClickedCancleButton:(AlterView *)alterView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:CART_SHOP_TALBEVIEWTOTOP
                                                       object:nil
                                                     userInfo:nil];
    
}

-(void)addInputAccessoryViewToContentText
{
    CGFloat inputViewH                  = 50;
    CGFloat btnH                        = 34;
    UIView *inputView                   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, inputViewH)];
    UIButton *btn                       = [[UIButton alloc]initWithFrame:CGRectMake(0, (inputViewH - btnH)/2.0, 61, 34)];
    [btn setContentMode:UIViewContentModeLeft];
    btn.right                           = ScreenWidth - 10;
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    btn.titleLabel.font                 = KFontNormal(16);
    btn.layer.borderColor               = UIColorFromRGB(0x333333).CGColor;
    btn.layer.borderWidth               = OnePoint;
    btn.layer.cornerRadius              = 4.0;
    [btn addTarget:self action:@selector(finishBtn) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:btn];
    
    [inputView setBackgroundColor:UIColorFromRGB(0xfafafa)];
    self.goodNumtf.inputAccessoryView = inputView;
}

-(void)finishBtn
{
    [self.goodNumtf resignFirstResponder];
    self.lastQuantity =  [self.goodNumtf.text integerValue];
    NSInteger count = [self.goodNumtf.text integerValue];
    if (count == 0) {
        [PRShowToastUtil showNotice:@"亲，商品数量不可设为0"];
        count = self.lastQuantity;
    }else if (self.tempModel.product.stocknum && count > self.tempModel.product.stocknum){
        AlterView *view = [[AlterView alloc]initWithcancelBtnTitle:@"我知道了"
                                                    commitBtnTitle:nil
                                                           message:[NSString stringWithFormat:@"商品库存不足,小辉已为您修改至最大库存数量%zd件",self.tempModel.product.stocknum]
                                                          delegate:self];
        [view show];
        count = self.tempModel.product.stocknum;
        
    }
    if (self.quantityViewEditBlock) {
        self.quantityViewEditBlock(count);
    }
    
}


-(void)addBtnOnClick
{
    if ([self.goodNumtf.text integerValue] >= self.tempModel.product.stocknum) {
        [PRShowToastUtil showNotice:[NSString stringWithFormat:@"库存只有%zd件，不能再加啦~",self.tempModel.product.stocknum]];
        return;
    }
    self.lastQuantity = [self.goodNumtf.text integerValue];
    NSInteger count = [self.goodNumtf.text integerValue] + 1;
    if (self.quantityViewEditBlock) {
        self.quantityViewEditBlock(count);
    }
}

-(void)minusBtnOnClick
{
    NSInteger count = self.goodNumtf.text.integerValue;
    if (self.tempModel.product.stocknum && count > self.tempModel.product.stocknum) {
        count = self.tempModel.product.stocknum;
    }else{
        count --;
    }
    if (self.quantityViewEditBlock) {
        self.quantityViewEditBlock(count);
    }
}

@end
