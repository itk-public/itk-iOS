//
//  AutoImageView.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "AutoImageView.h"
#import "ActionHandler.h"
#import "AutoOptionURL.h"
#import "SDImageViewShell.h"

@interface AutoImageView()
{
    ImageInfo *         _loadImgInfo;
    BOOL				_inImgLoadding;
}
@property(nonatomic,strong)ImageInfo * loadImgInfo;
@property(nonatomic,readwrite)BOOL  inImgLoadding;
@end

@implementation AutoImageView
@synthesize loadImgInfo = _loadImgInfo;
@synthesize inImgLoadding = _inImgLoadding;

+ (CGSize)sizeTransformFrom:(ImageInfo *)imgInfo
{
    if (nil == imgInfo)
    {
        return CGSizeMake(0, 0);
    }
    CGFloat scaleFactor = [UIScreen mainScreen].scale;
    
    return CGSizeMake(imgInfo.width / scaleFactor, imgInfo.height / scaleFactor);
}

+ (CGSize)sizeTransformFrom:(ImageInfo *)imginfo restraintWidth:(NSInteger)width
{
    if (nil == imginfo || width < 1 || imginfo.height < 1)
    {
        return CGSizeMake(0, 0);
    }
    
    CGFloat scaleFactor = width / imginfo.width;
    
    return CGSizeMake(width, imginfo.height * scaleFactor);
}


- (void)setLoadImgInfo:(ImageInfo *)newLoadImgInfo
{
    if(_loadImgInfo != newLoadImgInfo)
    {
        _loadImgInfo = newLoadImgInfo;
    }
}

- (ImageInfo *)loadImgInfo
{
    return _loadImgInfo;
}

- (void)setImgURLString:(NSString *)imgURLStr
{
    ImageInfo * imgInfo = [ImageInfo imageInfoWithImageURL:imgURLStr action:nil];
    [self setImgInfo:imgInfo];
}

- (void)setImgInfo:(ImageInfo *)theImgInfo
{
    // 显示内容
    [self setImgInfo:theImgInfo withPlaceholderImage:nil];
}

- (void)setImgInfo:(ImageInfo *)theImgInfo withPlaceholderImage:(UIImage *)placehoderImge
{
    // 显示内容
    if (placehoderImge == nil && self.defaultImage) {
        placehoderImge = self.defaultImage;
    }
    
    [self setLoadImgInfo:theImgInfo];
    AutoOptionURL * autoUrl = [AutoOptionURL optionURLWithImageURL:self.loadImgInfo.imgUrl];
    [self op_setImageWithAutoOptionURL:autoUrl placeholderImage:placehoderImge];
}

- (void)setImgInfoWithPreventRepeatReq:(ImageInfo *)imgInfo
{
    if ([self.loadImgInfo isEqual:imgInfo] && self.inImgLoadding)
    {
        return;
    }
    
    [self setLoadImgInfo:imgInfo];
    
    AutoOptionURL * autoUrl = [AutoOptionURL optionURLWithImageURL:self.loadImgInfo.imgUrl];
    _inImgLoadding = YES;
    [self op_setImageWithAutoOptionURL:autoUrl placeholderImage:self.defaultImage];
    _inImgLoadding = NO;
}

- (void)setImgInfo:(ImageInfo *)theImgInfo withResourceRestrict:(BOOL)needRestrict andPlacehodler:(UIImage *)placehoderImage
{
    CONDITION_CHECK_RETURN(NO == [self.loadImgInfo isEqual:theImgInfo]);
    
    if (placehoderImage == nil && self.defaultImage) {
        placehoderImage = self.defaultImage;
    }
    
    [self setLoadImgInfo:theImgInfo];
    
    AutoOptionURL * autoUrl = [AutoOptionURL optionURLWithImageURL:self.loadImgInfo.imgUrl];
    if (needRestrict)
    {
        [self op_setImageWithAutoOptionURL:autoUrl placeholderImage:placehoderImage];
    }else{
        [self op_setImageWithAutoOptionURL:autoUrl placeholderImage:placehoderImage];
    }
}

- (void)liftRestriction
{
    // 开始实际的图像请求。
    [self setImgInfo:self.loadImgInfo withPlaceholderImage:self.image];
}

- (void)openImageURL
{
    // 判断是否存在跳转连接。
    if (_loadImgInfo && [_loadImgInfo imageAction] != nil)
    {
        [[ActionHandler handlerWithAction:_loadImgInfo.imageAction] run];
    }
}

#pragma mark - init
- (void)doInit
{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImageURL)];
    [self addGestureRecognizer:tapGesture];
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self doInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self doInit];
    }
    return self;
}

@end

