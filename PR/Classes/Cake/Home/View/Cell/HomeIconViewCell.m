//
//  HomeIconViewCell.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "HomeIconViewCell.h"
#import "SingleIconView.h"
#import "DMExhibitItem.h"
#import "DynamicUIModel.h"
#import "SingleIconView.h"

#define kBaseTag  1000

@implementation HomeIconViewCell
-(void)layoutSubviews
{
    [super layoutSubviews];
    if ([self.contentView.subviews count]) {
        CGFloat kMargin = 15;
        CGFloat kIconW  = (self.width - ([self.contentView.subviews count] + 1)*kMargin)*1.0/[self.contentView.subviews count];
        NSInteger tempCount = 0;
        for (SingleIconView *item in self.contentView.subviews) {
            item.frame = CGRectMake((tempCount+1) * kMargin + tempCount * kIconW,10,kIconW , self.height - 2*10);
            tempCount ++;
        }
    }
}

-(void)setObject:(id)object{
    CONDITION_CHECK_RETURN([object isKindOfClass:[DynamicCardItem class]]);
    DynamicCardItem *item = (DynamicCardItem *)object;
    NSArray *tempArray = item.data;
    
    NSInteger index = 0;
    for (DMExhibitItem *info in tempArray) {
      SingleIconView  *iconView = (SingleIconView *)[self.contentView findASubViewWithTag:kBaseTag + index];
        if (iconView == nil) {
            iconView = [[SingleIconView alloc]init];
            iconView.tag = kBaseTag + index;
            [self.contentView addSubview:iconView];
        }
        index ++;
        [iconView setItem:info];
    }
    [self removeUnUseView:index];
    [self setNeedsLayout];
}

-(void)removeUnUseView:(NSInteger)index
{
    while (true) {
        SingleIconView *viewInfo = (SingleIconView *)[self.contentView findASubViewWithTag:index + kBaseTag];
        if (viewInfo == nil) {
            break;
        }else{
            [viewInfo removeFromSuperview];
            index ++;
        }
    }
}
+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 85;
}
@end
