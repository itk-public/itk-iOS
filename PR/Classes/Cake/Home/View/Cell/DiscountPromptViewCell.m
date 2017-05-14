//
//  DiscountPromptViewCell.m
//  PR
//
//  Created by 黄小雪 on 06/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "DiscountPromptViewCell.h"
#import "DynamicUIModel.h"
#import "DMExhibitItem.h"

@interface DiscountPromptViewCell()
@property (strong,nonatomic) UIImageView *iconImage;
@property (strong,nonatomic) UILabel *titleLabel;
@end

@implementation DiscountPromptViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconImage = [[UIImageView alloc]init];
        [_iconImage setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_iconImage];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setTextColor:kColorGray];
        [_titleLabel setFont:KFontNormal(14)];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat kIconImageW = 12;
    CGFloat kLeftMargin = 15;
    self.iconImage.frame = CGRectMake(kLeftMargin, (self.height - kIconImageW)/2.0, kIconImageW, kIconImageW);
    self.titleLabel.frame = CGRectMake(self.iconImage.right + 10, 0, self.width - self.iconImage.right - 20, self.height);
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[DynamicCardItem class]]);
    DynamicCardItem *cardItem = object;
    DMExhibitItem *item       = cardItem.data;
    [self.titleLabel setText:item.title];
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 25;
}
@end
