//
//  WTImageView.h
//  PR
//
//  Created by 黄小雪 on 2017/6/6.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTImageView;

typedef void(^WTImageViewDidLoadImage)(WTImageView *imageView, UIImage *image);

//__attribute__((deprecated(" use AutoImageView replace.")))
@interface WTImageView : UIImageView

@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, strong) WTImageViewDidLoadImage imageDidLoadHandler;

- (void)stopLoading;

- (void)reload;

- (void)unsetImage;

@end
