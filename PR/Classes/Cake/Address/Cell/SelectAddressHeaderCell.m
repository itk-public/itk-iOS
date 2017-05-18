//
//  SelectAddressHeaderCell.m
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SelectAddressHeaderCell.h"

@implementation AddressHeaderCellModel

@end


@interface SelectAddressHeaderCell()
@property (strong,nonatomic) UILabel *titleLabel;
@end

@implementation SelectAddressHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:kVCViewBGColor];
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setText:@"我的收货地址"];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setFont:KFontNormal(14)];
        [_titleLabel  setTextColor:UIColorFromRGB(0x959595)];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(15, 0, self.width - 30, self.height);
    
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 47;
}
@end
