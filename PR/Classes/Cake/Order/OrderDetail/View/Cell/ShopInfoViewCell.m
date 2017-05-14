//
//  ShopInfoViewCell.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ShopInfoViewCell.h"
#import "OnePixelSepView.h"

@interface ShopInfoViewCell ()
@property (strong,nonatomic) UILabel *iconLabel;
@property (strong,nonatomic) UILabel *shopNameLabel;
@property (strong,nonatomic) UILabel *arrowLabel;
@end

@implementation ShopInfoViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconLabel = [[UILabel alloc]init];
        [_iconLabel setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_iconLabel];
        
        _shopNameLabel = [[UILabel alloc]init];
        [_shopNameLabel setText:@"店铺名称"];
        [_shopNameLabel setTextAlignment:NSTextAlignmentLeft];
        [_shopNameLabel setFont:KFontNormal(14)];
        [_shopNameLabel setTextColor:kColorGray];
        [self.contentView addSubview:_shopNameLabel];
        
        _arrowLabel = [[UILabel alloc]init];
        [_arrowLabel setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:_arrowLabel];
       
        [self.contentView setPixelSepSet:PSRectEdgeBottom];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kLeftMarin      = 15;
    CGFloat kIconLabelW     = 15;
    self.iconLabel.frame = CGRectMake(kLeftMarin, (self.height - kIconLabelW)/2.0, kIconLabelW, kIconLabelW);
    
    CGFloat kArrowLabelW    = 5;
    CGFloat kArrowLabelH    = 11;
    self.arrowLabel.frame   = CGRectMake(self.width - kArrowLabelW - kLeftMarin, (self.height - kArrowLabelH)/2.0, kArrowLabelW, kArrowLabelH);
    self.shopNameLabel.frame = CGRectMake(self.iconLabel.right + 5, 0, self.arrowLabel.left - self.iconLabel.right - 10, self.height);
    
}
@end
