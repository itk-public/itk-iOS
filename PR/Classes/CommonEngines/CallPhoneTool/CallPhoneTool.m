//
//  CallPhoneTool.m
//  YHClouds
//
//  Created by 黄小雪 on 16/6/20.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CallPhoneTool.h"
#import "AppURLCenter.h"

@interface CallPhoneTool()<UIAlertViewDelegate>
@property (copy,nonatomic) NSString *phone;
@end


@implementation CallPhoneTool

-(void)callPhone:(NSString *)phone
{
    if(phone.length == 0) return;
    NSMutableString *phoneStr = [NSMutableString stringWithString:phone];
    BOOL isPhoneNum           = phone.length == 11;
    NSInteger temp            = isPhoneNum ?7:6;
    for(NSInteger i = 0; i < phoneStr.length;i ++){
        if (i == 2) {
            [phoneStr insertString:@"-" atIndex:i+ 1];
        }else if(i == temp){
            [phoneStr insertString:@"-" atIndex:i + 1];
        }
    }
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:nil
                                                       message:phoneStr
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                     otherButtonTitles:@"呼叫", nil];
    self.phone         = phone;
    [alter show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) return;
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phone]];
    [AppURLCenter openURL:phoneURL];
}



@end
