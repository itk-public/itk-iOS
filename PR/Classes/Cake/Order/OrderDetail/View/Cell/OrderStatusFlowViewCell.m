//
//  OrderStatusFlowViewCell.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderStatusFlowViewCell.h"

@interface OrderStatusFlowViewCell()
@property (strong,nonatomic) UILabel *orderIdLabel;

@end
@implementation OrderStatusFlowViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:kColorTheme];
        _orderIdLabel = [[UILabel alloc]init];
        [_orderIdLabel setTextAlignment:NSTextAlignmentLeft];
        [_orderIdLabel setFont:KFontNormal(14)];
        [_orderIdLabel setTextColor:[UIColor whiteColor]];
        [_orderIdLabel setText:@"订单编号:1503030030303003"];
        [self.contentView addSubview:_orderIdLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    self.orderIdLabel.frame = CGRectMake(kLeftMargin, 10, self.width - 2*kLeftMargin, 21);
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 60;
}
@end
