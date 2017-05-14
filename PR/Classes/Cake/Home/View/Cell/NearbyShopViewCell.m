//
//  NearbyShopViewCell.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "NearbyShopViewCell.h"
#import "AutoImageView.h"
#import "OnePixelSepView.h"
#import "DynamicUIModel.h"
#import "DMExhibitItem.h"

@interface NearbyShopViewCell()

@property (strong,nonatomic) AutoImageView *shopIcon;
@property (strong,nonatomic) UILabel       *shopNameLabel;
@property (strong,nonatomic) UILabel       *salesLabel;
@property (strong,nonatomic) UILabel       *actionLabel;
@property (strong,nonatomic) UIView        *grageView;

@end
@implementation NearbyShopViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _shopIcon = [[AutoImageView alloc]init];
        [_shopIcon setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:_shopIcon];
        
        _shopNameLabel = [[UILabel alloc]init];
        [_shopNameLabel setText:@"某某店铺"];
        [_shopNameLabel setTextAlignment:NSTextAlignmentLeft];
        [_shopNameLabel setFont:KFontNormal(16)];
        [_shopNameLabel setTextColor:kColorNormal];
        [self.contentView addSubview:_shopNameLabel];
        
        _salesLabel = [[UILabel alloc]init];
        [_salesLabel setTextColor:kColorGray];
        [_salesLabel setFont:KFontNormal(14)];
        [_salesLabel setTextAlignment:NSTextAlignmentLeft];
        [_salesLabel setText:@"月销量205单"];
        [self.contentView addSubview:_salesLabel];
        
        _actionLabel = [[UILabel alloc]init];
        [_actionLabel setText:@"进店"];
        _actionLabel.layer.borderColor = kColorGray.CGColor;
        _actionLabel.layer.borderWidth = OnePoint;
        _actionLabel.layer.cornerRadius = 2.0;
        [_actionLabel setTextAlignment:NSTextAlignmentCenter];
        [_actionLabel setTextColor:kColorGray];
        [self.contentView addSubview:_actionLabel];
        
        _grageView = [[UIView alloc]init];
        [_grageView setBackgroundColor:kColorGray];
        [self.contentView addSubview:_grageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kShopIconW = 40;
    CGFloat kLeftMargin = 15;
    self.shopIcon.frame = CGRectMake(kLeftMargin, (self.height - kShopIconW)/2.0, kShopIconW, kShopIconW);
    
    CGFloat kActionLabelW = 48;
    CGFloat kActionLabelH = 25;
    self.actionLabel.frame = CGRectMake(self.width - kActionLabelW - kLeftMargin, (self.height - kActionLabelH)/2.0, kActionLabelW, kActionLabelH);
    
    CGFloat kShopNameLabelW= self.actionLabel.left - self.shopIcon.right - 20;
    CGFloat kShopNameLabelH = 20;
    self.shopNameLabel.frame = CGRectMake(self.shopIcon.right + 10, 10, kShopNameLabelW, kShopNameLabelH);
    CGFloat kGrageViewW    = 80;
    CGFloat kGrageViewH    = 20;
    self.grageView.frame   = CGRectMake(self.shopNameLabel.left, self.shopNameLabel.bottom + 10, kGrageViewW, kGrageViewH);
    
    CGFloat kSalesLabelW   = kShopNameLabelW - kGrageViewW - 10;
    self.salesLabel.frame  = CGRectMake(self.grageView.right + 5, 0, kSalesLabelW, 20);
    self.salesLabel.centerY = self.grageView.centerY;
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[DynamicCardItem class]]);
    DynamicCardItem *cardItem = object;
    DMExhibitItem   *item     = cardItem.data;
    [self.shopIcon setImgInfo:item.imgInfo];
    [self.shopNameLabel setText:item.title?:@""];
    [self.salesLabel setText:item.subTitle?:@""];
    
}
+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 72;
}

@end
