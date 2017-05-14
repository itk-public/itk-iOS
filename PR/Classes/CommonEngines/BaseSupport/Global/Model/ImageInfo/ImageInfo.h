//
//  ImageInfo.h
//  PR
//
//  Created by 黄小雪 on 21/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class Action;
@interface ImageInfo : NSObject

@property (nonatomic,copy)   NSString   *imgUrl;   // 图片链接
@property (nonatomic,copy)   NSString   *referImg; // 本地映射的打包图片
@property (nonatomic,assign) CGFloat    width;     // 图片宽度
@property (nonatomic,assign) CGFloat    height;    // 图片高度
@property (nonatomic,retain) Action *   imageAction;  // 图片点击行为

+ (instancetype)imageInfoWithDic:(NSDictionary*)dic;

- (instancetype)initWithImageURL:(NSString *)imgURL;

+ (instancetype)imageInfoWithImageURL:(NSString *)imgURL action:(Action *)action;

@end
