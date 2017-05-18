//
//  DetailView.m
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "DetailAddressView.h"
#import "OnePixelSepView.h"

@interface DetailAddressView()<UITextViewDelegate>
@property (strong,nonatomic) UILabel    *placeholder;
@property (strong,nonatomic) UITextView *textView;
@property (copy, nonatomic ) NSString   *lastContent;

@end

@implementation DetailAddressView



-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMargin = 15;
    CGFloat countLabelH = 15;
    CGFloat countLabelW = 150;
    
    CGFloat contentViewW = self.width - 2*leftMargin;
//    CGFloat contentViewH = self.countLabel.top - 10 - 5;
    self.textView.frame = CGRectMake(leftMargin, 10, contentViewW, self.height);
    self.placeholder.frame = CGRectMake(0, 0, self.width - 2*leftMargin, 25);
}

//-(void)setFeedBackModel:(FeedBackViewModel *)feedBackModel
//{
//    CONDITION_CHECK_RETURN([feedBackModel isKindOfClass:[FeedBackViewModel class]]);
//    _feedBackModel = feedBackModel;
//    self.textView.text = feedBackModel.feedBackContent;
//    self.countLabel.text = [NSString stringWithFormat:@"%zd/600",[self.textView.text length]];
//}


//-(void)addContainerView
//{
//    _containerView = [[UIView alloc]init];
//    [_containerView setBackgroundColor:[UIColor whiteColor]];
//    [self addSubview:_containerView];
//}
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
    _placeholder.textColor     = UIColorFromRGB(0x030303);
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

//点击完成
-(void)finishBtn
{
    [self.textView resignFirstResponder];
    if (self.textView.text.length == 0) {
        [self.textView addSubview:self.placeholder];
    }else{
        [self.placeholder removeFromSuperview];
    }

}

-(NSString *)feedBackContentString;
{
    return [self.textView text];
}

#pragma mark textView deletegate
- (void)textViewDidBeginEditing:(UITextView *)textView;
{
//    [self.placeholder removeFromSuperview];
//    //    if (iPhone4 || iPhone5) {
//    __weak typeof(self)weakSelf = self;
//    UIView *currentView = [[SceneMananger shareMananger]topViewController].view;
//    [UIView animateWithDuration:0.25 animations:^{
////        if ([weakSelf.feedBackModel showAllTypeView]) {
////            [currentView  setTop:- 50 - [FeedBackTypeViewCell getHeight:self.feedBackModel]];
//        }else if (iPhone5 || iPhone4){
////            [currentView  setTop:- 50];
//        }
//        
//    }];
    //    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self finishBtn];
}

- (void)textViewDidChange:(UITextView *)textView
{
//    if (textView.text.length > kMaxLenght) {
//        textView.text = self.lastContent;
//       
//    }else{
//        self.lastContent = textView.text;
//        NSString *content =   [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
////        self.countLabel.text = [NSString stringWithFormat:@"%zd/%zd",content.length,kMaxLenght];
//    }
    
    if (textView.text.length == 0) {
        [textView addSubview:self.placeholder];
    }else{
        [self.placeholder removeFromSuperview];
    }
}

-(instancetype)init{
    if (self = [super init]) {
//        [self addContainerView];
        [self addTextView];
        [self addPlaceholder];
        [self setPixelSepSet:PSRectEdgeTop];
        [self addInputAccessoryViewToContentText];
    }
    return self;
}
@end
