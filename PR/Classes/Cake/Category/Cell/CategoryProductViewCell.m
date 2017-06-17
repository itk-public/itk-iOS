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
#import "PRMBWantedOffice.h"

#define kBaseTag 10000
#define kItemViewH  110

@implementation CategoryProductViewCellModel
-(instancetype)init
{
    if (self =[super init]) {
        _products = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}
@end

@interface CategoryProductViewCell()<CarouselItemViewDelegate>
//@property (strong,nonatomic) SubCategoryModel *categoryModel;
@property (strong,nonatomic) CategoryProductViewCellModel *cellModel;

@end

@implementation CategoryProductViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat itemViewW = (self.width - 4*kLeftMargin)/3.0;
    NSInteger index = 0;
    for (CarouselItemView *itemView in self.contentView.subviews) {
        if ([itemView isKindOfClass:[CarouselItemView class]]) {
            CGFloat row = [[self class] rowOfItemView:index];
            CGFloat column = [[self class] columnOfItemView:index];
            CGFloat itemViewX = kLeftMargin * (column + 1) + itemViewW * column;
            CGFloat itemViewY = row *kItemViewH;
            itemView.frame = CGRectMake(itemViewX, itemViewY,itemViewW, kItemViewH);
            index ++;
        }
    }
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[CategoryProductViewCellModel class]]);
    self.cellModel = object;
    [self updateUI];
    [self setNeedsLayout];
}

-(void)updateUI
{
    NSInteger index = 0;
    for (NSInteger i = 0; i < [self.cellModel.products count]; i ++) {
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
        newItemView.delegate          = self;
        newItemView.tag               = index + kBaseTag;
        [self.contentView addSubview:newItemView];
        itemView = newItemView;
    }
    ProductOutline *product = [self.cellModel.products safeObjectAtIndex:index hintClass:[ProductOutline class]];
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
    return 0;
}
//index所在列，从0开始
+(NSInteger)columnOfItemView:(NSInteger)index
{
    return index%3;
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[CategoryProductViewCellModel class]], 0);
    CategoryProductViewCellModel *cellModel = object;
    CGFloat row = [[self class] rowOfItemView:[cellModel.products count] - 1];
    return (row + 1)*kItemViewH;
}


-(void)carouselItemViewDidSeleted:(CarouselItemView *)itemView product:(ProductOutline *)product
{
     [PRMBWantedOffice nativeArrestWarrant:APPURL_VIEW_IDENTIFIER_GOODDETAIL param:nil];
}
@end
