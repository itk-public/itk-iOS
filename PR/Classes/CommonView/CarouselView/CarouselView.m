//
//  CarouselView.m
//  YHClouds
//
//  Created by 黄小雪 on 08/03/2017.
//  Copyright © 2017 YH. All rights reserved.
//

#import "CarouselView.h"
//#import "ShopHomeSingleCouponView.h"

#define KTopMargin       15
#define kBaseTag         1000
#define kLeftMargin      15

@implementation CarouselSingleView
-(void)setModel:(CarouselSingleViewModel *)model
{
    CONDITION_CHECK_RETURN([model isKindOfClass:[CarouselSingleViewModel class]]);
    _model = model;
}
@end

@implementation CarouselSingleViewModel
@end

@interface CarouselView()<UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView   *scrollView;
@property (strong,nonatomic) NSMutableArray *inUseViews;
@property (strong,nonatomic) NSMutableArray *unUseViews;
@property (assign,nonatomic) NSInteger      maxVisibleIndex;
@property (assign,nonatomic) NSInteger      minVisibleIndex;
@property (strong,nonatomic) NSArray        *dataList;

@end

@implementation CarouselView
-(instancetype)init{
    if (self = [super init]) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.clipsToBounds = NO;
        [self addSubview:_scrollView];
        
        _inUseViews = [NSMutableArray array];
        _unUseViews = [NSMutableArray array];
        
        _maxVisibleIndex = 0;
        _minVisibleIndex = 0;
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    NSInteger orderItemViewW = self.singleViewW;
    NSInteger orderItemLeftMargin = kLeftMargin;
    self.scrollView.contentSize = CGSizeMake([self.dataList count]*(orderItemViewW + orderItemLeftMargin) + orderItemLeftMargin,self.height);
    self.scrollView.frame = self.bounds;
    self.scrollView.width =  self.width;
    for (CarouselSingleView*itemView in self.scrollView.subviews) {
        if ([itemView isKindOfClass:[CarouselSingleView class]]) {
            CGFloat kItemViewX = orderItemLeftMargin*(itemView.tag - kBaseTag + 1) + orderItemViewW*(itemView.tag - kBaseTag);
            itemView.frame = CGRectMake(kItemViewX, KTopMargin,orderItemViewW, self.scrollView.height - 2*KTopMargin);
        }
    }
}


-(void)setUpDatalist:(NSArray *)dataList{
   CONDITION_CHECK_RETURN([dataList isKindOfClass:[NSArray class]] && [dataList count]);
    self.dataList  = dataList;
    if ([self.inUseViews count]) {
        for (CarouselSingleView *itemView in self.inUseViews) {
            [itemView removeFromSuperview];
        }
        [self.unUseViews addObjectsFromArray:self.inUseViews];
        [self.inUseViews removeAllObjects];
    }
    for (NSInteger i = [dataList count]; i <[self.unUseViews count]; i ++) {
        [self.unUseViews removeObjectAtIndex:i];
    }
    [self setUpScrollView];
    [self setNeedsLayout];
    [self performSelector:@selector(removeUnVisibleView) withObject:nil afterDelay:0];
}


#pragma mark scrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.bounds.origin.x <= 0 ||
        scrollView.bounds.origin.x + scrollView.bounds.size.width>= scrollView.contentSize.width) {
        return;
    }
    if ((self.maxVisibleIndex == [self getMaxVisibleIndex] &&
         self.minVisibleIndex == [self getMinVisibleIndex]) ||
        [self getMaxVisibleIndex] > [self.dataList count] -1) {
        return;
    }
    [self removeUnVisibleView];
    self.minVisibleIndex = [self getMinVisibleIndex];
    self.maxVisibleIndex = [self getMaxVisibleIndex];
    for (NSInteger i = self.minVisibleIndex ; i <= self.maxVisibleIndex ;i ++) {
        [self addSubViewToScrollViewWithTag:i];
    }
}

-(NSInteger)viewMaxNum
{
    NSInteger kScrollViewW = ScreenWidth;
    NSInteger viewMaxNum   = 0;
    NSInteger orderItemViewW = self.singleViewW;
    if (orderItemViewW && (kScrollViewW%orderItemViewW)) {
        viewMaxNum = kScrollViewW/orderItemViewW + 3;
    }else{
        viewMaxNum = kScrollViewW/orderItemViewW + 2;
    }
    if (viewMaxNum > [self.dataList count] ) {
        viewMaxNum = [self.dataList count];
    }
    
    return viewMaxNum;
}

-(void)setUpScrollView
{
    [self.scrollView setContentOffset:CGPointZero];
    NSInteger viewMaxNum = [self viewMaxNum];
    for (NSInteger i = 0;  i < viewMaxNum; i++) {
        CarouselSingleViewModel *model = [self.dataList safeObjectAtIndex:i hintClass:[CarouselSingleViewModel class]];
        if (model) {
            CarouselSingleView *itemView = [self inUseViewWithTag:i + kBaseTag];
            if (itemView == nil) {
                itemView = [self getReuseView];
                if (itemView == nil) {
                    itemView     =  [[self.carouselSingleViewClass alloc]init];
                }
                itemView.tag = kBaseTag + i;
                [self.scrollView addSubview:itemView];
                [self.inUseViews addObject:itemView];
            }
            [itemView setModel:model];
        }
    }
    
}


//移走不可见的View
-(void)removeUnVisibleView
{
    NSArray *tempArray = [NSArray arrayWithArray:self.inUseViews];
    for (CarouselSingleView *subview in tempArray) {
        CGRect temp =  CGRectMake(self.scrollView.bounds.origin.x, self.scrollView.bounds.origin.y, self.scrollView.bounds.size.width  , self.scrollView.bounds.size.height);
        if ([subview isKindOfClass:[CarouselSingleView class]]) {
            if (!CGRectIntersectsRect(temp,subview.frame) ) {
                [subview removeFromSuperview];
                [self.unUseViews addObject:subview];
                if ([self.inUseViews containsObject:subview]) {
                    [self.inUseViews removeObject:subview];
                }
            }
        }
    }
}


-(void)addSubViewToScrollViewWithTag:(NSInteger)tag
{
    NSInteger orderItemViewW = self.singleViewW;
    NSInteger orderItemLeftMargin = 15;
    if ([self inUseViewWithTag:tag] == nil){
        CarouselSingleView *itemView = [self getReuseView];
        if (itemView) {
            itemView.tag   = tag + kBaseTag;
            CGFloat kItemViewX = orderItemLeftMargin*(tag + 1) + orderItemViewW*tag;
            itemView.frame = CGRectMake(kItemViewX, KTopMargin,orderItemViewW, self.scrollView.height - 2*KTopMargin);
            [self.scrollView addSubview:itemView];
             CarouselSingleViewModel *model = [self.dataList safeObjectAtIndex:tag
                                                            hintClass:[CarouselSingleViewModel class]];
            [itemView setModel:model];
            [self.inUseViews addObject:itemView];
        }
    }
    
}

//当前可见view的最小的tag
-(NSInteger)getMinVisibleIndex
{
    NSInteger tempIndex = 0;
    NSInteger orderItemViewW = self.singleViewW;
    NSInteger tempX = self.scrollView.bounds.origin.x - 1;
    NSInteger orderItemLeftMargin = 15;
    if (tempX%(orderItemViewW + orderItemLeftMargin)) {
        tempIndex = tempX/(orderItemViewW + orderItemLeftMargin);
    }else{
         tempIndex = tempX/(orderItemViewW + orderItemLeftMargin) - 1;
    }
    if (tempIndex < 0) {
        tempIndex = 0;
    }
    return tempIndex;
    
}

//当前可见的view的最大的tag
-(NSInteger)getMaxVisibleIndex
{
    NSInteger tempIndex = 0;
    NSInteger orderItemViewW = self.singleViewW;
    NSInteger tempX = self.scrollView.bounds.origin.x  +
    self.scrollView.bounds.size.width ;
    NSInteger orderLeftMarign = 15;
    if (tempX%(orderItemViewW + orderLeftMarign)) {
        tempIndex = tempX/(orderItemViewW+ orderLeftMarign);
    }else{
         tempIndex = tempX/(orderItemViewW + orderLeftMarign) - 1;
    }
    if (tempIndex > [self.dataList count] - 1) {
        tempIndex = [self.dataList count] -1;
    }
    return tempIndex;
}


-(CarouselSingleView *)inUseViewWithTag:(NSInteger)tag
{
    for (CarouselSingleView *itemView in self.inUseViews) {
        if (itemView.tag == tag + kBaseTag) {
            return itemView;
        }
    }
    return nil;
}

//获取复用的view
-(CarouselSingleView *)getReuseView
{
    CarouselSingleView *reuseView = nil;
    if ([self.unUseViews count]) {
        reuseView = [self.unUseViews objectAtIndex:0];
        [self.unUseViews removeObject:reuseView];
    }
    if ([reuseView isKindOfClass:[CarouselSingleView class]]) {
        return reuseView;
    }
    return nil;
}


@end
