//
//  SubCategoryHeaderViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/5.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SubCategoryHeaderViewCell.h"
#import "SubCategoryModel.h"

@interface SubCategoryHeaderViewCell()
@property (strong,nonatomic) UILabel *titleLabel;
@end

@implementation SubCategoryHeaderViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setFont:KFontNormal(12)];
        [_titleLabel setTextColor:UIColorFromRGB(0x959595)];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(15, 0, self.width - 15, self.height);
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[SubCategoryModel class]]);
    SubCategoryModel *category = object;
    self.titleLabel.text = category.subCategoryName?:@"";
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 30;
}
@end
