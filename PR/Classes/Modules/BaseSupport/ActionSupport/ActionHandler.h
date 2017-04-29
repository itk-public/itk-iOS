//
//  ActionHandler.h
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"

@interface ActionHandler : NSObject

+(id)handlerWithAction:(Action *)action;
-(void)run;

@end
