//
//  ItemViewCell.m
//  PR
//
//  Created by 黄小雪 on 18/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ItemViewCell.h"
#import "ItemView.h"
#import "ItemListModel.h"

@interface ItemViewCell()
@property (strong,nonatomic) ItemView *itemView;

@end
@implementation ItemViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _itemView = [[ItemView alloc]init];
        [self.contentView addSubview:_itemView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.itemView.frame = self.contentView.bounds;
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[ItemListModel class]]);
    ItemListModel *model = (ItemListModel *)object;
    [self.itemView setIconName:model.iconName title:model.title subTitle:nil modelData:model];
    
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[ItemListModel class]], 0);
    return 46;
}
@end
