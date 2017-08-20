//
//  FarmSearchProudctHeaderView.h
//  PR
//
//  Created by 黄小雪 on 2017/8/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FarmSearchBtnType)
{
    FarmSearchBtnTypeComprehensive,
    FarmSearchBtnTypeSales,
    FarmSearchBtnTypePriceRise,
    FarmSearchBtnTypePriceReduce,
};

@protocol  FarmSearchProudctHeaderViewDelegate <NSObject>
-(void)farmSearchProudctHeaderViewDidSelectedBtnType:(FarmSearchBtnType)type;
@end

@interface FarmSearchProudctHeaderView : UIView
@property (weak,nonatomic) id<FarmSearchProudctHeaderViewDelegate> delegate;
+(CGFloat)getHeight;
-(void)setComprehensiveHighlighted;
@end
