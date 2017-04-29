//
//  HomeProductScrollviewCell.m
//  PR
//
//  Created by 黄小雪 on 10/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "HomeProductScrollviewCell.h"
#import "CarouselView.h"
#import "DynamicUIModel.h"

@interface HomeProductScrollviewCell()
@property (strong,nonatomic) CarouselView *carouseView;
@end

@implementation HomeProductScrollviewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _carouseView = [[CarouselView alloc]init];
        [self.contentView addSubview:_carouseView];
        [_carouseView setBackgroundColor:[UIColor redColor]];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.carouseView.frame = self.bounds;
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[DynamicCardItem class]]);
    DynamicCardItem *item = (DynamicCardItem *)object;
    [self.carouseView setUpDatalist:item.data];
    
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 105;
}
@end
