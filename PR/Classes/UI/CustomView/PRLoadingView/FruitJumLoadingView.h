//
//  FruitJumLoadingView.h
//  PR
//
//  Created by 黄小雪 on 09/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FruitJumLoadingView : UIView

-(void)startLoading;
-(void)startLoadingWithTips:(NSString *)tips;

-(void)stopLoading;

-(BOOL)isInAnimation;

-(void)changeTips:(NSString *)tipsInfo;

@end
