//
//  ChooseCouponCell.m
//  PR
//
//  Created by 黄小雪 on 21/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ChooseCouponCell.h"
#import "ThemeButton.h"
#import "CouponModel.h"

@interface ChooseCouponCell()

@property (strong,nonatomic) UILabel     *titleLabel;
@property (strong,nonatomic) UILabel     *subTitleLabel;
@property (strong,nonatomic) UILabel     *dateLabel;
@property (strong,nonatomic) ThemeButton *chooseBtn;

@end
@implementation ChooseCouponCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setText:@"100元"];
        [_titleLabel setTextColor:kColorRed];
        [_titleLabel setFont:KFontNormal(12)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc]init];
        [_subTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_subTitleLabel setFont:KFontNormal(12)];
        [_subTitleLabel setTextColor:kColorNormal];
        [self.contentView addSubview:_subTitleLabel];
        
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setTextColor:kColorGray];
        [_dateLabel setFont:KFontNormal(10)];
        [_dateLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_dateLabel];
        
        
        _chooseBtn = [ThemeButton buttonWithType:UIButtonTypeSystem];
        [_chooseBtn setTitle:@"领取" forState:UIControlStateNormal];
        [self.contentView addSubview:_chooseBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMarign       = 15;
    CGFloat chooseBtnW       = 60;
    CGFloat chooseBtnH       = 40;
    self.chooseBtn.frame     = CGRectMake(self.width - chooseBtnW - leftMarign, (self.height - chooseBtnH)/2.0, chooseBtnW, chooseBtnH);

    CGFloat labelW           = self.chooseBtn.left - 2*leftMarign;
    CGFloat topMaring        = 5;
    CGFloat labelH           = (self.height - 2* topMaring)/3.0;
    self.titleLabel.frame    = CGRectMake(leftMarign, topMaring, labelW, labelH);
    self.subTitleLabel.frame = CGRectMake(leftMarign, self.titleLabel.bottom, labelW, labelH);
    self.dateLabel.frame     = CGRectMake(leftMarign, self.subTitleLabel.bottom, labelW,labelH);

}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[CouponModel class]]);
    CouponModel *info = object;
    self.titleLabel.attributedText = [info titleAttributedString];
    self.subTitleLabel.text        = info.desc;
    self.dateLabel.text            = [info dateString];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 60;
}
@end
