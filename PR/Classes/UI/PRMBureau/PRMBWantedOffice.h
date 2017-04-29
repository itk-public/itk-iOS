//
//  PRMBWantedOffice.h
//  PR
//
//  Created by 黄小雪 on 12/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRMBWantedOffice : NSObject
+ (void)nativeArrestWarrant:(NSString *)pageID param:(NSDictionary *)params;
+ (void)networkArrestWarrant:(NSString *)url param:(NSDictionary *)params;
@end
