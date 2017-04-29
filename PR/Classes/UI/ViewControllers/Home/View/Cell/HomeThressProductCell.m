//
//  HomeProductCell.m
//  PR
//
//  Created by 黄小雪 on 06/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "HomeThressProductCell.h"
#import "ProductImageView2.h"
#import "DynamicUIModel.h"
#import "ProductInfo.h"

#define kBaseTag 1000
#define kProudctViewH (180*DDDisplayScale)
@interface HomeThressProductCell()
@property (strong,nonatomic) NSMutableArray *reusePool;
@property (strong,nonatomic) UIView *containView;
@end

@implementation HomeThressProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _containView = [[UIView alloc]init];
        [_containView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_containView];
    }
    return self;
}
-(NSMutableArray *)reusePool
{
    if (!_reusePool) {
        _reusePool = [NSMutableArray arrayWithCapacity:3];
    }
    return _reusePool;
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[DynamicCardItem class]]);
    DynamicCardItem *cardItem = (DynamicCardItem *)object;
    NSArray *products = cardItem.data;
    [self addProductView:products];
    
}

-(void)addProductView:(NSArray *)products
{
    NSInteger index = 0;
    for (ProductInfo *info in products) {
        if ([info isKindOfClass:[ProductInfo class]]) {
            ProductImageView2 *productView = (ProductImageView2 *)[self.containView findASubViewWithTag:index + kBaseTag];
            if (productView == nil) {
                productView = [[ProductImageView2 alloc]init];
                productView.tag = index + kBaseTag;
                [self.containView addSubview:productView];
            }
            [productView setInfo:info];
            index ++;
        }
    }
    [self removeUnUseView:index];
}


-(void)removeUnUseView:(NSInteger)index
{
    while (true) {
        ProductImageView2 *productView = (ProductImageView2 *)[self.containView findASubViewWithTag:index + kBaseTag];
        if (productView == nil) {
            break;
        }else{
            [productView removeFromSuperview];
            index ++;
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kMargin = 5;
    CGFloat kProductViewW = (self.width - 2*kMargin)/3.0;
    for (ProductImageView2 *productView in self.containView.subviews) {
        NSInteger row = (productView.tag - kBaseTag)/3;
        NSInteger column = (productView.tag - kBaseTag)%3;
        CGFloat productViewX = column*kProductViewW + (column + 1)*kMargin;
        CGFloat productViewY =  row*(kProudctViewH + kMargin);
        productView.frame = CGRectMake(productViewX, productViewY, kProductViewW, kProudctViewH);
        if (productView.tag == kBaseTag) {
            [productView setBackgroundColor:[UIColor magentaColor]];
        }
    }
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[DynamicCardItem class]], 0);
    DynamicCardItem *cardItem = (DynamicCardItem *)object;
    NSArray *products = cardItem.data;
    NSInteger row     = 0;
    if ([products count]%3) {
        row =  [products count]/3 + 1;
    }else{
        row = [products count]/3;
    }
    return kProudctViewH * row;
    
}
@end
