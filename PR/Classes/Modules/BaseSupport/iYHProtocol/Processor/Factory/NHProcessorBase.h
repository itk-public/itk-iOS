//
//  NHProcessorBase.h
//  PR
//
//  Created by 黄小雪 on 13/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InternalSchemeHandlerDefine.h"

/**
 *  NH:native handler
 */
@interface NHProcessorBase : NSObject
{
    NSString *cmdURL;
}

@property(nonatomic,strong)NSString  * finishNotifyID;
@property(nonatomic,strong)NSString  * cmdURL;

+ (BOOL)matchCMDPath:(NSString *)path inCMDURL:(NSString *)url;
+ (BOOL)isSingleton;//是否是单例

- (instancetype)initWithHandleCMD:(NSString *)theCMDURL;
- (void)disposeCommand;


// 结果通知
- (void)notifyCMDResult:(NSDictionary *)theResultInfo;
- (void)notifyJSONResult:(NSString *)jsstr;

@end
