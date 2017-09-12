//
//  ShopCartDiscountCell.m
//  PR
//
//  Created by 黄小雪 on 2017/9/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopCartDiscountCell.h"
#import "OnePixelSepView.h"
#import "ShopCartDiscountModel.h"

@interface ShopCartDiscountCell()
@property (strong,nonatomic) UILabel         *tagLabel;
@property (strong,nonatomic) UILabel         *titleLabel;
@property (strong,nonatomic) UILabel         *subtitleLabel;
@property (strong,nonatomic) OnePixelSepView *lineView;
@property (strong,nonatomic) UIView          *containerView;
@end

@implementation ShopCartDiscountCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ShopCartDiscountCell";
    ShopCartDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ShopCartDiscountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:kVCViewBGColor];

        _containerView = [[UIView alloc]init];
        [_containerView setBackgroundColor:[UIColor whiteColor]];
        
        _tagLabel = [[UILabel alloc]init];
        [_tagLabel setBackgroundColor:UIColorFromRGB(0xa6a6a6)];
        _tagLabel.layer.borderColor = _tagLabel.backgroundColor.CGColor;
        _tagLabel.layer.borderWidth = OnePoint;
        _tagLabel.layer.cornerRadius = 2.0;
        [self.containerView addSubview:_tagLabel];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setTextColor:UIColorFromRGB(0x000000)];
        [_titleLabel setFont:KFontNormal(14)];
        [self.containerView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]init];
        [_subtitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_subtitleLabel setTextColor:UIColorFromRGB(0x868686)];
        [_subtitleLabel setFont:KFontNormal(12)];
        [self.containerView addSubview:_subtitleLabel];
        
        [self.containerView setPixelSepSet:PSRectEdgeBottom];
        _lineView = [self.containerView psBottomSep];
        [_lineView setMargin:10];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kContainerViewLeftMargin = 5;
    self.containerView.frame = CGRectMake(kContainerViewLeftMargin, 0, self.width - 2*kContainerViewLeftMargin, self.height);
    
    CGFloat kTagLabelLeftMargin      = 10;
    [self.tagLabel sizeToFit];
    self.tagLabel.frame = CGRectMake(kTagLabelLeftMargin, (self.containerView.height - self.tagLabel.height)/2.0, self.tagLabel.width, self.tagLabel.height);
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(kTagLabelLeftMargin + self.tagLabel.right, 0, self.titleLabel.width, self.containerView.height);
    
    CGFloat kSubtitleLabelLeftMargin = 30;
    [self.subtitleLabel sizeToFit];
    self.subtitleLabel.frame = CGRectMake(kSubtitleLabelLeftMargin + self.titleLabel.right, 0, self.subtitleLabel.width, self.containerView.height);
}

-(void)setDiscountModel:(ShopCartDiscountModel *)discountModel
{
    if ([discountModel isKindOfClass:[ShopCartDiscountModel class]]) {
        _discountModel           = discountModel;
        self.tagLabel.text      = discountModel.tag?:@"";
        self.titleLabel.text    = discountModel.title?:@"";
        self.subtitleLabel.text = discountModel.subtitle?:@"";
        [self setNeedsLayout];
    }
}
+(CGFloat)getHeightWithCartOrderCellViewModel:(id)vM
{
    if ([vM isKindOfClass:[ShopCartDiscountModel class]]) {
        return 46;
    }
    return 0;
}
@end
