//
//  CategoryProductViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/5.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CategoryProductViewCell.h"
#import "AutoImageView.h"
#import "CarouselItemView.h"
#import "SubCategoryModel.h"

#define kBaseTag 10000
#define kItemViewH  110
@interface CategoryProductViewCell()
@property (strong,nonatomic) SubCategoryModel *categoryModel;
@end

@implementation CategoryProductViewCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat itemViewW = (self.width - 4*kLeftMargin)/3.0;
    NSInteger index = 0;
    for (CarouselItemView *itemView in self.contentView.subviews) {
        CGFloat row = [[self class] rowOfItemView:index];
        CGFloat column = [[self class] columnOfItemView:index];
        CGFloat itemViewX = kLeftMargin * (column + 1) + itemViewW * column;
        CGFloat itemViewY = row *kItemViewH;
        itemView.frame = CGRectMake(itemViewX, itemViewY,itemViewW, kItemViewH);
        index ++;
    }
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[SubCategoryModel class]]);
    self.categoryModel = object;
    [self updateUI];
    [self setNeedsLayout];
}

-(void)updateUI
{
    NSInteger index = 0;
    for (NSInteger i = 0; i < [self.categoryModel.subCategorySkus count]; i ++) {
        [self addCarouseItemView:i];
        index = i;
    }
    [self removeUnUseCarouseItemView:index + 1];
}

-(CarouselItemView *)findCarouseItemView:(NSInteger)index
{
    CarouselItemView *itemView = (CarouselItemView *)[self.contentView findASubViewWithTag:index+kBaseTag];
    return itemView;
    
}

-(void)addCarouseItemView:(NSInteger)index
{
    CarouselItemView *itemView = [self findCarouseItemView:index];
    if (itemView == nil) {
        CarouselItemView *newItemView = [[CarouselItemView alloc]init];
        newItemView.tag               = index + kBaseTag;
        [self.contentView addSubview:newItemView];
        itemView = newItemView;
    }
    ProductOutline *product = [self.categoryModel.subCategorySkus safeObjectAtIndex:index hintClass:[ProductOutline class]];
    if (product) {
        [itemView setImageUrl:product.imageInfo.imgUrl title:product.title index:0];
    }
}

-(void)removeUnUseCarouseItemView:(NSInteger)index
{
    while (true) {
         CarouselItemView *unUseItemView = [self findCarouseItemView:index];
        if (unUseItemView) {
            [unUseItemView removeFromSuperview];
        }else{
            break;
        }
         index ++;
    }
}
//index所在行,从0开始
+(NSInteger)rowOfItemView:(NSInteger)index
{
    
//    if(index%4 == 0){
        return index/3;
//    }
//    return index/3 + 1;
}
//index所在列，从0开始
+(NSInteger)columnOfItemView:(NSInteger)index
{
    return index%3;
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[SubCategoryModel class]], 0);
    SubCategoryModel *categoryModel = object;
    CGFloat row = [[self class] rowOfItemView:[categoryModel.subCategorySkus count] - 1];
    return (row + 1)*kItemViewH;
}
@end
