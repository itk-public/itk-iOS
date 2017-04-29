//
//  SDImageViewShell.m
//  Fanli
//
//  Created by biqiang.lai on 18/7/14.
//  Copyright (c) 2014 www.fanli.com. All rights reserved.
//

#import "SDImageViewShell.h"
#import "SDImageCache.h"
#import "Utilities.h"
#import "UIImage+WebP.h"

#define SHOWCALLINFO       
// YHLogVerbose(@"_______%@",self);

@implementation SDWebImageLibraryManager

+ (void)initLibrary
{
	[[[SDWebImageManager sharedManager] imageCache] setMaxMemoryCost:20*1024*1024];
	[[[SDWebImageManager sharedManager] imageCache] setMaxCacheSize:50*1024*1024];
}

@end


#define kImageActViewTag 123434
@interface UIImageView (SDImageViewShell_hide)
@property(nonatomic,strong)NSOperation * queryOperation;
@property(nonatomic,strong)AutoOptionURL * queryImageURL;
@end


@implementation UIImageView (SDImageViewShell)

- (void)op_setImageWithURL:(NSURL *)url
{
	[self op_setImageWithURL:url placeholderImage:nil];
}

- (void)op_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
	// 第一次开始请求 image 的时候，初始化以下 sdwebimage library.
	// 当然如果，程序直接调用  sd_setImageWithURL 的方法，那么这个 initLibrary 就调用不到了。
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[SDWebImageLibraryManager initLibrary];
	});
	
	[self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:SDWebImageRetryFailed|SDWebImageProgressiveDownload
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
    }];
}

- (void)cancelCurrentImageLoad
{
	[self sd_cancelCurrentImageLoad];
}

#pragma mark -
#pragma mark Optimization function

static char * QUERYOPERKEY = "QUERYOPERKEY";
static char * QUERYAUTOURL = "QUERYAUTOURL";

- (NSOperation *)queryOperation
{
    return objc_getAssociatedObject(self, QUERYOPERKEY);
}

- (void)setQueryOperation:(NSOperation *)queryOperation
{
    objc_setAssociatedObject(self, QUERYOPERKEY, queryOperation, OBJC_ASSOCIATION_RETAIN);
}

- (AutoOptionURL *)queryImageURL
{
     return objc_getAssociatedObject(self, QUERYAUTOURL);
}

- (void)setQueryImageURL:(AutoOptionURL *)imgAutoURL
{
    objc_setAssociatedObject(self, QUERYAUTOURL, imgAutoURL, OBJC_ASSOCIATION_RETAIN);

}

- (void)op_setImageWithWifiURL:(NSURL *)wifiUrl  andWWANURL:(NSURL *)wwanUrl
{
    AutoOptionURL * optionUrl = [AutoOptionURL optionUrlInWifi:[wifiUrl absoluteString] andInWWAN:[wwanUrl absoluteString]];
    [self op_setImageWithAutoOptionURL:optionUrl placeholderImage:nil];
}


- (void)op_loadImage:(NSURL *)imgurl
       plcaeholder:(UIImage *)placeholderImage
       withOption:(SDWebImageOptions)option
{
    [self sd_setImageWithURL:imgurl
            placeholderImage:placeholderImage
                     options:option
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       SHOWCALLINFO
                       // 如果网络图片回来的更早，则取消掉读取文件的 operation
                       if (image && nil == error)
                       {
                           [self.queryOperation cancel];
                           self.image = image;
                       }
                   }];
}

- (void)op_loadPreViewImageFirst:(AutoOptionURL *)optionUrl
            plcaeholder:(UIImage *)placeholderImage
{
    [self sd_setImageWithURL:optionUrl.urlUponWWAN
            placeholderImage:placeholderImage
                     options:SDWebImageHighPriority
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       SHOWCALLINFO
                       // 如果网络图片回来的更早，则取消掉读取文件的 operation
                       if (image && nil == error)
                       {
                           [self.queryOperation cancel];
                           self.queryOperation = nil;
                           self.image = image;
                       }
                       
                       SDWebImageOptions wifiOption = SDWebImageRetryFailed;
                       if (error) {
                           wifiOption |= SDWebImageProgressiveDownload;
                       }
                       
                       dispatch_async(dispatch_get_main_queue(), ^{
                           SHOWCALLINFO
                           UIImage * fixPlaceHoderImg = placeholderImage;
                           if (image) {
                               fixPlaceHoderImg = image;
                           }
                           [self op_loadImage:optionUrl.urlUponWifi plcaeholder:fixPlaceHoderImg withOption:wifiOption];
                       });
                       
                   }];
}


- (void)op_loadWIFIImageUnderAutoURL:(AutoOptionURL *)optionUrl
                      placeholder:(UIImage *)placeholderImage
                          choosed:(NSURL *)selectedUrl
{
    if (optionUrl.urlUponWWAN && optionUrl.urlUponWWAN != selectedUrl) {
        [self op_loadPreViewImageFirst:optionUrl plcaeholder:placeholderImage];
    }else{
        [self op_setImageWithURL:selectedUrl placeholderImage:placeholderImage];
    }
}


- (void)op_setImageWithAutoOptionURL:(AutoOptionURL *)optionUrl placeholderImage:(UIImage *)placeholderImage
{
    BOOL isEqual = [self.queryImageURL isEqual:optionUrl];
    if (isEqual) {
        return;
    }
    [self setQueryImageURL:optionUrl];

    NSURL * selectedUrl = [optionUrl autoSelectedURL];
    SHOWCALLINFO
    // 取消之前rt_请求的图片
    [self.queryOperation cancel];
    [self sd_cancelCurrentImageLoad];
    
    // 无论哪种情况下，只要wifi图片存在，直接使用即可。
    self.queryOperation = [[SDImageCache sharedImageCache] queryDiskCacheForKey:[optionUrl.urlUponWifi absoluteString] done:^(UIImage *image, SDImageCacheType cacheType)
                           {
                               SHOWCALLINFO
                               if (image)
                               {
                                   self.image = image;
                               }else{
                                   SHOWCALLINFO
                                   // wifi下无缓存图片，需要做两步考虑
                                   // 如果需要WWAN的图，直接使用即可。
                                   if (selectedUrl == optionUrl.urlUponWWAN)
                                   {
                                       [self op_setImageWithURL:selectedUrl placeholderImage:placeholderImage];
                                   }else{
                                       SHOWCALLINFO
                                       [self op_loadWIFIImageUnderAutoURL:optionUrl placeholder:placeholderImage choosed:selectedUrl];
                                   }
                               }
                               
                           }];
    
    if (self.queryOperation)
    {
        self.image = placeholderImage;
    }
}


@end
