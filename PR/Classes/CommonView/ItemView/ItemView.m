//
//  ItemView.m
//  PR
//
//  Created by 黄小雪 on 18/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ItemView.h"
#import "OnePixelSepView.h"

@interface ItemView()

@property (strong,nonatomic) UIImageView            *iconImage;
@property (strong,nonatomic) UILabel                *titleLabel;
@property (strong,nonatomic) UILabel                *subTitleLabel;
@property (strong,nonatomic) UIImageView            *arrowImage;
@property (strong,nonatomic) OnePixelSepView        *bottomLineView;
@property (strong,nonatomic) UITapGestureRecognizer *tap;
@property (strong,nonatomic) id                     modelData;

@end

@implementation ItemView
-(instancetype)init{
    if (self = [super init]) {
        _iconImage                  = [[UIImageView alloc]init];
        [_iconImage setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_iconImage];

        _titleLabel                 = [[UILabel alloc]init];
        [_titleLabel setFont:KFontNormal(15)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setTextColor:UIColorFromRGB(0x323232)];
        [self addSubview:_titleLabel];

        _subTitleLabel              = [[UILabel alloc]init];
        [_subTitleLabel setTextColor:kColorBlakLight];
        [_subTitleLabel setFont:KFontNormal(12)];
        [_subTitleLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_subTitleLabel];

        _arrowImage                 = [[UIImageView alloc]init];
        [_arrowImage setImage:[UIImage imageNamed:@"icon_arrow_right"]];
        [self addSubview:_arrowImage];

        [self setPixelSepSet:PSRectEdgeBottom];
        _bottomLineView             = [self psBottomSep];

        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(tapView)];
        [self addGestureRecognizer:tap];
        self.tap                    = tap;
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat iconLabelW = 20;
    CGFloat marginLeft = 15;
    self.iconImage.frame = CGRectMake(marginLeft, 0, iconLabelW, iconLabelW);
    self.iconImage.centerY = self.height/2.0;
    
    CGFloat titleLabelW = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.height)].width;
    self.titleLabel.frame = CGRectMake(self.iconImage.right + 10, 0, titleLabelW, self.height);
    
    CGFloat arrowLabelW = 6;
    CGFloat arrowLabelH = 11;
    self.arrowImage.frame = CGRectMake(0, (self.height - arrowLabelH)/2.0, arrowLabelW, arrowLabelH);
    self.arrowImage.right = self.width - marginLeft;
    
    CGFloat subTitleLabelW = self.arrowImage.left - self.titleLabel.right - 5*2;
    self.subTitleLabel.frame = CGRectMake(self.titleLabel.right + 5, 0, subTitleLabelW, self.height);
}

+(instancetype)itemViewWithIconName:(NSString *)iconName
                              title:(NSString *)title
                           subTitle:(NSString *)subTitle
                          modelData:(id)modelData;
{
    ItemView *itemView = [[ItemView alloc]init];
    itemView.modelData = modelData;
    [itemView.titleLabel setText:title?:@""];
    [itemView.iconImage setImage:[UIImage imageNamed:iconName]];
    [itemView.subTitleLabel setText:subTitle?:@""];
    return itemView;
}

-(void)setIconName:(NSString *)iconName
             title:(NSString *)title
          subTitle:(NSString *)subTitle
         modelData:(id)modelData
{
    self.modelData = modelData;
    [self.titleLabel setText:title?:@""];
    [self.iconImage setImage:[UIImage imageNamed:iconName]];
    [self.subTitleLabel setText:subTitle?:@""];
}

-(void)tapView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemViewDidTouch:)]) {
        [self.delegate itemViewDidTouch:self.modelData];
    }
}

-(void)dealloc
{
    if (self.tap) {
        [self removeGestureRecognizer:self.tap];
    }
}
@end
