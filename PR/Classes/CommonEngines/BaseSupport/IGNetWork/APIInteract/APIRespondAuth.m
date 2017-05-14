//
//  APIRespondAuth.m
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "APIRespondAuth.h"
#import "UserManager.h"
#import "IGHttpTask.h"

#define kNotifyBlockRetryKey    @"retry"
#define kNotifyBlockContinueKey @"continue"

@interface APIRespondAuth()<IGHttpTaskTaskDelegate>
/**
 *
 *用于存放由于accessToken过期引发的请求失败的业务请求,以便于刷新token后，重新进行业务请求.
 *
 */

@property (strong,nonatomic) NSMutableArray *failedAPIArr;
@property (assign,nonatomic) BOOL inRefreshProgress;

@end

@implementation APIRespondAuth

-(BOOL)verifyAuth:(BaseRespond *)respondData inAPI:(id)intercator
{
    if (respondData.outsideRsp) {
        return YES;
    }
    return YES;
    
}


#pragma mark -req
-(void)doRefreshToken
{
//    CONDITION_CHECK_RETURN(self.inRefreshProgress == NO);
//    self.inRefreshProgress = YES;
//    NSDictionary *dict = @{@"refresh_token":[[UserManager shareMananger] userData].refreshToken?:@"",
//                           @"uid":[[UserManager shareMananger] userData].uid?:@""};
}
@end
