//
//  OrderListActionView.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderListActionViewCell.h"

@implementation OrderListActionViewCellModel

@end

@interface OrderListActionViewCell()
@property (strong,nonatomic) UILabel *timeLabel;

@end
@implementation OrderListActionViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _timeLabel = [[UILabel alloc]init];
        [_timeLabel setText:@"下单时间：2017.1.24 09:23"];
        [_timeLabel setTextColor:kColorGray];
        [_timeLabel setTextAlignment:NSTextAlignmentLeft];
        [_timeLabel setFont:KFontNormal(14)];
        [self addSubview:_timeLabel];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.timeLabel.frame = CGRectMake(15, 0,self.kBtnLeftx - 2*15 ,self.height);
}
@end
