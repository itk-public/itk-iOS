//
//  ItemView.h
//  PR
//
//  Created by 黄小雪 on 18/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemViewDelegate <NSObject>
-(void)itemViewDidTouch:(id)modelData;
@end


@interface ItemView : UIView

@property (weak,nonatomic) id<ItemViewDelegate> delegate;

+(instancetype)itemViewWithIconName:(NSString *)iconName
                              title:(NSString *)title
                           subTitle:(NSString *)subTitle
                          modelData:(id)modelData;
-(void)setIconName:(NSString *)iconName
             title:(NSString *)title
          subTitle:(NSString *)subTitle
         modelData:(id)modelData;
@end
