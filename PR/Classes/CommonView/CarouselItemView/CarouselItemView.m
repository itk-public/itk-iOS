//
//  CarouselItemView.m
//  PR
//
//  Created by 黄小雪 on 10/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CarouselItemView.h"
#import "AutoImageView.h"
#import "ProductOutline.h"

@interface CarouselItemView()
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) AutoImageView*image;
@property (strong,nonatomic) UITapGestureRecognizer *tap;
@property (strong,nonatomic) ProductOutline *product;
@end

@implementation CarouselItemView
-(instancetype)init{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _image = [[AutoImageView alloc]init];
        [_image setContentMode: UIViewContentModeScaleAspectFill];
        [self addSubview:_image];
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCarouselItemView)];
        [self addGestureRecognizer:_tap];
    }
    return self;
}
-(void)setImageUrl:(NSString *)imageurl
             title:(NSString *)title
             index:(NSInteger)index
{
    [self setImageUrl:imageurl title:title];
}


-(void)setImageUrl:(NSString *)imageurl title:(NSString *)title
{
    [_image setImgURLString:imageurl?:@""];
    if (self.titleLabel == nil) {
        [self addTitleLabel];
    }
    [self.titleLabel setText:title?:@""];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageH = self.height;
    if (self.titleLabel) {
        self.titleLabel.frame = CGRectMake(0, self.height - 21, self.width, 21);
        imageH                = self.height - self.titleLabel.height;
    }
    self.image.frame          = CGRectMake(0, 0, self.width, imageH);
}

-(void)addTitleLabel
{
    self.titleLabel  = [[UILabel alloc]init];
    [self.titleLabel setTextColor:kColorGray];
    [self.titleLabel setFont:KFontNormal(14)];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setText:@"商品名称"];
    [self addSubview:self.titleLabel];

}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[ProductOutline class]]);
    ProductOutline *item = object;
    if (item.title) {
        if (self.titleLabel == nil) {
            [self addTitleLabel];
        }
        self.titleLabel.hidden = NO;
        [self.titleLabel setText:item.title?:@""];
    }else{
        self.titleLabel.hidden = YES;
    }
    self.product = item;
}

-(void)tapCarouselItemView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(carouselItemViewDidSeleted:product:)]) {
        [self.delegate carouselItemViewDidSeleted:self product:self.product];
    }
}
@end