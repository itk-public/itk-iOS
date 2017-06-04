//
//  ShopCategoryCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopCategoryCell.h"
#import "ShopCategoryModel.h"

@interface ShopCategoryCell()

@property (strong,nonatomic) UILabel *leftLine;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) ShopCategoryModel *model;

@end
@implementation ShopCategoryCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _leftLine = [[UILabel alloc]init];
        [_leftLine setBackgroundColor:kColorTheme];
        [self.contentView addSubview:_leftLine];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setHighlightedTextColor:kColorTheme];
        [_titleLabel setTextColor:UIColorFromRGB(0x959595)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:KFontNormal(14)];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

-(void)setSelected:(BOOL)selected
{
    self.leftLine.hidden = !selected;
    self.titleLabel.highlighted = selected;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftLine.frame = CGRectMake(0, 0, 4, self.height);
    self.titleLabel.frame = self.bounds;
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[ShopCategoryModel class]]);
    self.model = object;
    self.titleLabel.text = self.model.categoryName;
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 43;
}
@end
