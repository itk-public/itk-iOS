//
//  BaseRespond.h
//  PR
//
//  Created by 黄小雪 on 23/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGNetworkDefine.h"
#import "IGParserInterface.h"

@interface BaseRespond : NSObject

@property(nonatomic,readonly)HttpResponseStatusCode     httpCode;
@property(nonatomic,readonly)IGRespondStatus            status;
@property(nonatomic,readonly)NSError *                  error;
@property(nonatomic,readonly)NSString *                 promptInfo;
@property(nonatomic,readonly)id                         parsedModel;
@property(nonatomic,readonly)NSTimeInterval             timeStamp;
@property(nonatomic,readonly)NSInteger                  taskTag;
@property(nonatomic,readonly)BOOL                       outsideRsp;

@end

/**
 *  提供内部协作的接口
 */
@interface BaseRespond(innerCooperate)
+ (instancetype)objWithRespondJson:(id)jsonData
                           taskTag:(NSInteger)tag
                       modelParser:(id<IGParserInterface>)parser
                    isOutsideVisit:(BOOL ) outside ;
+ (instancetype)objWithError:(NSError *)errorInfo  respondInfo:(id)respondInfo;
- (void)setModelData:(id)parsedModel;
- (void)setHttpCode:(HttpResponseStatusCode)httpCode;
@end
