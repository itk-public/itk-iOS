//
//  SectionHeaderView.m
//  PR
//
//  Created by 黄小雪 on 02/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderListShopViewCell.h"
#import "OnePixelSepView.h"

@interface OrderListShopViewCell()
@property (strong,nonatomic) UIImageView *icon;
@property (strong,nonatomic) UILabel *shopNameLabel;
@property (strong,nonatomic) UILabel *arrowLabel;
@property (strong,nonatomic) UILabel *statusLabel;
@end

@implementation OrderListShopViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        _icon = [[UIImageView alloc]init];
        [_icon setBackgroundColor:[UIColor magentaColor]];
        [self.contentView addSubview:_icon];
        
        _shopNameLabel = [[UILabel alloc]init];
        [_shopNameLabel setTextAlignment:NSTextAlignmentLeft];
        [_shopNameLabel setText:@"店铺名称"];
        [_shopNameLabel setFont:KFontNormal(14)];
        [_shopNameLabel setTextColor:kColorGray];
        [self.contentView addSubview:_shopNameLabel];
        
        _arrowLabel = [[UILabel alloc]init];
        [_arrowLabel setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:_arrowLabel];
        
        _statusLabel = [[UILabel alloc]init];
        [_statusLabel setTextColor:[UIColor orangeColor]];
        [_statusLabel setFont:KFontNormal(14)];
        [_statusLabel setTextAlignment:NSTextAlignmentRight];
        [_statusLabel setText:@"订单待支付"];
        [self.contentView addSubview:_statusLabel];
        
        [self setPixelSepSet:PSRectEdgeBottom];
    }
    return self;
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kIconLabelW = 20;
    CGFloat kLeftMarin  = 15;
    self.icon.frame = CGRectMake(kLeftMarin, (self.height - kIconLabelW)/2.0, kLeftMarin, kLeftMarin);
    
    CGFloat shopNameLabelW = [self.shopNameLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.height)].width;
    self.shopNameLabel.frame = CGRectMake(self.icon.right + 10, 0, shopNameLabelW, self.height);
    self.arrowLabel.frame = CGRectMake(self.shopNameLabel.right + 10, 0, 5, 11);
    self.arrowLabel.centerY = self.height/2.0;
    
    self.statusLabel.frame = CGRectMake(0, 0, self.width - kLeftMarin - 2*10 - self.arrowLabel.right, self.height);
    self.statusLabel.right = self.width - kLeftMarin;
}
@end
