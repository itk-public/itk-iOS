//
//  OrderSettlementPriceDetailViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/8/21.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderSettlementPriceDetailViewCell.h"

@implementation OrderSettlementPriceDetailViewCellModel

@end

@interface OrderSettlementPriceDetailViewCell()
@property (strong,nonatomic) UIView          *containerView;
@property (strong,nonatomic) UILabel         *freightLabel;
@property (strong,nonatomic) UILabel         *discountLabel;
@property (strong,nonatomic) UILabel         *totalPriceLabel1;
@property (strong,nonatomic) UILabel         *totalPriceLabel2;
@end

@implementation OrderSettlementPriceDetailViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:UIColorFromRGB(0xf3f4f5)];
        
        _containerView = [[UIView alloc]init];
        [_containerView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_containerView];
        
        _freightLabel = [[UILabel alloc]init];
        [_freightLabel setText:@"运费"];
        [_freightLabel setTextColor:UIColorFromRGB(0x8f8f8f)];
        [_freightLabel setFont:KFontNormal(12)];
        [_freightLabel setTextAlignment:NSTextAlignmentRight];
        [_containerView addSubview:_freightLabel];
        
        _totalPriceLabel1 = [[UILabel alloc]init];
        [_totalPriceLabel1 setText:@"总计"];
        [_totalPriceLabel1 setTextColor:UIColorFromRGB(0x8f8f8f)];
        [_totalPriceLabel1 setFont:KFontNormal(12)];
        [_totalPriceLabel1 setTextAlignment:NSTextAlignmentRight];
        [_containerView addSubview:_totalPriceLabel1];
        
        _discountLabel = [[UILabel alloc]init];
        [_discountLabel setText:@"优惠"];
        [_discountLabel setTextColor:UIColorFromRGB(0x8f8f8f)];
        [_discountLabel setFont:KFontNormal(12)];
        [_discountLabel setTextAlignment:NSTextAlignmentRight];
        [_containerView addSubview:_discountLabel];
        
        _totalPriceLabel2 = [[UILabel alloc]init];
        [_totalPriceLabel2 setText:@"合计"];
        [_totalPriceLabel2 setTextColor:UIColorFromRGB(0xff4d18)];
        [_totalPriceLabel2 setFont:KFontBold(16)];
        [_totalPriceLabel2 setTextAlignment:NSTextAlignmentRight];
        [_containerView addSubview:_totalPriceLabel2];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kContainerViewLeftMargin = 5;
    self.containerView.frame    = CGRectMake(kContainerViewLeftMargin, 0, self.width - 2*kContainerViewLeftMargin, self.height);
    
    CGFloat kRightMargin = 10;
    CGFloat kFreightLabelTopMargin = 10;
    [self.freightLabel sizeToFit];
    self.freightLabel.frame  = CGRectMake(kRightMargin, kFreightLabelTopMargin, self.containerView.width - 2*kRightMargin, self.freightLabel.height);
    
    CGFloat kTotalPriceLabel1TopMargin = 5;
    [self.totalPriceLabel1 sizeToFit];
    self.totalPriceLabel1.frame  = CGRectMake(self.freightLabel.left, self.freightLabel.bottom + kTotalPriceLabel1TopMargin, self.freightLabel.width,self.totalPriceLabel1.height);
    
    [self.discountLabel sizeToFit];
    self.discountLabel.frame = CGRectMake(self.freightLabel.left, self.totalPriceLabel1.bottom + kTotalPriceLabel1TopMargin, self.freightLabel.width, self.discountLabel.height);
    
    CGFloat kTotalPriceLabel2BottomMargin = 5;
    [self.totalPriceLabel2 sizeToFit];
    self.totalPriceLabel2.frame = CGRectMake(self.freightLabel.left, 0, self.freightLabel.width, self.totalPriceLabel2.height);
    self.totalPriceLabel2.bottom = self.containerView.height - kTotalPriceLabel2BottomMargin;
}


-(void)setObject:(id)object
{
    if ([object isKindOfClass:[OrderSettlementPriceDetailViewCellModel class]]) {
        OrderSettlementPriceDetailViewCellModel *model = object;
        self.freightLabel.text     = model.freight;
        self.totalPriceLabel1.text = model.priceTotal;
        self.totalPriceLabel2.text = model.totalPayment;
        self.discountLabel.text    = model.discount;
    }
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    if ([object isKindOfClass:[OrderSettlementPriceDetailViewCellModel class]]) {
        return 102;
    }
    return 0;
}
@end
