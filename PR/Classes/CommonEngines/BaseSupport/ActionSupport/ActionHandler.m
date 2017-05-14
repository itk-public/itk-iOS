//
//  ActionHandler.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ActionHandler.h"
#import "AppURLCenter.h"

@interface ActionHandler()
{
    Action *m_action;
}
@property(nonatomic,retain)Action* action;
@end
@implementation ActionHandler
@synthesize action = m_action;

+ (id)handlerWithAction:(Action *)action
{
    ActionHandler* handler = [[ActionHandler alloc] init];
    [handler setAction:action];
    return handler;
}

- (void)run
{
    if (m_action.type == ActionGo || (m_action.type == ActionNone && m_action.link.length > 0))
    {
        [ActionHandler doDisposeAction:m_action forLink:m_action.link];
    }
}


#pragma mark -
#pragma 添加对 SFActionInfo 的支持
+ (void)doDisposeAction:(Action *)action forLink:(NSString *)link
{
    // 根据链接，执行一个新的操作
    if (action.type == ActionGo) {
        NSString * linkStr = link;//[link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [AppURLCenter openURL:[NSURL URLWithString:linkStr]];
    }
    
}

@end
