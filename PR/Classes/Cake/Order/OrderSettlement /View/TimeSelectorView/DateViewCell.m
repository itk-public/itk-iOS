//
//  DateViewCell.m
//  YHClouds
//
//  Created by 黄小雪 on 2017/3/30.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "DateViewCell.h"
#import "TimeSelectorDefine.h"

@interface DateViewCell()
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) ODDeliveryTimeInfo *time;

@end
@implementation DateViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:KFontNormal(14)];
        [_titleLabel setTextColor:UIColorFromRGB(0x000000)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_titleLabel];
        [self.contentView setBackgroundColor:UIColorFromRGB(0xf3f3f3)];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}

-(void)setObject:(NSObject *)object
{
    CONDITION_CHECK_RETURN(object);
    ODDeliveryTimeInfo *time = (ODDeliveryTimeInfo *)object;
    self.titleLabel.text     = [time timeSeletorDateDesc];
    self.time                = time;
    if (time.selected) {
        [self.titleLabel setBackgroundColor:[UIColor whiteColor]];
        [self.titleLabel setTextColor:UIColorFromRGB(0x000000)];
    }else{
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setTextColor:UIColorFromRGB(0x00aaee)];
    }
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[ODDeliveryTimeInfo class]], 0);
    return kCellHeight;
}

-(void)tapDateViewCell
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dateViewCellDidClicked:ODDeliveryTimeInfo:)]) {
        [self.delegate dateViewCellDidClicked:self ODDeliveryTimeInfo:self.time];
    }
}
@end
