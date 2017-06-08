//
//  SoyScoreView.h
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SoyScoreDelegate <NSObject>

- (void)changedScore:(NSInteger)score;

@end

@interface SoyScoreView : UIView

@property (nonatomic, weak  ) id<SoyScoreDelegate> delegate;

@property (nonatomic, assign) CGFloat score;

@property (nonatomic, assign) BOOL    chageEnable;

-(instancetype)initWithFrame:(CGRect)frame setStarWidth:(NSInteger )width margin:(NSInteger)margin;

@end
