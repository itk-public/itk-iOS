//
//  GoodDetailTitleViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "GoodDetailTitleViewCell.h"
#import "ProductOutline.h"

@interface GoodDetailTitleViewCell()
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *priceLabel;
@end

@implementation GoodDetailTitleViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 2;
        [_titleLabel setTextColor:UIColorFromRGB(0x000000)];
        [_titleLabel setFont:KFontNormal(16)];
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextAlignment:NSTextAlignmentLeft];
        [_priceLabel setTextColor:kColorYHOrange];
        [self.contentView addSubview:_priceLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(kLeftMargin, self.height - self.priceLabel.height, self.width - 2*kLeftMargin, self.priceLabel.height);
    self.titleLabel.frame = CGRectMake(kLeftMargin, 5, self.priceLabel.width, self.height - self.priceLabel.height);
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[ProductOutline class]]);
    ProductOutline *product = object;
    self.titleLabel.text = product.title?:@"";
    self.priceLabel.text = product.priceInfo.marketPrice?:@"";
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[ProductOutline class]], 0);
    ProductOutline *product = object;
    NSDictionary *dic = [[self class]getTitleLabelH:product];
    return  [[dic safeObjectForKey:@"tempHeight"]floatValue];
}


+(NSDictionary *)getTitleLabelH:(ProductOutline *)product
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:product.title];
    NSMutableParagraphStyle *paragraphStype     = [[NSMutableParagraphStyle alloc]init];
    paragraphStype.lineSpacing      = 5;
    paragraphStype.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStype.alignment        = NSTextAlignmentLeft;
    [attributedString addAttributes:@{NSFontAttributeName:KFontNormal(16),NSParagraphStyleAttributeName:paragraphStype} range:NSMakeRange(0, attributedString.length)];
    
    
//    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[NSString class]], 0);
//    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentLeft;
//    NSDictionary *attributes           = @{NSFontAttributeName:KFontNormal(14),NSParagraphStyleAttributeName:paragraph};
//    CGSize maximumLabelSize            = CGSizeMake(ScreenWidth - 30, CGFLOAT_MAX);
//    CGSize expectSize                  = [(NSString *)object boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
//    return expectSize.height + 20;
    
    
    CGRect tempRect
    =  [product.title boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:KFontNormal(16),NSParagraphStyleAttributeName:paragraphStype} context:nil];
    CGFloat titleH = tempRect.size.height + 40;
    return @{@"tempHeight":@(titleH),@"attributedString":attributedString};
}

@end
