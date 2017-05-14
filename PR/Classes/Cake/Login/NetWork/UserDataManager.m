//
//  UserDataManager.m
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "UserDataManager.h"
#import "PhoneQuickLoginAPIInteract.h"

@implementation UserDataManager
-(BOOL)loginWithPhoneNum:(NSString *)phoneNum safetyCode:(NSString *)safetyCode
{
    [[PhoneQuickLoginAPIInteract alloc]interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:UserDataManangerTypePhoneQuickLogin data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:UserDataManangerTypePhoneQuickLogin error:error];
        }
    }];
    
    return YES;
}
@end
