//
//  FPCycleScrollView.m
//  YHClouds
//
//  Created by YH on 15/12/7.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "FPCycleScrollView.h"

#import "CycleScrollCell.h"
#import "YHPageControl.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "AppUIUtil.h"
#import "AutoOptionURL.h"


NSString * const ID = @"cycleCell";

@interface FPCycleScrollView() <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak)     UICollectionView            *mainView; // 显示图片的collectionView
@property (nonatomic, weak)     UICollectionViewFlowLayout  *flowLayout;
@property (nonatomic, strong)   NSMutableArray              *imagesGroup;
@property (nonatomic, weak)     NSTimer                     *timer;
@property (nonatomic, assign)   NSInteger                   totalItemsCount;
@property (nonatomic, weak)     UIControl                   *pageControl;
@property (nonatomic, weak)     UIImageView                 *backgroundImageView; // 当imageURLs为空时的背景图

@property (nonatomic, assign)   NSInteger                   networkFailedRetryCount;
@property (nonatomic, strong)   UIView                      *numberCountView;
@property (nonatomic, strong)   UILabel                     *numberLabel;
@property (nonatomic, assign)   BOOL                        leftView;
@property (nonatomic, assign)   NSInteger                   showPageIndex;
@property (nonatomic, assign)   BOOL                        isInfiniteLoopValid;
@property (nonatomic, assign)   BOOL                        isPosIniting;

@end

@implementation FPCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupMainView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
        [self setupMainView];
    }
    return self;
}

- (void)initialization
{
    _pageControlAliment         = SDCycleScrollViewPageContolAlimentCenter;
    _autoScrollTimeInterval     = 2.0;
    _titleLabelTextColor        = [UIColor whiteColor];
    _titleLabelTextFont         = KFontNormal(14);
    _titleLabelBackgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabelHeight           = 30;
    _autoScroll                 = YES;
    _infiniteLoop               = YES;
    _isInfiniteLoopValid        = NO;
    _showPageControl            = YES;
    _pageControlDotSize         = CGSizeMake(10, 10);
    _pageControlStyle           = SDCycleScrollViewPageContolStyleAnimated;
    _dotPosition                = SDCycleScrollviewDotPositionMiddle;
    _hidesForSinglePage         = YES;
    self.showPageIndex          = 0;
    self.backgroundColor        = [UIColor lightGrayColor];
    
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup
{
    FPCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.imagesGroup = [NSMutableArray arrayWithArray:imagesGroup];
    return cycleScrollView;
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLsGroup
{
    FPCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.imageURLStringsGroup = [NSMutableArray arrayWithArray:imageURLsGroup];
    return cycleScrollView;
}

// 设置显示图片的collectionView
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.frame.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[CycleScrollCell class] forCellWithReuseIdentifier:ID];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    [self addSubview:mainView];
    _mainView = mainView;
    [self addNumberCountView];
}

- (void)addNumberCountView
{
     CGFloat viewWidth              = 35 * DDDisplayScale;
     UIView * containView           = [[UIView alloc] initWithFrame:CGRectMake(self.width - viewWidth - 10, self.height - viewWidth - 10, viewWidth, viewWidth)];
     containView.backgroundColor    = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.3];
     containView.layer.cornerRadius = viewWidth / 2.0;
     containView.clipsToBounds      = YES;
     self.numberCountView           = containView;
     [self addSubview:self.numberCountView];
     
     UILabel * textLabel          = [[UILabel alloc] initWithFrame:containView.bounds];
     textLabel.backgroundColor    = [UIColor clearColor];
     textLabel.textAlignment      = NSTextAlignmentCenter;
     textLabel.font               = KFontNormal(15);
     textLabel.textColor          = UIColorFromRGB(0xf4f5f6);
     self.numberLabel             = textLabel;
     [self.numberCountView addSubview:self.numberLabel];
}


#pragma mark - properties
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _flowLayout.itemSize = self.frame.size;
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;

    if (!self.backgroundImageView) {
        UIImageView *bgImageView = [UIImageView new];
        [self insertSubview:bgImageView belowSubview:self.mainView];
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundImageView = bgImageView;
    }
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.backgroundImageView.image = placeholderImage;
    
}

- (void)setPageControlDotSize:(CGSize)pageControlDotSize
{
    _pageControlDotSize = pageControlDotSize;
    [self setupPageControl];
    if ([self.pageControl isKindOfClass:[YHPageControl class]]) {
        YHPageControl *pageContol = (YHPageControl *)_pageControl;
        pageContol.dotSize = pageControlDotSize;
    }
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    _pageControl.hidden = !showPageControl;
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    if ([self.pageControl isKindOfClass:[YHPageControl class]]) {
        YHPageControl *pageControl = (YHPageControl *)_pageControl;
        pageControl.dotColor = dotColor;
    } else {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPageIndicatorTintColor = dotColor;
    }
}

-(void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    if (_autoScroll) {
        [self setupTimer];
    }else{
        [self stopTimer];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:self.autoScroll];
}

- (void)setPageControlStyle:(SDCycleScrollViewPageContolStyle)pageControlStyle
{
    _pageControlStyle = pageControlStyle;
     if (self.pageControlStyle == SDCycleScrollViewPageContolStyleNumber) {
          self.numberCountView.hidden = NO;
     }else
     {
          self.numberCountView.hidden = YES;
     }
    [self setupPageControl];
}

- (void)setDotPosition:(SDCycleScrollviewDotPosition)dotPosition
{
    _dotPosition = dotPosition;
}

- (void)adjustInitImagePos
{
    if (self.isInfiniteLoopValid) {
        self.isPosIniting = YES;
         [self.mainView setContentOffset:CGPointMake(1 * self.flowLayout.itemSize.width, 0) animated:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           // [self.mainView setContentOffset:CGPointMake(1 * self.flowLayout.itemSize.width, 0) animated:NO];
            [self syncIndicatorIndex];
            self.isPosIniting = NO;
           
        });
    }else{
        self.isPosIniting = NO;
    }
}

- (void)setImagesGroup:(NSMutableArray *)imagesGroup
{
    
    if (_imagesGroup && imagesGroup && [_imagesGroup isEqual:imagesGroup]) {
        return;
    }
     _imagesGroup = imagesGroup;
    
    if (self.infiniteLoop == NO || self.imagesGroup.count < 2) {
        self.isInfiniteLoopValid = NO;
        _totalItemsCount = self.imagesGroup.count;
    }else{
        self.isInfiniteLoopValid = YES;
        _totalItemsCount = self.imagesGroup.count + 2;
    }
    
    if (imagesGroup.count != 1) {
        self.mainView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        self.mainView.scrollEnabled = NO;
    }
    
    [self setupPageControl];
    [self.mainView reloadData];
    [self adjustInitImagePos];
}

- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup
{
    if (_imageURLStringsGroup && imageURLStringsGroup && [_imageURLStringsGroup isEqual:imageURLStringsGroup]) {
        return;
    }
    
    _imageURLStringsGroup = imageURLStringsGroup;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:imageURLStringsGroup.count];
    for (int i = 0; i < imageURLStringsGroup.count; i++) {
        UIImage *image = [[UIImage alloc] init];
        [images addObject:image];
    }
    self.imagesGroup = images;
    [self loadImageWithImageURLsGroup:imageURLStringsGroup];
}

- (void)setLocalizationImagesGroup:(NSArray *)localizationImagesGroup
{
    _localizationImagesGroup = localizationImagesGroup;
    self.imagesGroup = [NSMutableArray arrayWithArray:localizationImagesGroup];
}

- (NSInteger)covertImageIndexWithCellIndex:(NSInteger)cellIndex
{
    if(self.infiniteLoop == NO || self.isInfiniteLoopValid == NO)
    {
        return cellIndex;
    }
    
    if (self.imagesGroup.count == 0) {
        return 0;
    }
    
    if (cellIndex == 0) {
        return self.imagesGroup.count - 1;
    }else{
        return (cellIndex - 1) % self.imagesGroup.count;
    }
}

#pragma mark - actions

- (void)loadImageWithImageURLsGroup:(NSArray *)imageURLsGroup
{
    for (int i = 0; i < imageURLsGroup.count; i++) {
        [self loadImageAtIndex:i];
    }
}

- (void)loadImageAtIndex:(NSInteger)index
{
    #warning 出现过数组下标越界的crash，暂时做一层保护
    if (index >= self.imageURLStringsGroup.count) {
        return;
    }
    
    NSString *urlStr = self.imageURLStringsGroup[index];
    
    AutoOptionURL * autoURL = nil;
    
    if ([urlStr isKindOfClass:[NSString class]]) {
        autoURL =  [AutoOptionURL optionURLWithImageURL:urlStr];//[NSURL URLWithString:urlStr];
    } else if ([urlStr isKindOfClass:[NSURL class]]) { // 兼容NSURL
        autoURL = [AutoOptionURL optionURLWithImageURL:[(NSURL *)urlStr absoluteString]];
    }
    
    NSURL * loadURL = [autoURL autoSelectedURL];
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[loadURL absoluteString]];
    if (image) {
        [self.imagesGroup setObject:image atIndexedSubscript:index];
    } else {
        [[SDWebImageManager sharedManager] downloadImageWithURL:loadURL options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image) {
                if (index < self.imageURLStringsGroup.count && [self.imageURLStringsGroup[index] isEqualToString:urlStr]) { // 修复频繁刷新异步数组越界问题
                    [self.imagesGroup setObject:image atIndexedSubscript:index];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.mainView reloadData];
                    });
                }
            } else {
                if (self.networkFailedRetryCount > 30) return;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self loadImageAtIndex:index];
                });
                self.networkFailedRetryCount++;
            }
        }];
    }
}

- (void)setupPageControl
{
    if (_pageControl) [_pageControl removeFromSuperview]; // 重新加载数据时调整
    
    if ((self.imagesGroup.count <= 1) && self.hidesForSinglePage) {
        if (_numberCountView != nil) {
            _numberCountView.hidden = YES;
        }
        return;
    }
    
    switch (self.pageControlStyle) {
        case SDCycleScrollViewPageContolStyleAnimated:
        {
            YHPageControl *pageControl  = [[YHPageControl alloc] init];
            pageControl.numberOfPages   = self.imagesGroup.count;
            pageControl.dotImage        = [UIImage imageNamed:@"dot_selected"];
            pageControl.currentDotImage = [UIImage imageNamed:@"dot_unselected"];
//            pageControl.dotColor = self.dotColor;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
            
        case SDCycleScrollViewPageContolStyleClassic:
        {
            UIPageControl *pageControl = [[UIPageControl alloc] init];
            pageControl.numberOfPages = self.imagesGroup.count;
            pageControl.currentPageIndicatorTintColor = self.dotColor;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
        default:
            break;
    }
}


- (void)automaticScroll
{
    if (1 >= _totalItemsCount) return;
    
    int currentIndex = floor(_mainView.contentOffset.x / _flowLayout.itemSize.width);
    if (currentIndex >= _totalItemsCount) {
        currentIndex = 0;
        [_mainView setContentOffset:CGPointZero animated:NO];
    }
    int targetIndex = currentIndex + 1;
    self.showPageIndex = targetIndex;
    //NSAssert(targetIndex < _totalItemsCount, @"这里不可能出现越界的");
    if (targetIndex < _totalItemsCount) {
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

- (void)setupTimer
{
    if (NO == self.autoScroll) {
        return;
    }
    
    [self stopTimer];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}
#pragma mark - life circles

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _mainView.frame = self.bounds;
    
    CGSize size = CGSizeZero;
    if ([self.pageControl isKindOfClass:[YHPageControl class]]) {
        YHPageControl *pageControl = (YHPageControl *)_pageControl;
        size = [pageControl sizeForNumberOfPages:self.imagesGroup.count];
    } else {
        size = CGSizeMake(self.imagesGroup.count * self.pageControlDotSize.width * 1.2, self.pageControlDotSize.height);
    }
    
    CGFloat x = (self.width - size.width) * 0.5;
    if (self.pageControlAliment == SDCycleScrollViewPageContolAlimentRight) {
        x = self.mainView.width - size.width - 10;
    }
    
    CGFloat y = self.mainView.height - size.height - 13*DDDisplayScale;
    if ([self.pageControl isKindOfClass:[YHPageControl class]]) {
        YHPageControl *pageControl = (YHPageControl *)_pageControl;
        [pageControl sizeToFit];
    }
    
    _pageControl.frame = CGRectMake(x, y, size.width, size.height);
    if (_dotPosition == SDCycleScrollviewDotPositionLeft) {
        self.pageControl.left = 12.5;
    }else if (_dotPosition == SDCycleScrollviewDotPositionMiddle) {
        // default
    }else if (_dotPosition == SDCycleScrollviewDotPositionRight) {
        self.pageControl.right = APPLICATIONWIDTH - 15.5;
    }
    _pageControl.hidden = !_showPageControl;
    
    if (self.backgroundImageView) {
        self.backgroundImageView.frame = self.bounds;
    }
    
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self stopTimer];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    if (newWindow) {
        if (self.isPosIniting) {
            return;
        }
//        CGFloat xOffset = self.showPageIndex * _flowLayout.itemSize.width;
//        if (xOffset >= _mainView.contentSize.width) {
//            xOffset = 0;
//        }
//        [self.mainView setContentOffset:CGPointMake(xOffset,0) animated:NO];
        [self checkoutInfiniteLoop];
        [self setupTimer];
    }else{
        [self stopTimer];
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _mainView.delegate = nil;
    _mainView.dataSource = nil;
}

#pragma mark - public actions
- (NSInteger)currentViewIndex
{
    if (self.imagesGroup.count > 0) {
        NSInteger itemIndex = (self.mainView.contentOffset.x + self.mainView.width * 0.5) / self.mainView.width;
        NSInteger indexOnPageControl = [self covertImageIndexWithCellIndex:itemIndex];
        return indexOnPageControl;
    }else{
        return 0;
    }
}
- (UIImage *)currentShownImage
{
    NSInteger index = [self currentViewIndex];
    if (self.imagesGroup.count > index) {
        return self.imagesGroup[index];
    }
    return nil;
}

-(void)setDotImageName:(NSString *)dotImageName currentDotImageName:(NSString *)currentDotImageName
{
    if (self.pageControlStyle == SDCycleScrollViewPageContolStyleAnimated) {
        ((YHPageControl *)self.pageControl).dotImage        =  [UIImage imageNamed:dotImageName];
        ((YHPageControl *)self.pageControl).currentDotImage =  [UIImage imageNamed:currentDotImageName];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CycleScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    long itemIndex = [self covertImageIndexWithCellIndex:indexPath.item];
    UIImage *image = [self.imagesGroup safeObjectAtIndex:itemIndex];
    if (image.size.width == 0 && self.placeholderImage) {
        image = self.placeholderImage;
        [self loadImageAtIndex:itemIndex];
    }
    cell.imageView.image = image;
    if (_titlesGroup.count) {
        cell.title = [_titlesGroup safeObjectAtIndex:itemIndex];
    }
    
    if (!cell.hasConfigured) {
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        cell.titleLabelHeight = self.titleLabelHeight;
        cell.titleLabelTextColor = self.titleLabelTextColor;
        cell.titleLabelTextFont = self.titleLabelTextFont;
        cell.hasConfigured = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        [self.delegate cycleScrollView:self didSelectItemAtIndex:[self covertImageIndexWithCellIndex:indexPath.item]];
    }
}



#pragma mark - UIScrollViewDelegate

- (void)checkoutInfiniteLoop
{
    CONDITION_CHECK_RETURN(self.infiniteLoop && self.isInfiniteLoopValid);
    // 判断是否到第一个或者最后一个
    CGFloat curXOffset = self.mainView.contentOffset.x;
    CGFloat oneCellWidth = self.flowLayout.itemSize.width;
    NSInteger allCellCount = 1 + self.imagesGroup.count + 1; // 左右各一个
    if (oneCellWidth < curXOffset && curXOffset < (allCellCount - 1) * oneCellWidth) {
        return;
    }
    
    // 判断是否需要循环到头了
    if (curXOffset < oneCellWidth) {
        CGFloat adjustOffset = curXOffset + self.imagesGroup.count * oneCellWidth;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mainView setContentOffset:CGPointMake(adjustOffset, 0) animated:NO];
        });
    }else if (curXOffset >= (allCellCount - 1) * oneCellWidth){
        CGFloat adjustOffset = curXOffset - self.imagesGroup.count * oneCellWidth;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mainView setContentOffset:CGPointMake(adjustOffset, 0) animated:NO];
        });
    }
}

- (void)syncIndicatorIndex
{
    int itemIndex = (self.mainView.contentOffset.x + self.mainView.width * 0.5) / self.mainView.width;
    if (!self.imagesGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int indexOnPageControl =(int) [self covertImageIndexWithCellIndex:itemIndex];
    
    if ([self.pageControl isKindOfClass:[YHPageControl class]]) {
        YHPageControl *pageControl = (YHPageControl *)_pageControl;
        pageControl.currentPage = indexOnPageControl;
    } else {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPage = indexOnPageControl;
    }
    
    if (self.pageControlStyle == SDCycleScrollViewPageContolStyleNumber) {
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] init];
        [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d", (indexOnPageControl + 1)] attributes:ATTR_DICTIONARY(UIColorFromRGB(0xf4f5f6), KFontNormal(15))]];
        [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"/" attributes:ATTR_DICTIONARY(UIColorFromRGB(0xf4f5f6), KFontNormal(15))]];
        [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)self.imagesGroup.count] attributes:ATTR_DICTIONARY(UIColorFromRGB(0xf4f5f6), KFontNormal(14))]];
        self.numberLabel.attributedText = attrStr;
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self syncIndicatorIndex];
    [self checkoutInfiniteLoop];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.embedViewType == SDEmbedViewGoodsDetail) {
    }
    
    [self setupTimer];
    
    if (NO == decelerate) {
        [self checkoutInfiniteLoop];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self checkoutInfiniteLoop];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self checkoutInfiniteLoop];
}


@end
