//
//  WTImageView.m
//  PR
//
//  Created by 黄小雪 on 2017/6/6.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTImageView.h"
#import "UIImageView+WebCache.h"

@implementation WTImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setUrlPath:(NSString *)urlPath
{
    _urlPath = [urlPath copy];
    [self sd_setImageWithURL:[NSURL URLWithString:self.urlPath]
            placeholderImage:self.defaultImage
                     options:SDWebImageAllowInvalidSSLCertificates
                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        
                    }
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       
                   }];
}

- (void)stopLoading
{
    [self sd_cancelCurrentImageLoad];
}

- (void)reload
{
    NSURL *imageURL = [NSURL URLWithString:self.urlPath];
    if (self.imageDidLoadHandler != NULL) {
        __weak typeof(self) weakSelf = self;
        [self sd_setImageWithURL:imageURL placeholderImage:nil options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error == nil) {
                weakSelf.imageDidLoadHandler(weakSelf, image);
            }else{
                 PRLOG(@"加载图片成功=====%@",error);
            }
        }];
//        [self sd_setImageWithURL:imageURL placeholderImage:self.defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
//            PRLOG(@"加载图片成功=====%@",error);
//            if (error == nil) {
//                weakSelf.imageDidLoadHandler(weakSelf, image);
//            }
//        }];
    } else {
        [self sd_setImageWithURL:imageURL placeholderImage:self.defaultImage];
    }
}

- (void)unsetImage
{
    self.image = nil;
}


@end
