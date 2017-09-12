//
//  ShopCartTableHeaderView.m
//  PR
//
//  Created by 黄小雪 on 2017/5/28.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopCartTableHeaderView.h"
#import "CombineAdressViewController.h"
#import "SceneMananger.h"

@interface SingleInfoView : UIView
@property (strong,nonatomic) UILabel *leftLabel;
@property (strong,nonatomic) UILabel *rightLabel;
@end

@implementation SingleInfoView
-(instancetype)init
{
    if (self = [super init]) {
        _leftLabel = [[UILabel alloc]init];
        [_leftLabel setTextAlignment:NSTextAlignmentLeft];
        [_leftLabel setFont:KFontNormal(14)];
        [_leftLabel setTextColor:UIColorFromRGB(0x4c4c4c)];
        [self addSubview:_leftLabel];
        
        _rightLabel = [[UILabel alloc]init];
        [_rightLabel setTextColor:UIColorFromRGB(0x4c4c4c)];
        [_rightLabel setFont:KFontNormal(14)];
        _rightLabel.numberOfLines = 2;
        [_rightLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_rightLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    [self.leftLabel sizeToFit];
    self.leftLabel.frame = CGRectMake(kLeftMargin, 0, self.leftLabel.width, self.leftLabel.height);
    
    CGFloat kRightLabelW = self.width - 94;
    CGSize  kRightLabelSize = [self.rightLabel sizeThatFits:CGSizeMake(kRightLabelW, MAXFLOAT)];
    self.rightLabel.frame = CGRectMake(94, 0, kRightLabelW, kRightLabelSize.height);
}

-(CGFloat)heightWithLeftString:(NSString *)leftString rightString:(NSString *)rightString
{
    self.leftLabel.text = leftString?:@"";
    self.rightLabel.text = rightString?:@"";
    CGFloat kRightLabelW = self.width - 94;
    [self setNeedsLayout];
    return  [self.rightLabel sizeThatFits:CGSizeMake(kRightLabelW, MAXFLOAT)].height;
    
}

@end

#define kReceiverViewTop      12
#define kAddressViewTop       9
#define kAddressViewBottom    16
@interface ShopCartTableHeaderView()
@property (strong,nonatomic) SingleInfoView *receiverView;
@property (strong,nonatomic) SingleInfoView *addressView;
@property (strong,nonatomic) UIImageView    *arrowImage;
@property (strong,nonatomic) UIImageView    *topImageView;
@property (strong,nonatomic) UIImageView    *bottomImageView;
@property (assign,nonatomic) CGFloat         deliveryTypeViewH;
@property (assign,nonatomic) CGFloat         receiverViewH;
@property (assign,nonatomic) CGFloat         addressViewH;
@property (strong,nonatomic) UIView          *containerView;
@end

@implementation ShopCartTableHeaderView
-(instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:kVCViewBGColor];
        _containerView = [[UIView alloc]init];
        [_containerView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_containerView];
        
        _receiverView = [[SingleInfoView alloc]init];
        [_containerView addSubview:_receiverView];
        
        _addressView  = [[SingleInfoView alloc]init];
        [_containerView addSubview:_addressView];
        
        _arrowImage   = [[UIImageView alloc]init];
        [_arrowImage setImage:[UIImage imageNamed:@"icon_arrow_right"]];
        [_containerView addSubview:_arrowImage];
        
        _topImageView = [[UIImageView alloc]init];
        [_topImageView setBackgroundColor:[UIColor grayColor]];
        [_containerView addSubview:_topImageView];
        
        _bottomImageView = [[UIImageView alloc]init];
        [_bottomImageView setBackgroundColor:[UIColor grayColor]];
        [_containerView addSubview:_bottomImageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.containerView.frame   = CGRectMake(5, 0, self.width - 10, self.height);
    self.topImageView.frame    = CGRectMake(0, 0, self.containerView.width, 3);
    self.bottomImageView.frame = CGRectMake(0, self.height - 3, self.containerView.width, 3);
    
    CGFloat kSingleInfoViewW   = self.containerView.width - 106;
    self.receiverView.frame    = CGRectMake(0, self.topImageView.bottom + kReceiverViewTop, kSingleInfoViewW, self.receiverViewH);
    self.addressView.frame     = CGRectMake(0, self.receiverView.bottom + kAddressViewTop, kSingleInfoViewW, self.addressViewH);
    
    CGFloat kArrowImageW       = 8;
    CGFloat kArrowImageH       = 13;
    self.arrowImage.frame      = CGRectMake(self.containerView.width - 15 - kArrowImageW, (self.height - kArrowImageH)/2.0, kArrowImageW, kArrowImageH);
}

-(void)update
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


-(CGFloat)height
{
    self.receiverViewH = [self.receiverView heightWithLeftString:@"收货信息" rightString:@"王杰 136****6508"];
    self.addressViewH = [self.addressView heightWithLeftString:nil rightString:@"上海市徐汇区康健路120弄38号604shi"];
    return 6 + self.deliveryTypeViewH+self.receiverViewH+self.addressViewH+kReceiverViewTop+kAddressViewTop+kAddressViewBottom;
}

#pragma mark btn action
-(void)changeBtnOnClicked:(UIButton *)sender
{
    CombineAdressViewController *combineAddressVC = [[CombineAdressViewController alloc]init];
    combineAddressVC.selectedSegmentIndex  = 0;
    [[SceneMananger shareMananger] showViewController:combineAddressVC withStyle:U_SCENE_SHOW_PUSH];
}
@end
