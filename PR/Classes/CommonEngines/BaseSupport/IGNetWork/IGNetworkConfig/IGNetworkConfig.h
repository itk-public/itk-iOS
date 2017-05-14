//
//  IGNetworkConfig.h
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGErrorHandler.h"

@interface IGNetworkConfig : NSObject
+(instancetype)sharedInstance;

-(void)registerNetworkUA:(NSString *)userAgent;
-(void)updateProfessionalParam:(NSDictionary *)param;
-(void)updateRequestPublicParam:(NSDictionary *)param;
-(void)setErrorHandler:(IGErrorHandler *)errorHandler;

-(NSString *)userAgent;
-(NSString *)professionalParamStr;
-(NSDictionary *)publicParams;
-(IGErrorHandler *)errorHandler;

@end
