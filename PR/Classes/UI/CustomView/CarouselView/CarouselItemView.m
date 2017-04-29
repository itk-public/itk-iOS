//
//  CarouselItemView.m
//  PR
//
//  Created by 黄小雪 on 10/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CarouselItemView.h"
#import "AutoImageView.h"
#import "ProductInfo.h"

@interface CarouselItemView()

@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) AutoImageView*image;
@property (strong,nonatomic) UITapGestureRecognizer *tap;

@end
@implementation CarouselItemView
-(instancetype)init{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _image = [[AutoImageView alloc]init];
        [_image setBackgroundColor:[UIColor grayColor]];
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
    _index  = index;
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
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titleLabel setText:@"商品名称"];
    [self addSubview:self.titleLabel];

}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[ProductInfo class]]);
    ProductInfo *item = object;
    if (item.title) {
        if (self.titleLabel == nil) {
            [self addTitleLabel];
        }
        self.titleLabel.hidden = NO;
        [self.titleLabel setText:item.title?:@""];
    }else{
        self.titleLabel.hidden = YES;
    }
}
-(void)tapCarouselItemView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(carouselItemViewDidSeleted:)]) {
        [self.delegate carouselItemViewDidSeleted:self];
    }
}
@end
