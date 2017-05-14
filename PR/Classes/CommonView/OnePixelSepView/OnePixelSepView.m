//
//  OnePixelSepView.m
//  YHClouds
//
//  Created by biqiang.lai on 15/11/6.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "OnePixelSepView.h"

@interface OnePixelSepView ()
{
    UIColor *              m_lineColor;
    OnePixelSepPos         m_pos;//实线的位置
    CGFloat                m_margin;
}
@end

@implementation OnePixelSepView

@synthesize pos = m_pos;
@synthesize lineColor = m_lineColor;
@synthesize margin    = m_margin;

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        m_pos = OnePixelSepPosAuto;
        m_lineColor = kSepLineColor;
        self.isDottedLine = NO;
        m_margin          = 0.0;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        m_pos = OnePixelSepPosAuto;
        if (nil == m_lineColor) {
           m_lineColor = kSepLineColor;
        }
        self.isDottedLine = NO;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"lineColor"]) {
        m_lineColor = value;
    }else if ([key isEqualToString:@"pos"]){
        m_pos = [value intValue];
    }else if ([key isEqualToString:@"isDottedLine"]){
        self.isDottedLine = [value boolValue];
    }else if([key isEqualToString:@"margin"]){
        self.margin   =   [value floatValue];
    }else{
        [super setValue:value forKey:key];
    }
}

-(void)setPos:(OnePixelSepPos)pos
{
    if (pos != m_pos)
    {
        m_pos = pos;
        if (self.window != nil) {
            [self setNeedsDisplay];
        }
    }
}

-(void)setLineColor:(UIColor *)lineColor
{
    if (lineColor != m_lineColor) {
        m_lineColor = lineColor;
        if (self.window != nil) {
            [self setNeedsDisplay];
        }
    }
}

- (void)setIsDottedLine:(BOOL)isDottedLine
{
    _isDottedLine = isDottedLine;
    if (self.window != nil) {
        [self setNeedsDisplay];
    }
}

-(void)setMargin:(CGFloat)margin{
    if (margin != m_margin) {
        m_margin = margin;
        if (self.window != nil) {
            [self setNeedsDisplay];
        }
    }
}


- (void)drawRect:(CGRect)rect
{
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
    
    OnePixelSepPos thePos = m_pos;
    if (m_pos == OnePixelSepPosAuto)
    {
        if (self.bounds.size.width > self.bounds.size.height)
        {
            if (self.frame.origin.y == 0)
            {
                thePos = OnePixelSepPosUp;
            }else{
                thePos = OnePixelSepPosDown;
            }
        }else{
            if (self.frame.origin.x == 0)
            {
                thePos = OnePixelSepPosLeft;
            }else{
                thePos = OnePixelSepPosRight;
            }
        }
    }
    
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    const CGFloat *tmComponents = CGColorGetComponents([m_lineColor CGColor]);
    if (tmComponents) {
        CGContextSetStrokeColorSpace(c, CGColorGetColorSpace([m_lineColor CGColor]));
        CGContextSetStrokeColor(c, tmComponents);
    }else
    {
        CGFloat color[4] = {.5f, 0.5f, 0.5f, 1.0f};
        CGContextSetStrokeColor(c, color);
    }
    
    CGFloat lineWidth = SINGLE_LINE_WIDTH;
    CGContextSetLineWidth(c, lineWidth);
    CGContextBeginPath(c);
    if (self.isDottedLine) {
        CGFloat lengths[2] = { 1,1};
        CGContextSetLineDash(c, 0.5, lengths, 2);
    }
    
    switch (thePos)
    {
        case OnePixelSepPosLeft:
        {
            CGContextMoveToPoint(c,  0, self.margin);
            CGContextAddLineToPoint(c,  0, self.bounds.size.height);
            break;
        }
        case OnePixelSepPosUp:
        {
            CGContextMoveToPoint(c, self.margin, 0);
            CGContextAddLineToPoint(c, self.bounds.size.width, 0);
            break;
        }
        case OnePixelSepPosRight:
        {
            CGFloat rightPos = self.bounds.size.width;
            CGContextMoveToPoint(c, rightPos, self.margin);
            CGContextAddLineToPoint(c, rightPos, self.bounds.size.height);
            break;
        }
        case OnePixelSepPosDown:
        {
            CGFloat downPos = self.bounds.size.height;
            CGContextMoveToPoint(c, self.margin, downPos);
            CGContextAddLineToPoint(c, self.bounds.size.width, downPos);
            break;
        }
        default:
            break;
    }
    CGContextClosePath(c);
    CGContextStrokePath(c);
}

- (void)setFrame:(CGRect)frame
{
    if (iPhone4 && SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        if (frame.size.height == 0) {
            frame.size.height = OnePoint;
            if (m_pos == OnePixelSepPosDown) {
                frame.origin.y += OnePoint;
            }
        }else if (frame.size.width == 0){
            frame.size.width = OnePoint;
            if (m_pos == OnePixelSepPosRight) {
                frame.origin.x += OnePoint;
            }
        }
    }
    [super setFrame:frame];
}
@end




@implementation UIView(OnPixelSep)

static char * keyForInPixelSep = "keyForInPixelSep";
#define kSepViewBaseTag       70
- (PSRectEdge)pixelSepSet
{
    NSNumber * isinPixelSep = objc_getAssociatedObject(self, keyForInPixelSep);
    if (isinPixelSep == nil) {
        return PSRectEdgeNone;
    }
    return [isinPixelSep unsignedIntegerValue];
}

- (void)setPixelSepSet:(PSRectEdge)inSep
{
    if (inSep == [self pixelSepSet]) {
        return;
    }
    NSNumber * theSepValue = [NSNumber numberWithUnsignedInteger:inSep];
    objc_setAssociatedObject(self, keyForInPixelSep, theSepValue, OBJC_ASSOCIATION_RETAIN);
    [self adjustPixelSepDisplay];

}

- (void)setPixelSepSet:(PSRectEdge)inSep leftMargin:(CGFloat)leftMargin
{
    }
#pragma mark  - sep display control
- (OnePixelSepView *)searchSepViewWithTag:(NSInteger)sepTag
{
    UIView * theView = [self findASubViewWithTag:sepTag];
    if ([theView isKindOfClass:[OnePixelSepView class]]) {
        return (OnePixelSepView *)theView;
    }
    return nil;
}

- (OnePixelSepView *)setPixelSepWithFrame:(CGRect)frame andTag:(NSInteger)tag
{
    // NSAssert([self findASubViewWithTag:tag] == nil, @"发现已经存在Tag%ld的View,请确认不要和分割线view的tag冲突了。",(long)tag);
    if ([self findASubViewWithTag:tag]) {
        return nil;
    }
    
    OnePixelSepView * sepView = [[OnePixelSepView alloc] initWithFrame:frame];
    sepView.lineColor = kSepLineColor;
    sepView.tag = tag;
    [self addSubview:sepView];
    return sepView;
}

- (OnePixelSepView *)psTopSep
{
    return [self searchSepViewWithTag:kSepViewBaseTag];
}

- (OnePixelSepView *)psLeftSep
{
    return [self searchSepViewWithTag:kSepViewBaseTag + 1];
}

- (OnePixelSepView *)psRightSep
{
    return [self searchSepViewWithTag:kSepViewBaseTag + 2];
}

- (OnePixelSepView *)psBottomSep
{
    return [self searchSepViewWithTag:kSepViewBaseTag + 3];
}

- (void)createPSTopSep
{
    [self setPixelSepWithFrame:CGRectMake(0, 0, self.width, OnePoint) andTag:kSepViewBaseTag];
}

- (void)createPSLeftSep
{
    [self setPixelSepWithFrame:CGRectMake(0, 0, OnePoint, self.height) andTag:kSepViewBaseTag + 1];
}

- (void)createPSRightSep
{
    [self setPixelSepWithFrame:CGRectMake(self.width - OnePoint, 0, OnePoint, self.height) andTag:kSepViewBaseTag + 2];
}

- (void)createPSBottomSep
{
    [self setPixelSepWithFrame:CGRectMake(0, self.height - OnePoint, self.width, OnePoint) andTag:kSepViewBaseTag + 3];
}

- (void)adjustPixelSepDisplay
{
    PSRectEdge myEdgeSet = self.pixelSepSet;
    
    if (myEdgeSet & PSRectEdgeTop) {
        if (nil == self.psTopSep) {
            [self createPSTopSep];
            self.psTopSep.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
            [self addSubview:self.psTopSep];
        }
        self.psTopSep.hidden = NO;
    }else{
        self.psTopSep.hidden = YES;
    }
    
    
    if (myEdgeSet & PSRectEdgeLeft) {
        if (nil == self.psLeftSep) {
            [self createPSLeftSep];
            self.psLeftSep.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
            [self addSubview:self.psLeftSep];
        }
        self.psLeftSep.hidden = NO;
    }else{
        self.psLeftSep.hidden = YES;
    }
    
    if (myEdgeSet & PSRectEdgeBottom) {
        if (nil == self.psBottomSep) {
            [self createPSBottomSep];
            self.psBottomSep.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
            [self addSubview:self.psBottomSep];
        }
        self.psBottomSep.hidden = NO;
    }else{
        self.psBottomSep.hidden = YES;
    }
    
    if (myEdgeSet & PSRectEdgeRight) {
        if (nil == self.psRightSep) {
            [self createPSRightSep];
            self.psRightSep.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
            [self addSubview:self.psRightSep];
        }
        self.psRightSep.hidden = NO;
    }else{
        self.psRightSep.hidden = YES;
    }
    
}

@end