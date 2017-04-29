//
//  AppUIUtil.m
//  PR
//
//  Created by 黄小雪 on 05/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "AppUIUtil.h"
#import <objc/runtime.h>


#define OnePoint                (1/[UIScreen mainScreen].scale) //广义的点

NSString * biLabelKey = @"__label";

#pragma mark  - size scale
CGFloat nativeScale() {
    static CGFloat scale = 0.0f;
    if (scale == 0.0f) {
        CGFloat width = APPLICATIONWIDTH;
        scale = width / 320.0f;
    }
    return scale * 2;
}

// 基于4.5寸屏幕下的适配
CGFloat FFNativeScale(){
    static CGFloat scale = 0.0f;
    if (scale == 0.0f) {
        CGFloat width = APPLICATIONWIDTH;
        scale = width / 375.0f;
    }
    return scale * 2;
}

// 基于5.5寸屏幕的分辨率适配
CGFloat XNativeScale(){
    static CGFloat scale = 0.0f;
    if (scale == 0.0f) {
        CGFloat width = APPLICATIONWIDTH;
        scale = width / 414.0f;
    }
    return scale * 2;
}

#pragma mark  - DEFAULT VIEW
UIView * EADefaultViewForClass(Class X)
{
    // 首先判断资源是否存在，不存在，直接构建
    if (nil == [[NSBundle mainBundle] URLForResource:NSStringFromClass(X) withExtension:@"nib"])
    {
        return [[X alloc] init];
    }
    
    @try {
        NSArray * allViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(X) owner:nil options:nil];
        for (UIView * aView in allViews)
        {
            if ([aView isKindOfClass:X]) {
                return aView;
            }
        }
    }
    @catch (NSException *exception)
    {
//        YHLogVerbose(@"%@",exception);
    }
    @finally {
        
    }
    
    
    return nil;
}



void EARemoveAllSubview(UIView * view)
{
    for (NSInteger itemId = ([view.subviews count] - 1); itemId >= 0 ; itemId--)
    {
        [[[view subviews] objectAtIndex:itemId] removeFromSuperview];
    }
}

#pragma mark  - find subview
@implementation UIView(noRecursiveSearch)

- (UIView *)findASubViewWithTag:(NSInteger)tag
{
    NSArray * subViews = [self subviews];
    for (UIView * aView in subViews)
    {
        if (aView.tag == tag)
        {
            return aView;
        }
    }
    return nil;
}

@end


#pragma mark  - custom bar button
@implementation UIBarButtonItem(yhapp)

+(instancetype)backStyleItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"topbar_back.png"] forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:@"topbar_back_hover.png"] forState:UIControlStateHighlighted];
    [btn setFrame:CGRectMake(0, 0, 48, 44)];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

@end


#pragma mark - string size calc
@implementation  NSString(yhsizecalc)

+ (CGSize)text:(NSString*)text sizeWithFont:(UIFont*)font
{
    if (!font || text.length <= 0) {
        return CGSizeZero;
    }
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

+ (NSString *)stringPriceDescWithFen:(long)priceNum
{
    long fenNum = priceNum % 100;
    long yuanNum = priceNum / 100;
    
    NSString * fenStr = [NSString stringWithFormat:@"%02ld",fenNum];
    NSString * yuanStr = [NSString stringWithFormat:@"%ld",yuanNum];
    
    return [NSString stringWithFormat:@"￥%@.%@",yuanStr,fenStr];
#if 0
    // 千位符处理
    NSString * priceStr = fenStr;
    priceStr = [@"." stringByAppendingString:priceStr];
    
    while ([yuanStr length] > 0) {
        if ([yuanStr length] > 3) {
            NSString * subYuan = [yuanStr substringFromIndex:[yuanStr length] - 3];
            priceStr = [[NSString stringWithFormat:@",%@",subYuan] stringByAppendingString:priceStr];
            yuanStr = [yuanStr substringToIndex:[yuanStr length] - 3];
        }else{
            priceStr = [yuanStr stringByAppendingString:priceStr];
            break;
        }
    }
    
    return [@"￥" stringByAppendingString:priceStr];
#endif
    
}
@end


#pragma mark - 按钮点击区域扩展
@implementation UIButton(touchExpand)
- (void)expandTouchArea:(UIEdgeInsets)appendArea
{
    UIEdgeInsets  titleEdge = self.titleEdgeInsets;
    UIEdgeInsets  imgEdge   = self.imageEdgeInsets;
    
    BOOL haveTitle          = [[self titleForState:UIControlStateNormal] length] > 0 ? YES : NO;
    BOOL haveImg            = [self imageForState:UIControlStateNormal] != nil ? YES : NO;
    
    // adjust frame
    CGRect  myFrame         = self.frame;
    myFrame.origin.x        -=  appendArea.left;
    myFrame.origin.y        -=  appendArea.top;
    myFrame.size.width      +=  (appendArea.left + appendArea.right);
    myFrame.size.height     +=  (appendArea.top  + appendArea.bottom);
    self.frame              =   myFrame;
    
    // adjust content
    CGFloat horiOffset  = appendArea.left - appendArea.right;
    CGFloat vertOffset  = appendArea.top - appendArea.bottom;
    if (haveImg == YES && haveTitle == NO) {
        UIEdgeInsets newImgEdge = imgEdge;
        if (horiOffset > 0) {
            newImgEdge.left += horiOffset;
        }else if (horiOffset < 0){
            newImgEdge.right += horiOffset * -1;
        }
        
        if (vertOffset > 0) {
            newImgEdge.top += vertOffset;
        }else if(vertOffset < 0){
            newImgEdge.bottom += vertOffset * -1;
        }
        self.imageEdgeInsets = newImgEdge;
    }else if (haveTitle == YES && haveImg == NO)
    {
        UIEdgeInsets newTitleEdge = titleEdge;
        if (horiOffset > 0) {
            newTitleEdge.left += horiOffset;
        }else if (horiOffset < 0){
            newTitleEdge.right += horiOffset * -1;
        }
        
        if (vertOffset > 0) {
            newTitleEdge.top += vertOffset;
        }else if(vertOffset < 0){
            newTitleEdge.bottom += vertOffset * -1;
        }
        self.titleEdgeInsets = newTitleEdge;
    }else{
        NSAssert(NO, @"同时混合image & title的情况需要去验证，因此这里先不做处理，碰到的时候请参考上面的逻辑执行调整验证");
    }
}
@end

#pragma mark - font adjust
static NSString * yhFontName = @"PingFangSC-Regular";
static NSString * yhBoltFontName = @"PingFangSC-Medium";
@implementation UILabel(yhfont)
+ (void)load
{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(YHInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)YHInitWithCoder:(NSCoder*)aDecode
{
    [self YHInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.font.pointSize;
        self.font = [UIFont systemFontOfSize:fontSize];
    }
    return self;
}
@end

@implementation UIButton(yhfont)
+ (void)load
{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(YHInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)YHInitWithCoder:(NSCoder*)aDecode
{
    [self YHInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.titleLabel.font.pointSize;
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    return self;
}
@end

@implementation UITextField(yhfont)
+ (void)load
{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(YHInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)YHInitWithCoder:(NSCoder*)aDecode
{
    [self YHInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.font.pointSize;
        self.font = [UIFont systemFontOfSize:fontSize];
    }
    return self;
}
@end

@implementation UIFont (yhfont)
+ (void)load
{
    //    for(NSString *fontfamilyname in [UIFont familyNames])
    //    {
    //        NSLog(@"family:'%@'",fontfamilyname);
    //        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
    //        {
    //            NSLog(@"\tfont:'%@'",fontName);
    //        }
    //        NSLog(@"-------------");
    //    }
    
    
    Class metaClass = objc_getMetaClass(object_getClassName(self));
    
    Method fontMethod = class_getClassMethod(metaClass, @selector(YHFontOfSize:));
    Method ORIGFontMetgid = class_getClassMethod(metaClass, @selector(systemFontOfSize:));
    method_exchangeImplementations(fontMethod, ORIGFontMetgid);
    
    Method boldMethod = class_getClassMethod(metaClass, @selector(boldYHFontOfSize:));
    Method ORIGboldMethod = class_getClassMethod(metaClass, @selector(boldSystemFontOfSize:));
    method_exchangeImplementations(boldMethod, ORIGboldMethod);
}

+ (UIFont *)YHFontOfSize:(CGFloat)size
{
    if (iOS9) {
        return [UIFont fontWithName:yhFontName size:size];
    }else{
        return [UIFont YHFontOfSize:size];
    }
}

+ (UIFont *) boldYHFontOfSize:(CGFloat)size
{
    if (iOS9) {
        return [UIFont fontWithName:yhBoltFontName size:size];
    }else{
        return [UIFont boldYHFontOfSize:size];
    }
}
@end
