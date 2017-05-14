//
//  FruitJumLoadingView.m
//  PR
//
//  Created by 黄小雪 on 09/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "FruitJumLoadingView.h"

#define MULTIPLE 0.9

#define MARGIN              5.0f

#define VIEW_WIDTH  (215.0f*XXDisplayScale*MULTIPLE)
#define VIEW_HEIGHT (90.0f*XXDisplayScale*MULTIPLE)

#define IMAGE_WIDTH (35.0f*XXDisplayScale*MULTIPLE)

#define TIMEOFFSET_DELTA    0.2f
#define SPEED_DELTA         1.2f
#define PRE_TIME            0.1f

#define DARK_BACKGROUD_DETAL_HEIGHT (45.0f*XXDisplayScale*MULTIPLE)

@interface FruitJumLoadingView()

@property (strong,nonatomic) UIView  *bgView;
@property (strong,nonatomic) UILabel *tipLabel;
@property (assign,nonatomic) BOOL     inAnimation;

@end

@implementation FruitJumLoadingView
-(instancetype)initWithFrame:(CGRect)frame{
    CGRect rRect = CGRectMake((APPLICATIONWIDTH - VIEW_WIDTH - 2 * MARGIN)/2.0, (frame.size.height - (VIEW_HEIGHT+DARK_BACKGROUD_DETAL_HEIGHT+10*XXDisplayScale))/2.0, VIEW_WIDTH + MARGIN * 2, VIEW_HEIGHT + MARGIN);
    if(self = [super initWithFrame:rRect]){
        self.backgroundColor            = [UIColor clearColor];
        self.bgView                     = [[UIView alloc]initWithFrame:CGRectMake(0, -5*XXDisplayScale, self.width, self.height + DARK_BACKGROUD_DETAL_HEIGHT)];
        self.bgView.backgroundColor     = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        self.bgView.layer.cornerRadius  = 6;
        self.bgView.layer.shadowRadius  = 5;
        self.bgView.layer.shadowColor   = UIColorFromRGB(0xbbbbbb).CGColor;
        self.bgView.layer.shadowOpacity = 0.3;
        self.bgView.layer.shadowOffset  = CGSizeMake(0, 0);
        [self addSubview:self.bgView];
        UILabel * textLabel             = [[UILabel alloc] initWithFrame:CGRectMake(0, 100*XXDisplayScale*MULTIPLE, self.width, 16)];
        textLabel.backgroundColor       = [UIColor clearColor];
        textLabel.font                  = KFontNormal(13);
        textLabel.textColor             = UIColorFromRGB(0x666666);
        textLabel.textAlignment         = NSTextAlignmentCenter;
        textLabel.text                  = @"小辉辉努力加载ing";
        self.tipLabel                   = textLabel;
        [self addSubview:self.tipLabel];

    }
    return self;
}


- (void)startLoading
{
    if (self.inAnimation) {
        return;
    }
    self.inAnimation = YES;
    [self doStarAnimation];
}

- (void)startLoadingWithTips:(NSString *)tips
{
    if (tips.length > 0) {
        self.tipLabel.text = tips;
    }
    [self startLoading];
}

- (void)changeTips:(NSString *)tipsInfo
{
    if (tipsInfo.length > 0) {
        self.tipLabel.text = tipsInfo;
    }
}

- (void)stopLoading
{
    if (NO == self.inAnimation) {
        return;
    }
    self.inAnimation = NO;
    [self doStopAnimation];
}

- (BOOL)isInAnimation
{
    return self.inAnimation;
}

- (void)doStarAnimation
{
    //    [self performSelector:@selector(startFirst) withObject:NULL afterDelay:0];
    [self performSelectorOnMainThread:@selector(startFirst) withObject:NULL waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
    //    [self performSelector:@selector(startSecond) withObject:NULL afterDelay:0];
    [self performSelectorOnMainThread:@selector(startSecond) withObject:NULL waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
    //    [self performSelector:@selector(startThird) withObject:NULL afterDelay:0];
    [self performSelectorOnMainThread:@selector(startThird) withObject:NULL waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
}

- (void)doStopAnimation
{
    for (UIView *tV in self.subviews) {
        if ([tV isKindOfClass:[UIImageView class]]) {
            [tV.layer removeAllAnimations];
        }
    }
}

- (void)startFirst
{
    UIImageView * tomatoIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tomato.png"]];
    tomatoIV.frame = CGRectMake(MARGIN, VIEW_HEIGHT - 40*XXDisplayScale*MULTIPLE, IMAGE_WIDTH, 40*XXDisplayScale*MULTIPLE);
    tomatoIV.backgroundColor = [UIColor clearColor];
    [self startAnimationWithView:tomatoIV timeOffset:(1+PRE_TIME)-TIMEOFFSET_DELTA speedDelta:SPEED_DELTA];
}

- (void)startSecond
{
    UIImageView * lemonIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lemon.png"]];
    lemonIV.frame = CGRectMake(MARGIN, VIEW_HEIGHT - 45*XXDisplayScale*MULTIPLE, IMAGE_WIDTH, 40*XXDisplayScale*MULTIPLE);
    lemonIV.backgroundColor = [UIColor clearColor];
    [self startAnimationWithView:lemonIV timeOffset:(2+PRE_TIME) speedDelta:SPEED_DELTA];
}

- (void)startThird
{
    UIImageView * watermelonIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"watermelon.png"]];
    watermelonIV.frame = CGRectMake(MARGIN, VIEW_HEIGHT - 40*XXDisplayScale*MULTIPLE, IMAGE_WIDTH, 40*XXDisplayScale*MULTIPLE);
    watermelonIV.backgroundColor = [UIColor clearColor];
    [self startAnimationWithView:watermelonIV timeOffset:(3+PRE_TIME)+TIMEOFFSET_DELTA speedDelta:SPEED_DELTA];
}

- (void)startAnimationWithView:(UIView *)targetView timeOffset:(CFTimeInterval)timeOffset speedDelta:(CGFloat)sd
{
    CGFloat width = targetView.width;
    [self addSubview:targetView];
    
    CGFloat delta       = sd;
    CGFloat deltaHeight = 90*XXDisplayScale*MULTIPLE;
    CGFloat margin      = 10*XXDisplayScale*MULTIPLE;
    
    CGFloat preTime     = PRE_TIME/delta;
    
    CABasicAnimation *alphaAnimation0 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation0.duration          = preTime;
    //    alphaAnimation0.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    alphaAnimation0.fromValue         = @(0);
    alphaAnimation0.toValue           = @(1);
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(targetView.center.x, targetView.center.y + 45*XXDisplayScale*MULTIPLE)];
    [path addLineToPoint:targetView.center];
    CAKeyframeAnimation *animation0 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation0.duration             = preTime;
    animation0.path                 = path.CGPath;
    animation0.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:targetView.center];
    [path addQuadCurveToPoint:CGPointMake(targetView.center.x+width+margin, targetView.center.y + 0.2 * width) controlPoint:CGPointMake(targetView.center.x+(width+margin)/2.0, targetView.center.y - deltaHeight)];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.beginTime            = preTime;
    animation.duration             = 1/delta;
    animation.path                 = path.CGPath;
    animation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *rotationAnimation1    = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation1.beginTime            = preTime;
    rotationAnimation1.duration             = 1/delta;
    rotationAnimation1.fromValue            = @(0);
    rotationAnimation1.toValue              = @(M_PI);
    rotationAnimation1.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    CABasicAnimation *bombAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    bombAnimation.beginTime         = 0.7f/delta + preTime;
    bombAnimation.fromValue         = [NSNumber numberWithFloat:1.0f];
    bombAnimation.duration          = 0.3/delta;
    bombAnimation.toValue           = [NSNumber numberWithFloat:0.7];
    bombAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *bombAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    bombAnimation2.beginTime         = 1.0f/delta + preTime;
    bombAnimation2.fromValue         = [NSNumber numberWithFloat:0.7f];
    bombAnimation2.duration          = 0.2/delta;
    bombAnimation2.toValue           = [NSNumber numberWithFloat:1];
    bombAnimation2.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(targetView.center.x+width+margin, targetView.layer.position.y + 0.3*width/2.0 + 5)];
    [path addQuadCurveToPoint:CGPointMake(targetView.center.x+(width+margin)*2, targetView.center.y + 0.2 * width) controlPoint:CGPointMake(targetView.center.x+(width+margin)*1.5, targetView.center.y - deltaHeight)];
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation2.beginTime            = 1.0/delta + preTime;
    animation2.duration             = 1/delta;
    animation2.path                 = path.CGPath;
    animation2.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *rotationAnimation2    = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation2.beginTime            = 1.0/delta + preTime;
    rotationAnimation2.duration             = 1/delta;
    rotationAnimation2.fromValue            = @(M_PI);
    rotationAnimation2.toValue              = @(M_PI*2);
    rotationAnimation2.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *bombAnimation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    bombAnimation3.beginTime         = 1.7f/delta + preTime;
    bombAnimation3.fromValue         = [NSNumber numberWithFloat:1.0f];
    bombAnimation3.duration          = 0.3/delta;
    bombAnimation3.toValue           = [NSNumber numberWithFloat:0.6];
    bombAnimation3.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *bombAnimation4 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    bombAnimation4.beginTime         = 2.0f/delta + preTime;
    bombAnimation4.fromValue         = [NSNumber numberWithFloat:0.6f];
    bombAnimation4.duration          = 0.2/delta;
    bombAnimation4.toValue           = [NSNumber numberWithFloat:1];
    bombAnimation4.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(targetView.center.x+(width+margin)*2, targetView.layer.position.y + 0.3*width/2.0 + 5)];
    [path addQuadCurveToPoint:CGPointMake(targetView.center.x+(width+margin)*3, targetView.center.y + 0.2 * width) controlPoint:CGPointMake(targetView.center.x+(width+margin)*2.5, targetView.center.y - deltaHeight)];
    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation3.beginTime            = 2.0f/delta + preTime;
    animation3.duration             = 1/delta;
    animation3.path                 = path.CGPath;
    animation3.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *rotationAnimation3    = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation3.beginTime            = 2.0/delta + preTime;
    rotationAnimation3.duration             = 1/delta;
    rotationAnimation3.fromValue            = @(M_PI*2);
    rotationAnimation3.toValue              = @(M_PI*3);
    rotationAnimation3.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *bombAnimation5 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    bombAnimation5.beginTime         = 2.7f/delta + preTime;
    bombAnimation5.fromValue         = [NSNumber numberWithFloat:1.0f];
    bombAnimation5.duration          = 0.3/delta;
    bombAnimation5.toValue           = [NSNumber numberWithFloat:0.6];
    bombAnimation5.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *bombAnimation6 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    bombAnimation6.beginTime         = 3.0f/delta + preTime;
    bombAnimation6.fromValue         = [NSNumber numberWithFloat:0.6f];
    bombAnimation6.duration          = 0.2/delta;
    bombAnimation6.toValue           = [NSNumber numberWithFloat:1];
    bombAnimation6.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(targetView.center.x+(width+margin)*3, targetView.layer.position.y + 0.3*width/2.0 + 5)];
    [path addQuadCurveToPoint:CGPointMake(targetView.center.x+(width+margin)*4, targetView.center.y + 0.2 * width) controlPoint:CGPointMake(targetView.center.x+(width+margin)*3.5, targetView.center.y - deltaHeight)];
    CAKeyframeAnimation *animation4 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation4.beginTime            = 3.0f/delta + preTime;
    animation4.duration             = 1/delta;
    animation4.path                 = path.CGPath;
    animation4.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *rotationAnimation4    = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation4.beginTime            = 3.0/delta + preTime;
    rotationAnimation4.duration             = 1/delta;
    rotationAnimation4.fromValue            = @(M_PI*3);
    rotationAnimation4.toValue              = @(M_PI*4);
    rotationAnimation4.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(targetView.center.x+(width+margin)*4, targetView.layer.position.y + 0.3*width/2.0 + 5)];
    [path addLineToPoint:CGPointMake(targetView.center.x+(width+margin)*4, targetView.layer.position.y + 0.3*width/2.0 + 5 + 45*XXDisplayScale*MULTIPLE)];
    CAKeyframeAnimation *animation5 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation5.beginTime            = 4.0f/delta + preTime;
    animation5.duration             = 0.3/delta;
    animation5.path                 = path.CGPath;
    animation5.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *alphaAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation1.beginTime         = 4.0f/delta + preTime;
    alphaAnimation1.duration          = preTime;
    alphaAnimation1.fromValue         = @(1);
    alphaAnimation1.toValue           = @(0);
    alphaAnimation1.removedOnCompletion = NO;
    alphaAnimation1.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *groups   = [CAAnimationGroup animation];
    groups.animations          = @[alphaAnimation0, animation0, animation, rotationAnimation1, bombAnimation, bombAnimation2, animation2, rotationAnimation2, bombAnimation3, bombAnimation4, animation3, rotationAnimation3, bombAnimation5, bombAnimation6, animation4, rotationAnimation4, animation5, alphaAnimation1];
    groups.duration            = 4.2/delta + preTime;
    groups.removedOnCompletion = NO;
    groups.fillMode            = kCAFillModeForwards;
    groups.repeatCount         = 11111;
    groups.timeOffset          = timeOffset;
    [targetView.layer addAnimation:groups forKey:@"groups"];
}

@end
