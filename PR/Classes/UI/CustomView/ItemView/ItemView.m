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

@property (strong,nonatomic) UILabel                *iconLabel;
@property (strong,nonatomic) UILabel                *titleLabel;
@property (strong,nonatomic) UILabel                *subTitleLabel;
@property (strong,nonatomic) UILabel                *arrowLabel;
@property (strong,nonatomic) OnePixelSepView        *bottomLineView;
@property (strong,nonatomic) UITapGestureRecognizer *tap;
@property (strong,nonatomic) id                     modelData;

@end

@implementation ItemView
-(instancetype)init{
    if (self = [super init]) {
        _iconLabel                  = [[UILabel alloc]init];
        [_iconLabel setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_iconLabel];

        _titleLabel                 = [[UILabel alloc]init];
        [_titleLabel setFont:KFontNormal(14)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setTextColor:kColorNormal];
        [self addSubview:_titleLabel];

        _subTitleLabel              = [[UILabel alloc]init];
        [_subTitleLabel setTextColor:kColorBlakLight];
        [_subTitleLabel setFont:KFontNormal(12)];
        [_subTitleLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_subTitleLabel];

        _arrowLabel                 = [[UILabel alloc]init];
        [_arrowLabel setBackgroundColor:kColorBlakLight];
        [self addSubview:_arrowLabel];

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
    
    CGFloat iconLabelW = 15;
    CGFloat marginLeft = 15;
    self.iconLabel.frame = CGRectMake(marginLeft, 0, iconLabelW, iconLabelW);
    self.iconLabel.centerY = self.height/2.0;
    
    CGFloat titleLabelW = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.height)].width;
    self.titleLabel.frame = CGRectMake(self.iconLabel.right + 5, 0, titleLabelW, self.height);
    
    CGFloat arrowLabelW = 6;
    CGFloat arrowLabelH = 11;
    self.arrowLabel.frame = CGRectMake(0, (self.height - arrowLabelH)/2.0, arrowLabelW, arrowLabelH);
    self.arrowLabel.right = self.width - marginLeft;
    
    CGFloat subTitleLabelW = self.arrowLabel.left - self.titleLabel.right - 5*2;
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
    [itemView.iconLabel setText:iconName?:@""];
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
    [self.iconLabel setText:iconName?:@""];
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
