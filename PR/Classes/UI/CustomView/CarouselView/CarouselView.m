//
//  CarouselView.m
//  YHClouds
//
//  Created by 黄小雪 on 08/03/2017.
//  Copyright © 2017 YH. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselItemView.h"
#import "ProductInfo.h"


#define KTopMargin       10
#define kBaseTag         1000

@interface CarouselView()<UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView   *scrollView;
@property (strong,nonatomic) NSMutableArray *inUseViews;
@property (strong,nonatomic) NSMutableArray *unUseViews;
@property (assign,nonatomic) NSInteger      maxVisibleIndex;
@property (assign,nonatomic) NSInteger      minVisibleIndex;
@property (strong,nonatomic) NSArray        *dataList;
@property (assign,nonatomic) CGFloat        lastOffsetX;

//@property (strong,nonatomic) UIPageControl *pageControl;

@end

@implementation CarouselView
-(instancetype)init{
    if (self = [super init]) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        _inUseViews = [NSMutableArray array];
        _unUseViews = [NSMutableArray array];
        
        _maxVisibleIndex = 0;
        _minVisibleIndex = 0;
        
        //        _pageControl = [[UIPageControl alloc]init];
        //        [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
        //        [_pageControl setBackgroundColor:[UIColor orangeColor]];
        //        [self addSubview:_pageControl];
        //        [self bringSubviewToFront:_pageControl];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //    self.pageControl.frame = CGRectMake(0, 0, 100, 100);
    self.scrollView.contentSize = CGSizeMake([self.dataList count]*kCarouselItemViewW+ ([self.dataList count]+1)*kLeftMargin,self.height);
    self.scrollView.frame = self.bounds;
    for (CarouselItemView *itemView in self.scrollView.subviews) {
        if ([itemView isKindOfClass:[CarouselItemView class]]) {
            CGFloat kItemViewX = kLeftMargin*(itemView.tag - kBaseTag + 1) + kCarouselItemViewW*(itemView.tag - kBaseTag);
            itemView.frame = CGRectMake(kItemViewX, KTopMargin,kCarouselItemViewW, self.scrollView.height - 2*KTopMargin);
        }
    }
}


-(void)setUpDatalist:(NSArray *)dataList{
    CONDITION_CHECK_RETURN([dataList isKindOfClass:[NSArray class]] && [dataList count]);
    self.dataList  = dataList;
    //    self.pageControl.numberOfPages = [self.dataList count];
    //    self.pageControl.currentPage   = 0;
    if ([self.inUseViews count]) {
        for (CarouselItemView *itemView in self.inUseViews) {
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
    //    self.pageControl.currentPage = self.minVisibleIndex;
    for (NSInteger i = self.minVisibleIndex ; i <= self.maxVisibleIndex ;i ++) {
        [self addSubViewToScrollViewWithTag:i];
    }
}


-(NSInteger)viewMaxNum
{
    NSInteger kScrollViewW = ScreenWidth;
    NSInteger viewMaxNum   = 0;
    if (kCarouselItemViewW && (kScrollViewW%kCarouselItemViewW)) {
        viewMaxNum = kScrollViewW/kCarouselItemViewW + 3;
    }else{
        viewMaxNum = kScrollViewW/kCarouselItemViewW + 2;
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
        ProductInfo *model = [self.dataList safeObjectAtIndex:i hintClass:[ProductInfo class]];
        if (model) {
            CarouselItemView *itemView = [self inUseViewWithTag:i + kBaseTag];
            if (itemView == nil) {
                itemView = [self getReuseView];
                if (itemView == nil) {
                    itemView     = [[CarouselItemView alloc]init];
                }
                itemView.tag = kBaseTag + i;
                [self.scrollView addSubview:itemView];
                [self.inUseViews addObject:itemView];
            }
            [itemView setObject:model];
        }
    }
    
}


//移走不可见的View
-(void)removeUnVisibleView
{
    NSArray *tempArray = [NSArray arrayWithArray:self.inUseViews];
    for (CarouselItemView *subview in tempArray) {
        if ([subview isKindOfClass:[CarouselItemView class]]) {
            if (!CGRectIntersectsRect(self.scrollView.bounds,subview.frame) ) {
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
    if ([self inUseViewWithTag:tag] == nil){
        CarouselItemView *itemView = [self getReuseView];
        if (itemView) {
            itemView.tag   = tag + kBaseTag;
            CGFloat kItemViewX = kLeftMargin*(tag + 1) + kCarouselItemViewW *tag;
            itemView.frame = CGRectMake(kItemViewX, KTopMargin,kCarouselItemViewW , self.scrollView.height - 2*KTopMargin);
            [self.scrollView addSubview:itemView];
            ProductInfo  *model = [self.dataList safeObjectAtIndex:tag
                                                           hintClass:[ProductInfo  class]];
            [itemView setObject:model];
            [self.inUseViews addObject:itemView];
        }
    }
    
}

//当前可见view的最小的tag
-(NSInteger)getMinVisibleIndex
{
    NSInteger tempIndex = 0;
    NSInteger tempX = self.scrollView.bounds.origin.x - 1;
    if (tempX%(kCarouselItemViewW + kLeftMargin)) {
        tempIndex = tempX/(kCarouselItemViewW  + kLeftMargin);
    }else{
        tempIndex = tempX/(kCarouselItemViewW + kLeftMargin) - 1;
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
    NSInteger tempX = self.scrollView.bounds.origin.x + 1 +
    self.scrollView.bounds.size.width;
    if (tempX%(kCarouselItemViewW + kLeftMargin)) {
        tempIndex = tempX/(kCarouselItemViewW  + kLeftMargin);
    }else{
        tempIndex = tempX/(kCarouselItemViewW  + kLeftMargin) - 1;
    }
    if (tempIndex > [self.dataList count] - 1) {
        tempIndex = [self.dataList count] -1;
    }
    return tempIndex;
}


-(CarouselItemView *)inUseViewWithTag:(NSInteger)tag
{
    for (CarouselItemView *itemView in self.inUseViews) {
        if (itemView.tag == tag + kBaseTag) {
            return itemView;
        }
    }
    return nil;
}

//获取复用的view
-(CarouselItemView *)getReuseView
{
    CarouselItemView *reuseView = nil;
    if ([self.unUseViews count]) {
        reuseView = [self.unUseViews objectAtIndex:0];
        [self.unUseViews removeObject:reuseView];
    }
    if ([reuseView isKindOfClass:[CarouselItemView class]]) {
        return reuseView;
    }
    return nil;
}

-(void)orderItemViewLeftSwipe:(CarouselItemView *)itemView
{
    CGFloat currentOffX = self.scrollView.contentOffset.x;
    [self.scrollView setContentOffset:CGPointMake(currentOffX + 290, self.scrollView.contentOffset.y)];
}


@end
