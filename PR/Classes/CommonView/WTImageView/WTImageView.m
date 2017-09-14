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
                     options:SDWebImageAllowInvalidSSLCertificates | SDWebImageRetryFailed
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
        [self sd_setImageWithURL:imageURL placeholderImage:self.defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            if (error == nil) {
                weakSelf.imageDidLoadHandler(weakSelf, image);
                NSLog(@"图片加载成功了=====11111");
            }else{
                NSLog(@"图片加载失败了=====%@",error);
            }
        }];
    } else {
        [self sd_setImageWithURL:imageURL placeholderImage:self.defaultImage];
    }
}

- (void)unsetImage
{
    self.image = nil;
}

@end
