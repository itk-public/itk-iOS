//
//  AlterView.m
//  YHClouds
//
//  Created by 黄小雪 on 16/4/22.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "AlterView.h"
#import "OnePixelSepView.h"
#import "SceneMananger.h"
#import "NSString+Category.h"


static UIView *hudView = nil;


#define  kTitleFontSize     14.0
#define  kMessagefontSize   16.0
#define  kSamllMessageFontSzie  13.0
#define  kRemarkFontSize    13.0
#define  kAlertContentMaxWidth  290 * DDDisplayScale


#define  kLayoutTitlePaddingTop             19
#define  kLayoutTitlePaddingBottom          15
#define  kLayoutMessagePaddingBottom        9
#define  kLayoutRemarkPaddingBottom         13
#define  kLayoutBtnHeight                   45
#define  kLayoutMessageMinPaddingTop        34
#define  kLayoutMessageMinPaddingBottom     29
#define  kLayoutTextHoriPadding             15


#define  kBaseTag  1000
#define  kTagCancelBtn      kBaseTag
#define  kTagCommitBtn      kBaseTag + 1
#define  kTagRemarkLabel    kBaseTag + 100
#define  kTagMessageLabel   kBaseTag + 101
#define  kTagTitleLabel     kBaseTag + 102
#define  kTagInfoSepView    kBaseTag + 200
#define  kTagBtnSepView     kBaseTag + 201
#define  kTagBgImageView    kBaseTag + 202

typedef  NS_ENUM(NSInteger,BtnTagType)
{
    BtnTagTypeCancel  = kBaseTag,
    BtnTagTypeCommit  = kBaseTag + 1,
};

@interface AlterView()
@property (weak,nonatomic) id<AlterViewDelegate>  delegate;
@property (assign,nonatomic) CGFloat              forceFontSize;
@end

@implementation AlterView

-(instancetype)initWithcancelBtnTitle:(NSString *)cancelBtnTitle
                       commitBtnTitle:(NSString *)commitBtnTitle
                              message:(NSString *)message
                             delegate:(id)delegate
{
    if (self = [super initWithFrame:CGRectMake(0, 0, kAlertContentMaxWidth, 50)])
    {
        _cancelTitle = cancelBtnTitle;
        _commitTitle = commitBtnTitle;
        _message     = message;
        _delegate    = delegate;
    }
    return self;
}



- (UIImage*)colorImageWithCornerRadius:(CGFloat)radius{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 4 * radius, 4 * radius);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //根据矩形画带圆角的曲线
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius) resizingMode:UIImageResizingModeTile];
    return image;
}


- (void)configTitle
{
    CONDITION_CHECK_RETURN([self.title length]);
    UILabel * titleLable = (UILabel *)[self findASubViewWithTag:kTagTitleLabel];
    if (titleLable == nil) {
        // 多添加2个pt，是由于字体高度是大于相同pt值的，防止有些文字显示不出来，特意添加2个pt高度。layout调整时会保持中心点不变的。
        titleLable                         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kAlertContentMaxWidth, kTitleFontSize + 2)];
        titleLable.font                    = KFontNormal(kTitleFontSize);
        titleLable.textColor               = UIColorFromRGB(0x666666);
        titleLable.textAlignment           = NSTextAlignmentCenter;
        titleLable.backgroundColor         = [UIColor clearColor];
        titleLable.tag                     = kTagTitleLabel;
        [self addSubview:titleLable];
    }
    
    titleLable.text = self.title;
}

- (void)configMessage
{
    CONDITION_CHECK_RETURN([self.message length]);
    
    UILabel * messageLab = (UILabel *)[self findASubViewWithTag:kTagMessageLabel];
    CGFloat  msgFontSize = kMessagefontSize;
    if ([self.title length]) {
        msgFontSize = kSamllMessageFontSzie;
    }else{
        if (self.forceFontSize > 0) {
            msgFontSize = self.forceFontSize;
        }
    }
    
    if (messageLab == nil) {
        messageLab                         = [[UILabel alloc]initWithFrame:CGRectMake(kLayoutTextHoriPadding,
                                                                                      0,
                                                                                      kAlertContentMaxWidth - 2 * kLayoutTextHoriPadding,
                                                                                      1)];
        messageLab.font                    = KFontNormal(msgFontSize);
        messageLab.textColor               = UIColorFromRGB(0x333333);
        messageLab.preferredMaxLayoutWidth = messageLab.width;
        messageLab.numberOfLines           = 3;
        messageLab.textAlignment           = NSTextAlignmentCenter;
        messageLab.backgroundColor         = [UIColor clearColor];
        messageLab.tag                     = kTagMessageLabel;
        [self addSubview:messageLab];
    }
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode             = NSLineBreakByCharWrapping;
    
    if ([self.title length]) {
        paragraphStyle.alignment           = NSTextAlignmentLeft;
        paragraphStyle.lineSpacing         = 0;//调整行间距
    }else{
        paragraphStyle.alignment           = NSTextAlignmentCenter;
        paragraphStyle.lineSpacing         = 15;//调整行间距
    }
    
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:self.message?:@""];
    [attributeStr addAttribute:NSParagraphStyleAttributeName
                         value:paragraphStyle
                         range:NSMakeRange(0, [attributeStr.string length])];
    messageLab.attributedText  = attributeStr;
    
    // 调整高度
    CGSize  msgSize = [messageLab sizeThatFits:CGSizeMake(messageLab.width, MAXFLOAT)];
    messageLab.frame = CGRectMake(messageLab.left, 0, messageLab.width, msgSize.height);
}

- (void)configRemark
{
    CONDITION_CHECK_RETURN([self.remarkStr length]);
    UILabel * rkLabel = (UILabel *)[self findASubViewWithTag:kTagRemarkLabel];
    if (nil == rkLabel) {
        // 多添加2个pt，是由于字体高度是大于相同pt值的，防止有些文字显示不出来，特意添加2个pt高度。layout调整时会保持中心点不变的。
        rkLabel                         = [[UILabel alloc]initWithFrame:CGRectMake(kLayoutTextHoriPadding,
                                                                                   0,
                                                                                   kAlertContentMaxWidth - 2 * kLayoutTextHoriPadding,
                                                                                   kRemarkFontSize + 2)];
        rkLabel.font                    = KFontNormal(kRemarkFontSize);
        rkLabel.textColor               = UIColorFromRGB(0x666666);
        rkLabel.textAlignment           = NSTextAlignmentLeft;
        rkLabel.backgroundColor         = [UIColor clearColor];
        rkLabel.tag                     = kTagRemarkLabel;
        [self addSubview:rkLabel];
    }
    rkLabel.text                    = self.remarkStr;
}

- (void)configCancelBtn
{
    CONDITION_CHECK_RETURN([self.cancelTitle length]);
    
    CGFloat btnFontSize = 15;
    if (self.forceFontSize > 0) {
        btnFontSize = self.forceFontSize;
    }
    UIButton * cancelBtn = (UIButton *)[self findASubViewWithTag:kTagCancelBtn];
    if (cancelBtn == nil) {
        cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelBtn.titleLabel.font = KFontNormal(btnFontSize);
        cancelBtn.backgroundColor = [UIColor clearColor];
        cancelBtn.tag             = kTagCancelBtn;
        [cancelBtn addTarget:self
                      action:@selector(btnOnClicked:)
            forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.frame = CGRectMake(0, self.height - kLayoutBtnHeight, kAlertContentMaxWidth, kLayoutBtnHeight);
        cancelBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:cancelBtn];
    }
    
    [cancelBtn setTitleColor:[self.commitTitle length] ? UIColorFromRGB(0x666666) : UIColorFromRGB(0xfd7622)
                    forState:UIControlStateNormal];
    [cancelBtn setTitle:self.cancelTitle
               forState:UIControlStateNormal];
}

- (void)configCommitBtn
{
    CONDITION_CHECK_RETURN([self.commitTitle length]);
    
    CGFloat btnFontSize = 15;
    if (self.forceFontSize > 0) {
        btnFontSize = self.forceFontSize;
    }
    UIButton * commitBtn       = (UIButton *)[self findASubViewWithTag:kTagCommitBtn];
    if (commitBtn == nil) {
        commitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        commitBtn.titleLabel.font = KFontNormal(btnFontSize);
        commitBtn.backgroundColor = [UIColor clearColor];
        commitBtn.tag             = kTagCommitBtn;
        [commitBtn addTarget:self
                      action:@selector(btnOnClicked:)
            forControlEvents:UIControlEventTouchUpInside];
    
        [commitBtn setTitleColor:UIColorFromRGB(0xfd7622)
                        forState:UIControlStateNormal];
        commitBtn.frame = CGRectMake(0, self.height - kLayoutBtnHeight, kAlertContentMaxWidth, kLayoutBtnHeight);
        commitBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:commitBtn];
    }
    
    [commitBtn  setTitle:self.commitTitle forState:UIControlStateNormal];
}

- (void)configSepView
{
    if ([self.title length] || [self.message length]) {
        OnePixelSepView *line = (OnePixelSepView *)[self findASubViewWithTag:kTagInfoSepView];
        if (line == nil) {
            line                  = [[OnePixelSepView alloc]    initWithFrame:CGRectMake(0, self.height - kLayoutBtnHeight, kAlertContentMaxWidth, OnePoint)];
            line.lineColor        = UIColorFromRGB(0xf1f6f9);
            line.tag              = kTagInfoSepView;
            line.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            [self addSubview:line];
        }
    }
    
    OnePixelSepView * btnSepView = (OnePixelSepView *)[self findASubViewWithTag:kTagBtnSepView];
    if ([self.cancelTitle length] && [self.commitTitle length]) {
        if (btnSepView == nil) {
            btnSepView            = [[OnePixelSepView alloc]    initWithFrame:CGRectMake(kAlertContentMaxWidth / 2.0,
                                                                                         self.height - kLayoutBtnHeight,
                                                                                         OnePoint,
                                                                                         kLayoutBtnHeight)];
            btnSepView.lineColor  = UIColorFromRGB(0xf1f6f9);
            btnSepView.tag        = kTagBtnSepView;
            btnSepView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            [self addSubview:btnSepView];
        }
    }else{
        [btnSepView removeFromSuperview];
    }
}

- (void)configBackgroundImage
{
    UIImageView * bgView = (UIImageView *)[self findASubViewWithTag:kTagBgImageView];
    if (nil == bgView) {
        bgView = [[UIImageView alloc] initWithImage:[self colorImageWithCornerRadius:4]];
        bgView.tag = kTagBgImageView;
        bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        bgView.frame = self.bounds;
        [self insertSubview:bgView atIndex:0];
    }
}


- (void)configContainerView
{
    if (hudView == nil) {
        UIView *background  = [[UIView alloc] initWithFrame:CGRectZero];
        [background setFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)];
        [background setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.78]];
        hudView = background;
    }
}


- (CGFloat)calcViewHeight
{
    CGFloat myHeight = 0;
    if ([self.title length]) {
        myHeight +=  kLayoutTitlePaddingTop;    // title上方的高度
        myHeight +=  kTitleFontSize; // title高度
        myHeight +=  kLayoutTitlePaddingBottom;    // title 下方间距
    }else{
        myHeight += kLayoutMessageMinPaddingTop;
    }
    
    if ([self.message length]) {
        UIView * messageLabel = [self findASubViewWithTag:kTagMessageLabel];
        myHeight +=  messageLabel.height; //  message 高度
        if ([self.remarkStr length]) {
            myHeight += kLayoutMessagePaddingBottom;
            myHeight += kRemarkFontSize;
            myHeight += kLayoutRemarkPaddingBottom;
        }else{
            if ([self.title length]) {
                myHeight += kLayoutTitlePaddingBottom; // 有title的话，msg距离下方的高度与 title下边距保持一致
            }else{
                myHeight +=  kLayoutMessageMinPaddingBottom;
            }
        }
    }
    
    if (self.cancelTitle.length || self.commitTitle.length) {
        myHeight += kLayoutBtnHeight;
    }
    
    return myHeight;
}


- (void)constructShowView
{
    [self configTitle];
    [self configMessage];
    [self configRemark];
    [self configCommitBtn];
    [self configCancelBtn];
    [self configSepView];
    [self configContainerView];
    
    CGFloat viewHeight = [self calcViewHeight];
    self.height = viewHeight;
    
    [self configBackgroundImage];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
   
    CGFloat topPos = 0;
    if (self.title) {
        topPos =  kLayoutTitlePaddingTop;
        UILabel * titleLabel  = (UILabel *)[self findASubViewWithTag:kTagTitleLabel];
        titleLabel.centerY = (topPos + kTitleFontSize / 2);
        topPos += (kTitleFontSize + kLayoutTitlePaddingBottom);
    }else{
        topPos =  kLayoutMessageMinPaddingTop;
    }
    
    UILabel * messageLabel  = (UILabel *)[self findASubViewWithTag:kTagMessageLabel];
    messageLabel.top = topPos;
    topPos += messageLabel.height;
    
    UILabel * remarkLablel = (UILabel *)[self findASubViewWithTag:kTagRemarkLabel];
    if (remarkLablel) {
        topPos += kLayoutMessagePaddingBottom;
        remarkLablel.centerY = topPos + (kRemarkFontSize / 2);
    }
    
    UIView * cancelBtn = [self findASubViewWithTag:kTagCancelBtn];
    UIView * commitBtn = [self findASubViewWithTag:kTagCommitBtn];
    if (cancelBtn && commitBtn) {
        CGFloat halfWidth = kAlertContentMaxWidth / 2.0;
        cancelBtn.width = halfWidth;
        commitBtn.left  = halfWidth;
        commitBtn.width = halfWidth;
    }else if (cancelBtn){
        cancelBtn.width = kAlertContentMaxWidth;
    }else{
        commitBtn.left  = 0;
        commitBtn.width = kAlertContentMaxWidth;
    }
}


- (void)show {
    CONDITION_CHECK_RETURN([self.message length] > 0 && ([self.cancelTitle length] || [self.commitTitle length]));
    
    EARemoveAllSubview(hudView);
    [self constructShowView];
    
    UIWindow * window    = [[[UIApplication sharedApplication] delegate] window];
    [self setCenter:CGPointMake(hudView.bounds.size.width / 2, hudView.bounds.size.height / 2)];
    [hudView addSubview:self];
    [window addSubview:hudView];
}



-(void)btnOnClicked:(UIButton *)btn{
    [self disappear];
    if (btn.tag == BtnTagTypeCommit){
        if (self.delegate && [self.delegate respondsToSelector:@selector(alterViewClickedCommitButton:)]) {
            [self.delegate alterViewClickedCommitButton:self];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(alterViewClickedCancleButton:)]) {
            [self.delegate alterViewClickedCancleButton:self];
        }
    }
}


-(void)disappear{
    [hudView removeFromSuperview];
}

-(void)setFontSize:(CGFloat)fontSize
{
    if (iPhone4 || iPhone5) {
        self.forceFontSize = fontSize;
    }
}
@end
