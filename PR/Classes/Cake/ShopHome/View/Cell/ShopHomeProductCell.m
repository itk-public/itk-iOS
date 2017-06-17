//
//  ShopHomeProductCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeProductCell.h"
#import "AutoImageView.h"
#import "ShopHomeSingleProductView.h"

#define  kBaseTag   10000
@implementation ShopHomeProductCellModel
-(instancetype)init
{
    if(self = [super init]){
        _products = [NSMutableArray array];
    }
    return self;
}

@end

@interface  ShopHomeProductCell()
@property (strong,nonatomic) ShopHomeProductCellModel *cellModel;

@end

@implementation ShopHomeProductCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:kVCViewBGColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat itemViewW = (self.width - kMiddleMargin)/2.0;
    NSInteger index = 0;
    for (ShopHomeSingleProductView *itemView in self.contentView.subviews) {
        if ([itemView isKindOfClass:[ShopHomeSingleProductView class]]) {
            CGFloat row = [[self class] rowOfItemView:index];
            CGFloat column = [[self class] columnOfItemView:index];
            CGFloat itemViewX = kMiddleMargin * column  + itemViewW * column;
            CGFloat itemViewH = [ShopHomeSingleProductView  heightWithProduct:self.cellModel.products[index]];
            CGFloat itemViewY = row * itemViewH;
            itemView.frame = CGRectMake(itemViewX, itemViewY,itemViewW, itemViewH);
            index ++;
        }
    }
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[ShopHomeProductCellModel class]]);
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

-(ShopHomeSingleProductView *)findCarouseItemView:(NSInteger)index
{
    ShopHomeSingleProductView *itemView = (ShopHomeSingleProductView *)[self.contentView findASubViewWithTag:index+kBaseTag];
    return itemView;
    
}

-(void)addCarouseItemView:(NSInteger)index
{
    ShopHomeSingleProductView *itemView = [self findCarouseItemView:index];
    if (itemView == nil) {
        ShopHomeSingleProductView *newItemView = [[ShopHomeSingleProductView alloc]init];
//        newItemView.delegate          = self;
        newItemView.tag               = index + kBaseTag;
        [self.contentView addSubview:newItemView];
        itemView = newItemView;
    }
    ProductOutline *product = [self.cellModel.products safeObjectAtIndex:index hintClass:[ProductOutline class]];
    if (product) {
        [itemView setProduct:product];
    }
}

-(void)removeUnUseCarouseItemView:(NSInteger)index
{
    while (true) {
        ShopHomeSingleProductView *unUseItemView = [self findCarouseItemView:index];
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
    return index%2;
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[ShopHomeProductCellModel class]], 0);
    ProductOutline *product = [[(ShopHomeProductCellModel *)object products] objectAtIndex:0];
    return [ShopHomeSingleProductView heightWithProduct:product];
}

@end
