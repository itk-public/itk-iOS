//
//  SoyScoreView.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SoyScoreView.h"

#define     MARGIN      10
#define     STARWIDTH   20

#define     STARCOLOR   UIColorFromRGB(0xFDAF28)

@interface SoyScoreView ()

@property (nonatomic, strong) CALayer* layerProgress;

@property (nonatomic, strong) UIPanGestureRecognizer *panGes;
@property (nonatomic, strong) UITapGestureRecognizer *tapGes;


@end

@implementation SoyScoreView
-(instancetype)initWithFrame:(CGRect)frame setStarWidth:(NSInteger )width margin:(NSInteger)margin
{
    frame = CGRectMake(frame.origin.x, frame.origin.y, width * 5 + margin * 4, frame.size.height);
    self = [super initWithFrame:frame ];
    if (self) {
        
        _layerProgress          = [CALayer layer];
        [self.layer addSublayer:_layerProgress];
        _layerProgress.frame    = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height);
        _layerProgress.backgroundColor = STARCOLOR.CGColor;
        
        CALayer* layerBg        = [CALayer layer];
        [self.layer insertSublayer:layerBg below:_layerProgress];
        layerBg.frame           = self.bounds;
        
        CALayer* layerMask      = [CALayer layer];
        [self.layer addSublayer:layerMask];
        layerMask.frame         = self.bounds;
        
        
        CGFloat x = 0.0f;
        CGFloat y = (frame.size.height - width) / 2;
        for (NSInteger i = 0; i < 5; i++) {
            CALayer * layerStar   = [CALayer layer];
            // layerStar.frame       = CGRectMake(x, y, STARWIDTH, STARWIDTH);
            layerStar.frame       = CGRectMake(x, y, width, width);
            layerStar.contents    = (id)[UIImage imageNamed:@"icon_star_fill"].CGImage;
            [layerMask addSublayer:layerStar];
            
            CALayer * layerBorder = [CALayer layer];
            layerBorder.frame     = CGRectMake(x, y, width, width);
            layerBorder.contents  = (id)[UIImage imageNamed:@"icon_star_border"].CGImage;
            [layerBg addSublayer:layerBorder];
            
            x += width + margin;
        }
        
        _layerProgress.mask = layerMask;
        
        self.clipsToBounds = YES;
        
        [self registerForKVO];
        
    }
    
    return self;
}
- (id) initWithFrame:(CGRect)frame {
    
    self.backgroundColor = [UIColor orangeColor];
    frame = CGRectMake(frame.origin.x, frame.origin.y, STARWIDTH * 5 + MARGIN * 4, frame.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        
        _layerProgress          = [CALayer layer];
        [self.layer addSublayer:_layerProgress];
        _layerProgress.frame    = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height);
        _layerProgress.backgroundColor = STARCOLOR.CGColor;
        
        CALayer* layerBg        = [CALayer layer];
        [self.layer insertSublayer:layerBg below:_layerProgress];
        layerBg.frame           = self.bounds;
        
        CALayer* layerMask      = [CALayer layer];
        [self.layer addSublayer:layerMask];
        layerMask.frame         = self.bounds;
        
        
        CGFloat x = 0.0f;
        CGFloat y = (frame.size.height - STARWIDTH) / 2;
        for (NSInteger i = 0; i < 5; i++) {
            CALayer * layerStar   = [CALayer layer];
            // layerStar.frame       = CGRectMake(x, y, STARWIDTH, STARWIDTH);
            layerStar.frame       = CGRectMake(x, y, STARWIDTH, STARWIDTH);
            layerStar.contents    = (id)[UIImage imageNamed:@"icon_star_fill"].CGImage;
            [layerMask addSublayer:layerStar];
            
            CALayer * layerBorder = [CALayer layer];
            layerBorder.frame     = CGRectMake(x, y, STARWIDTH, STARWIDTH);
            layerBorder.contents  = (id)[UIImage imageNamed:@"icon_star_border"].CGImage;
            [layerBg addSublayer:layerBorder];
            
            x += STARWIDTH + MARGIN;
        }
        
        _layerProgress.mask = layerMask;
        
        self.clipsToBounds = YES;
        
        [self registerForKVO];
        
    }
    
    return self;
}

- (void)dealloc
{
    [self unregisterFromKVO];
}

- (void)setScore:(CGFloat)score
{
    _score = score;
    
    _layerProgress.frame    = CGRectMake(0.0f,
                                         0.0f,
                                         self.frame.size.width * _score / 5.0f,
                                         self.frame.size.height);
    
}

- (void)setChageEnable:(BOOL)chageEnable
{
    _chageEnable = chageEnable;
    if (_panGes == nil) {
        _panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        [self addGestureRecognizer:_panGes];
    }
    if (_tapGes == nil) {
        _tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:_tapGes];
    }
    _panGes.enabled = _chageEnable;
    _tapGes.enabled = _chageEnable;
    [_tapGes requireGestureRecognizerToFail:_panGes];
}

#pragma mark - methods
- (void)handlePanGesture:(UIPanGestureRecognizer *)pan
{
    CGFloat touchPointX = [pan locationInView:self].x;
    NSInteger result = ceil(touchPointX/(STARWIDTH + MARGIN));
    if (result >= 0 && result <= 5) {
        self.score = result;
    }else if (result < 0) {
        self.score = 0;
    }else if (result > 5) {
        self.score = 5;
    }
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tap
{
    CGFloat touchPointX = [tap locationInView:self].x;
    self.score = ceil(touchPointX/(STARWIDTH + MARGIN));
}

#pragma mark - KVO
- (void)registerForKVO
{
    [self addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)unregisterFromKVO
{
    [self removeObserver:self forKeyPath:@"score"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSString * tempStr = [NSString stringWithFormat:@"%@", [change safeObjectForKey:@"new"]];
    if (keyPath.length && [keyPath isEqualToString:@"score"]) {
        if (tempStr.length) {
            NSInteger tScore = [tempStr integerValue];
            if (_delegate && [_delegate respondsToSelector:@selector(changedScore:)]) {
                [_delegate changedScore:tScore];
            }
        }
    }
}


@end
