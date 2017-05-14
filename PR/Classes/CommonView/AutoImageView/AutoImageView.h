//
//  AutoImageView.h
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageInfo.h"

// 请注意: autoImageView 默认的 userInteractionEnabled 是为NO的，既点击是不会跳链接的。
//		  如果需要点击到链接，请打开 AutoImageView 的 userInteractionEnabled.
@interface AutoImageView : UIImageView
@property (nonatomic, strong) UIImage *defaultImage;

+ (CGSize)sizeTransformFrom:(ImageInfo *)imgInfo;
+ (CGSize)sizeTransformFrom:(ImageInfo *)imginfo restraintWidth:(NSInteger)width;

// 直接支持urlString的类型
- (void)setImgURLString:(NSString *)imgURLStr;

// 支持ImageInfo类型
- (void)setImgInfo:(ImageInfo *)theImgInfo;
- (void)setImgInfo:(ImageInfo *)sfImgInfo withPlaceholderImage:(UIImage *)placehoderImge;
- (void)setImgInfoWithPreventRepeatReq:(ImageInfo *)sfImgInfo;

/**
 *  使用资源限制的方式loading web image
 *
 *  @param imgInfo       需要loading 的 sf image 信息
 *  @param needRestrict    是否需要以资源限制方式loading
 *  @param placehoderImage 默认图片
 */
- (void)setImgInfo:(ImageInfo *)ImgInfo withResourceRestrict:(BOOL)needRestrict andPlacehodler:(UIImage *)placehoderImage;

/**
 *  解除对图片请求的 资源限制。
 *	如果没有图片，开始发起网络请求获取数据
 */
- (void)liftRestriction;
@end
