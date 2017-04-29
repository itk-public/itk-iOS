//
//  IGParserInterface.h
//  PR
//
//  Created by 黄小雪 on 23/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifndef IGParserInterface_h
#define IGParserInterface_h
#import <UIKit/UIKit.h>

/**
 *  一个网络数据解析器的接口类
 *  用来负责解析主体内容。
 */
@class BaseRespond;

@protocol IGParserInterface <NSObject>

@required
- (id)parserSourceData:(NSDictionary *)info forRespondObj:(BaseRespond *)respond;

@end


#endif /* IGParserInterface_h */
