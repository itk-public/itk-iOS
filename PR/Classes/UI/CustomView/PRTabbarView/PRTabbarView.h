//
//  YHTabbarView.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRTabbarView : UIView
@property (readonly,nonatomic) NSInteger curSeletedIndex;

-(instancetype)initWithSelectedImgDic:(NSDictionary *)imgDic;
-(void)setSelectedIndex:(NSInteger)index;

////修改tabbar的显示名字
//- (void)alterTabBarName:(NSString *)name
//                  index:(NSInteger)index;

@end
