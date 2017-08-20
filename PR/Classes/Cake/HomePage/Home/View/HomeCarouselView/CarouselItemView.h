//
//  CarouselItemView.h
//  PR
//
//  Created by 黄小雪 on 10/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselView.h"
@class ProductOutline;
#define kLeftMargin 15
#define kCarouselItemViewW  65
@class CarouselItemView;
@protocol CarouselItemViewDelegate  <NSObject>
-(void)carouselItemViewDidSeleted:(CarouselItemView *)itemView product:(ProductOutline *)product;
@end


@interface CarouselItemView : CarouselSingleView
-(void)setImageUrl:(NSString *)imageurl
             title:(NSString *)title
             index:(NSInteger)index;
@property (weak,nonatomic) id<CarouselItemViewDelegate> delegate;
-(void)setObject:(id)object;
@end
