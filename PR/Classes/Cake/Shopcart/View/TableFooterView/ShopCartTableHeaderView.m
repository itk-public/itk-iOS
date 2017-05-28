//
//  ShopCartTableHeaderView.m
//  PR
//
//  Created by 黄小雪 on 2017/5/28.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopCartTableHeaderView.h"

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

#define kDeliveryTypeViewTop  15
#define kReceiverViewTop      12
#define kAddressViewTop       9
#define kAddressViewBottom    16
@interface ShopCartTableHeaderView()
@property (strong,nonatomic) SingleInfoView *deliveryTypeView;
@property (strong,nonatomic) SingleInfoView *receiverView;
@property (strong,nonatomic) SingleInfoView *addressView;
@property (strong,nonatomic) UIImageView    *arrowImage;
@property (strong,nonatomic) UIButton       *changeBtn;
@property (strong,nonatomic) UIImageView    *topImageView;
@property (strong,nonatomic) UIImageView    *bottomImageView;
@property (assign,nonatomic) CGFloat         deliveryTypeViewH;
@property (assign,nonatomic) CGFloat         receiverViewH;
@property (assign,nonatomic) CGFloat         addressViewH;
@end

@implementation ShopCartTableHeaderView
-(instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _deliveryTypeView = [[SingleInfoView alloc]init];
        [self addSubview:_deliveryTypeView];
        
        _receiverView = [[SingleInfoView alloc]init];
        [self addSubview:_receiverView];
        
        _addressView  = [[SingleInfoView alloc]init];
        [self addSubview:_addressView];
        
        _arrowImage = [[UIImageView alloc]init];
        [_arrowImage setImage:[UIImage imageNamed:@"icon_arrow_right"]];
        [self addSubview:_arrowImage];
        
        _changeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_changeBtn setTitle:@"门店自提" forState:UIControlStateNormal];
        [_changeBtn setTitleColor:UIColorFromRGB(0x00aaee) forState:UIControlStateNormal];
        _changeBtn.layer.borderColor = UIColorFromRGB(0x00aaee).CGColor;
        _changeBtn.layer.borderWidth = OnePoint;
        _changeBtn.layer.cornerRadius = 10.0;
        [self addSubview:_changeBtn];
        
        _topImageView = [[UIImageView alloc]init];
        [_topImageView setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_topImageView];
        
        _bottomImageView = [[UIImageView alloc]init];
        [_bottomImageView setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_bottomImageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.topImageView.frame = CGRectMake(0, 0, self.width, 3);
    self.bottomImageView.frame = CGRectMake(0, self.height - 3, self.width, 3);
    
    CGFloat kSingleInfoViewW  = self.width - 106;
    self.deliveryTypeView.frame = CGRectMake(0, self.topImageView.bottom + kDeliveryTypeViewTop, kSingleInfoViewW, self.deliveryTypeViewH);
    self.receiverView.frame    = CGRectMake(0, self.deliveryTypeView.bottom + kReceiverViewTop, kSingleInfoViewW, self.receiverViewH);
    self.addressView.frame     = CGRectMake(0, self.receiverView.bottom + kAddressViewTop, kSingleInfoViewW, self.addressViewH);
    
    CGFloat kChangeBtnW        = 75;
    CGFloat kChangeBtnH        = 21;
    self.changeBtn.frame       = CGRectMake(self.width - kChangeBtnW - 15, 15, kChangeBtnW, kChangeBtnH);
    CGFloat kArrowImageW       = 8;
    CGFloat kArrowImageH       = 13;
    self.arrowImage.frame      = CGRectMake(self.width - 15 - kArrowImageW, (self.height - kArrowImageH)/2.0, kArrowImageW, kArrowImageH);
}

-(void)update
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(CGFloat)height
{
    self.deliveryTypeViewH = [self.deliveryTypeView heightWithLeftString:@"收货方式" rightString:@"送货上门"];
    self.receiverViewH = [self.receiverView heightWithLeftString:@"收货信息" rightString:@"王杰 136****6508"];
    self.addressViewH = [self.addressView heightWithLeftString:nil rightString:@"上海市徐汇区康健路120弄38号604shi"];
    return 6 + self.deliveryTypeViewH+self.receiverViewH+self.addressViewH+kDeliveryTypeViewTop+kReceiverViewTop+kAddressViewTop+kAddressViewBottom;
}
@end
