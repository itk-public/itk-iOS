//
//  ShopHomeSectionHeaerView.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeSectionHeaerView.h"
#import "SingleIconView.h"
#import "DMExhibitItem.h"

#define kBaseTag  100000

@interface ShopHomeSectionHeaerView()
@property (strong,nonatomic) NSMutableArray *dataSoure;
@property (strong,nonatomic) SingleIconView *highlightIconView;
@end
@implementation ShopHomeSectionHeaerView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor darkGrayColor]];
        [self adjustData];
        [self addSingleIconView];
    }
    return self;
}

-(void)adjustData
{
    if (self.dataSoure == nil) {
        self.dataSoure = [NSMutableArray arrayWithCapacity:4];
    }else{
        [self.dataSoure removeAllObjects];
    }
    NSArray *tempArray = @[@{@"title":@"店铺首页"},@{@"title":@"全部商品"},@{@"title":@"最新上架"},@{@"title":@"促销商品"}];
    for (NSDictionary *dict in tempArray) {
        [self.dataSoure safeAddObject:[DMExhibitItem modelFromDictionary:dict]];
    }
}

-(void)addSingleIconView
{
    NSInteger i = 0;
    for (DMExhibitItem *item in self.dataSoure) {
        if ([item isKindOfClass:[DMExhibitItem class]]) {
            SingleIconView *iconView = [[SingleIconView alloc]init];
            iconView.returnBlock     = ^{
            };
            [iconView setItem:item];
            [self.contentView addSubview:iconView];
            if (i == 0) {
                self.highlightIconView = iconView;
            }
            i ++;
        }
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    if ([self.contentView.subviews count]) {
        CGFloat kMargin = 15;
        CGFloat kIconW  = (self.width - ([self.dataSoure count] + 1)*kMargin)*1.0/[self.dataSoure count];
        NSInteger tempCount = 0;
        for (SingleIconView *item in self.contentView.subviews) {
            if ([item isKindOfClass:[SingleIconView class]]) {
                item.frame = CGRectMake((tempCount+1) * kMargin + tempCount * kIconW,0,kIconW , self.height);
                tempCount ++;
            }
        }
    }
}

+(CGFloat)height
{
    return 80;
}

@end
