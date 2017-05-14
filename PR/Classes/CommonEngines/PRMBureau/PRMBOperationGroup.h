//
//  PRMBOperationGroup.h
//  PR
//
//  Created by 黄小雪 on 14/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRMBOperationGroup : NSObject
DEF_SINGLETON(PRMBOperationGroup)

-(UIViewController *)arrestWithPageID:(NSString *)pageID andParam:(NSDictionary *)params;

- (BOOL)authenticateViewContorller:(UIViewController *)vc withPageID:(NSString *)pageID;

@end
