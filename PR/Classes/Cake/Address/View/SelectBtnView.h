//
//  SelectBtnView.h
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SelectBtnViewType)
{
    SelectBtnViewArea  = 1,   //所在地区
    SelectBtnViewStreet,      //街道
};

typedef void (^SelectBtnOnClickBlock)(SelectBtnViewType type);

@interface SelectBtnView : UIView
-(void)updatePrompt:(NSString *)prompt type:(SelectBtnViewType)type;
@property (copy,nonatomic) SelectBtnOnClickBlock returnBlock;
@end
