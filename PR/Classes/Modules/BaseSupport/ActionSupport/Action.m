//
//  Action.m
//  PR
//
//  Created by 黄小雪 on 21/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "Action.h"
#import "UtilCodeTool.h"

@interface Action()
{
    ActionType               m_type;         //类型
    NSString*                  m_link;               //直接打开的链接
}

@property (nonatomic,retain) NSArray* titleItems;
@property (nonatomic,retain) NSArray* contentItems;

@end

@implementation Action
@synthesize type = m_type;
@synthesize link = m_link;

FUNCTION_NSCODINGIMP_WITHCLAZZ([Action class])

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        m_type = ActionDefault;
        m_link = nil;
    }
    return self;
}


+ (id)actionWithDic:(NSDictionary*)actionDic
{
    if (!actionDic) {
        return nil;
    }
    Action* action = [[self alloc] init];
    int type = [[actionDic safeObjectForKey:@"type" hintClass:[NSNumber class]] intValue];
    
    
    switch (type) {
        case ActionGo:
            action.type = ActionGo;
            action.link = [actionDic safeObjectForKey:@"link" hintClass:[NSString class]];
            break;
        default:
            action.type = ActionNone;
            action.link = [actionDic safeObjectForKey:@"link" hintClass:[NSString class]];
            break;
    }
    return action;
}

+ (id)actionWithString:(NSString *)actionstr
{
    CONDITION_CHECK_RETURN_VAULE(actionstr, nil);
    
    Action* action = [[self alloc] init];
    action.type = ActionGo;
    action.link = actionstr;
    return action;
}

- (BOOL)isEqual:(Action *)object
{
    if (self == object)
    {
        return YES;
    }
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[Action class]], NO);
    CONDITION_CHECK_RETURN_VAULE(self.type == object.type, NO);
    CONDITION_CHECK_RETURN_VAULE(check2ObjIsEqual(self.link, object.link), NO);
    return YES;
}
@end
