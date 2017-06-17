//
//  SearchSeeMoreViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SearchSeeMoreViewCell.h"
#import "OnePixelSepView.h"

@implementation SearchSeeMoreModel
-(void)updateTotalNum:(NSInteger)totalNum action:(NSString *)action;
{
    _moreString = [NSString stringWithFormat:@"共%zd件，查看更多",totalNum];
}
@end

@interface SearchSeeMoreViewCell()
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) SearchSeeMoreModel *model;
@end

@implementation SearchSeeMoreViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:kColorTheme];
        [_titleLabel setFont:KFontNormal(12)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_titleLabel];
        [self.contentView setPixelSepSet:PSRectEdgeTop];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSearchSeeMoreViewCell)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[SearchSeeMoreModel class]]);
    self.model = object;
    self.titleLabel.text = self.model.moreString?:@"";
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[SearchSeeMoreModel class]], 0);
    return 46;
}


-(void)tapSearchSeeMoreViewCell
{
    PRLOG(@"点击查看更多");
}
@end
