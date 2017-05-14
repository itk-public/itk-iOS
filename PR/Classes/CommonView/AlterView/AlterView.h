//
//  AlterView.h
//  YHClouds
//
//  Created by 黄小雪 on 16/4/22.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlterView;
@protocol AlterViewDelegate <NSObject>
@optional
- (void) alterViewClickedCommitButton:(AlterView *)alterView;
- (void) alterViewClickedCancleButton:(AlterView *)alterView;
@end
@interface AlterView : UIView

@property (strong,nonatomic) id object;
@property (assign,nonatomic) NSInteger tempValue;
@property (strong,nonatomic) NSString * title;
@property (strong,nonatomic) NSString * message;
@property (strong,nonatomic) NSString * remarkStr;
@property (strong,nonatomic) NSString * cancelTitle;
@property (strong,nonatomic) NSString * commitTitle;


-(void)setFontSize:(CGFloat)fontSize;

-(instancetype)initWithcancelBtnTitle:(NSString *)cancelBtnTitle
                       commitBtnTitle:(NSString *)commitBtnTitle
                              message:(NSString *)message
                             delegate:(id)delegate;

-(void)show;
@end
