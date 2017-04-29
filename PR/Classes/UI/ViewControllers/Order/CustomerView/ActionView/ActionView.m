//
//  ActionView.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ActionView.h"
#import "ThemeButton.h"
#import "OnePixelSepView.h"


@interface ActionView()
@property (strong,nonatomic) NSMutableArray *btnArray;

@end
@implementation ActionView

+(instancetype)defaultView
{
    ActionView *actionView = [[ActionView alloc]init];
    actionView.frame       = CGRectMake(0, 0, ScreenWidth, 46);
    return actionView;
}
-(instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
#warning 后期改逻辑
        ThemeButton *btn1 = [self btnWithBtnTag:CustomBtnTagToComment];
        ThemeButton *btn2 = [self btnWithBtnTag:CustomBtnTagToBuyAgain];
        
        self.btnArray = [NSMutableArray arrayWithObjects:btn1 ,btn2, nil];
        
        [self setPixelSepSet: PSRectEdgeTop];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kLeftMargin = 15;
    CGFloat kBtnW   = 60;
    CGFloat kBtnH   = 35;
    CGFloat kBtnMarign = 5;
    NSInteger i  = 0;
    
    CGFloat kBtnLeft = 0;
    for (ThemeButton *btn in self.btnArray) {
        CGFloat kBtnRight = self.width -  i *(kBtnW + kBtnMarign)  -kLeftMargin;
        btn.frame = CGRectMake(0, (self.height - kBtnH)/2.0, kBtnW, kBtnH);
        btn.right = kBtnRight;
        kBtnLeft  = btn.left;
        i ++;
    }
    self.kBtnLeftx = kBtnLeft;
}
-(NSString *)btnTitleWithBtnTag:(CustomBtnTag)tag
{
    if (tag == CustomBtnTagToPay) {
        return @"立即支付";
    }else if (tag == CustomBtnTagToComment){
        return @"追加评论";
    }else if (tag == CustomBtnTagToBuyAgain){
        return @"再次购买";
    }
    return nil;
}

-(CustomBtnType)btnTypeWithBtnTag:(CustomBtnTag)tag
{
    return CustomBtnTypeGreenBg;
}

-(void)btnAddTarget:(ThemeButton *)btn
{
    
}


-(ThemeButton *)btnWithBtnTag:(CustomBtnTag)tag
{
    ThemeButton *btn = [ThemeButton buttonWithType:UIButtonTypeSystem];
    [btn setType:[self btnTypeWithBtnTag:tag]];
    [btn setTitle:[self btnTitleWithBtnTag:tag] forState:UIControlStateNormal];
    [self btnAddTarget:btn];
    [self addSubview:btn];
    return btn;
}
@end
