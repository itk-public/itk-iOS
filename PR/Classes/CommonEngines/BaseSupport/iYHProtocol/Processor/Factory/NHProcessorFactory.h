//
//  NHProcessorFactory.h
//  PR
//
//  Created by 黄小雪 on 13/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  简单工厂类
 */

@interface NHProcessorFactory : NSObject
- (id)generateProcessorFor:(NSString *)ifanliURL;
@end
