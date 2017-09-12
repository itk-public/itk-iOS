//
//  OrderSettlementDeliveryTimeViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/8/21.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderSettlementDeliveryTimeViewCell.h"
#import "OnePixelSepView.h"
#import "TimeSelectorView.h"

@implementation OrderSettlementDeliveryTimeViewCellModel

@end

@implementation OrderSettlementCouponModel

@end

@implementation OrderSettlementFreightModel

@end


@interface OrderSettlementDeliveryTimeViewCell()
@property (strong,nonatomic) UILabel              *promptLabel;
@property (strong,nonatomic) UILabel              *selectTimeLabel;
@property (strong,nonatomic) UIImageView          *arrowImage;
@property (strong,nonatomic) OnePixelSepView      *lineView;
@property (strong,nonatomic) UIView               *containerView;
@property (strong,nonatomic) TimeSelectorView     *timeSelectorView;
@end

@implementation OrderSettlementDeliveryTimeViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _containerView = [[UIView alloc]init];
        [_containerView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_containerView];
        
        _promptLabel = [[UILabel alloc]init];
        [_promptLabel setTextAlignment:NSTextAlignmentLeft];
        [_promptLabel setTextColor:UIColorFromRGB(0x000000)];
        [_promptLabel setFont:KFontNormal(14)];
        [_promptLabel setText:@"配送时间"];
        [self.containerView addSubview:_promptLabel];
        
        _selectTimeLabel = [[UILabel alloc]init];
        [_selectTimeLabel setTextAlignment:NSTextAlignmentRight];
        [_selectTimeLabel setFont:KFontNormal(12)];
        [_selectTimeLabel setTextColor:UIColorFromRGB(0x00aaee)];
        [self.containerView addSubview:_selectTimeLabel];
        
        _arrowImage = [[UIImageView alloc]init];
        [_arrowImage setImage:[UIImage imageNamed:@"icon_arrow_right"]];
        [self.containerView addSubview:_arrowImage];
        
        [self.containerView setPixelSepSet:PSRectEdgeBottom];
        _lineView =  [self.contentView psBottomSep];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOrderSettlementDeliveryTimeViewCell)];
        [self.containerView addGestureRecognizer:tap];
        [self.contentView setBackgroundColor:kVCViewBGColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kContainerViewLeftMargin = 5;
    self.containerView.frame = CGRectMake(kContainerViewLeftMargin, 0, self.width - 2*kContainerViewLeftMargin, self.height);
    
    CGFloat kPromptLabelLeftMargin   = 10;
    [self.promptLabel sizeToFit];
    self.promptLabel.frame = CGRectMake(kPromptLabelLeftMargin, 0, self.promptLabel.width, self.containerView.height);
    
    CGFloat kArrowImageW  = 8;
    CGFloat kArrowImageH  = 13;
    self.arrowImage.frame = CGRectMake(self.containerView.width - kArrowImageW - kPromptLabelLeftMargin, (self.containerView.height - kArrowImageH)/2.0, kArrowImageW, kArrowImageH);
    
    CGFloat kSelectTimeRightMargin = 12;
    CGFloat kSelectTimeLabelW = self.arrowImage.left - self.promptLabel.right - 2*kSelectTimeRightMargin;
    self.selectTimeLabel.frame = CGRectMake(self.promptLabel.right + kSelectTimeRightMargin, 0, kSelectTimeLabelW, self.containerView.height);
    
    CGFloat kLineViewLeftMargin = 13;
    self.lineView.left = kLineViewLeftMargin;
    self.lineView.width = self.containerView.width - kLineViewLeftMargin;
}


-(void)setObject:(id)object
{
    [super setObject:object];
    if ([object isKindOfClass:[OrderSettlementDeliveryTimeViewCellModel class]]) {
        self.promptLabel.text = @"配送时间";
        [self.selectTimeLabel setTextColor:UIColorFromRGB(0x00aaee)];
        OrderSettlementDeliveryTimeViewCellModel *model = object;
        self.selectTimeLabel.text = [model.timeInfo seletedTimeStr];
        self.arrowImage.hidden = NO;
    }else if ([object isKindOfClass:[OrderSettlementCouponModel class]]){
        OrderSettlementCouponModel *coupon = object;
         self.promptLabel.text = @"优惠券";
        self.selectTimeLabel.text = coupon.coupon.title;
         [self.selectTimeLabel setTextColor:UIColorFromRGB(0x000000)];
        self.arrowImage.hidden = NO;
    }else if ([object isKindOfClass:[OrderSettlementFreightModel class]]){
        OrderSettlementFreightModel *freight = object;
        self.promptLabel.text = @"运费";
         [self.selectTimeLabel setTextColor:UIColorFromRGB(0x000000)];
        self.arrowImage.hidden = YES;
        self.selectTimeLabel.text = freight.freeShipping;
    }
}

-(void)tapOrderSettlementDeliveryTimeViewCell
{
    if ([self.object isKindOfClass:[OrderSettlementDeliveryTimeViewCellModel class]]) {
        if (!self.timeSelectorView) {
            self.timeSelectorView = [[TimeSelectorView alloc]init];
        }
        OrderSettlementDeliveryTimeViewCellModel *model = self.object;
        [self.timeSelectorView setCKVMDeliveryTimeInfo:model.timeInfo];
        [self.timeSelectorView show];
        __weak typeof(self)weakSelf = self;
        self.timeSelectorView.returnBlock = ^{
            //                [weakSelf.orderInfoTable reloadData];
        };

    }
}
@end
