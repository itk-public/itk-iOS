//
//  PhoneTextFiledView.h
//  PR
//
//  Created by 黄小雪 on 09/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TextFiledType)
{
    TextFiledTypeInputPhone = 0,     //输入手机号
    TextFiledTypeInputCode,          //输入验证码
    TextFiledTypeInputPwd,           //输入密码
    TextFiledTypeSetPwd,             //设置密码
    
};

@protocol TextFiledViewDelegate  <NSObject>

-(void)textFiledViewDidBeginEditing:(UITextField *)textFiled;
-(void)textFiledViewDidEndEditing:(UITextField *)textFiled;
@end

@interface InputModel : NSObject

@property (readonly,nonatomic) NSString *iconName;
@property (readonly,nonatomic) NSString *placeStr;
@property (readonly,nonatomic) TextFiledType type;
@property (readonly,nonatomic) BOOL          hiddenBottomLine;

+(instancetype)inputModelWithIconName:(NSString *)iconName
                             placeStr:(NSString *)placeStr
                        textFiledType:(TextFiledType)type
                     hiddenBottomLine:(BOOL)hiddenBottomLine;
@end

@interface TextFiledView : UIView

+(instancetype)textFiledViewWithInputModel:(InputModel *)inputModel;
@property (weak,nonatomic) id<TextFiledViewDelegate> delegate;
-(BOOL)checkInputInfo;

@end
