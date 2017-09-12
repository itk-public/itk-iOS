//
//  TimeViewCell.m
//  YHClouds
//
//  Created by 黄小雪 on 2017/3/30.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "TimeViewCell.h"
#import "OnePixelSepView.h"
#import "ODDeliveryTimeInfo.h"
#import "TimeSelectorDefine.h"

@interface TimeViewCell()
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *iconLabel;


@end
@implementation TimeViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:UIColorFromRGB(0x000000)];
        [_titleLabel setHighlightedTextColor:UIColorFromRGB(0x00aaee)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setFont:KFontNormal(14)];
        [self.contentView addSubview:_titleLabel];
        
        _iconLabel = [[UILabel alloc]init];
        [_iconLabel setTextColor:UIColorFromRGB(0x00aaee)];
//        [_iconLabel setFont:[YHIFManager yhIconfontWithSize:15]];
        [_iconLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_iconLabel];
        
        [self.contentView setPixelSepSet:PSRectEdgeBottom];
        OnePixelSepView *lineView = [self.contentView psBottomSep];
        [lineView setMargin:22];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kRightMargin = 30;
    self.iconLabel.frame = CGRectMake(self.width - 20 - kRightMargin, 0, kRightMargin, self.height);
    
    CGFloat kLeftMargin = 22;
    self.titleLabel.frame = CGRectMake(kLeftMargin, 0, self.iconLabel.left - kLeftMargin, self.height);
}


-(void)setObject:(NSObject *)object
{
    CONDITION_CHECK_RETURN(object);
    ODDSoltTime *time = (ODDSoltTime *)object;
    self.titleLabel.text     = [time orderCommintpromptTitle];
//    self.iconLabel.text      = time.selected?Iconfont_check_mark:@"";
//    self.titleLabel.textColor = time.selected?YHColor(A1):YHColor(B2);
//    if (time.selected) {
//        self.iconLabel.text = Iconfont_check_mark;
//    }else{
//        self.iconLabel.text = @"";
//    }
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
     CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[ODDSoltTime class]], 0);
    return kCellHeight;
}
@end
