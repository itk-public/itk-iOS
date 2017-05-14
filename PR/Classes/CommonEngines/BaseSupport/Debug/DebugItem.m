//
//  DebugItem.m
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifdef ISDebugOptionValid
#import "DebugManager.h"
#import "Utilities.h"
#import "DebugItem.h"

NSString * DebugOption_AllControl = @"DebugOption_AllControl";

@interface DebugItem()
{
    NSArray *		m_mutiValue;
    ACTIONHANDLER   m_handler;
    BOOL            m_isValid;
}
- (void)setMutiValue:(NSArray *)mutiValue;
- (void)setItemAction:(ACTIONHANDLER)itemAction;
- (void)updateItemValid:(BOOL)isValid;
@end

@implementation DebugItem
@synthesize handler = m_handler;
+ (id)ita:(NSString *)title id:(NSString *)dId a:(ACTIONHANDLER)action
{
    DebugItem * aItem = [[DebugItem alloc] init];
    aItem->_type = DItemType_Action;
    aItem->_promptTitle = title;
    aItem->_dId = dId;
    [aItem setItemAction:action];
    return aItem;
}

+ (id)itb:(NSString *)title id:(NSString *)dId a:(ACTIONHANDLER)action
{
    DebugItem * aItem = [[DebugItem alloc] init];
    aItem->_type = DItemType_Boolean;
    aItem->_promptTitle = title;
    aItem->_dId = dId;
    [aItem setItemAction:action];
    return aItem;
}

+ (id)itay:(NSString *)title id:(NSString *)dId ay:(NSArray *)valueProbably a:(ACTIONHANDLER)action
{
    DebugItem * aItem = [[DebugItem alloc] init];
    aItem->_type = DItemType_Array;
    aItem->_promptTitle = title;
    aItem->_dId = dId;
    [aItem setMutiValue:valueProbably];
    [aItem setItemAction:action];
    return aItem;
}

+ (id)itlt:(NSString *)title id:(NSString *)dId lt:(NSArray *)valueProbably a:(ACTIONHANDLER)action
{
    DebugItem * aItem = [[DebugItem alloc] init];
    aItem->_type = DItemType_List;
    aItem->_promptTitle = title;
    aItem->_dId = dId;
    [aItem setMutiValue:valueProbably];
    [aItem setItemAction:action];
    return aItem;
}

- (instancetype)init
{
    if (self = [super init]) {
        m_isValid = YES;
    }
    return self;
}

- (BOOL)isValid
{
    if ([self.dId isEqualToString:DebugOption_AllControl]) {
        return YES;
    }
    if (NO == [[DebugManager sharedDebugMananger] isAllDebugOpen]) {
        return NO;
    }
    return m_isValid;
}


- (void)updateItemValid:(BOOL)isValid
{
    m_isValid = isValid;
}

- (NSArray *)mutiOptionValue
{
    return m_mutiValue;
}

- (void)setMutiValue:(NSArray *)mutiValue
{
    CONDITION_CHECK_RETURN(self.type == DItemType_Array || self.type == DItemType_List);
    m_mutiValue = mutiValue ;
}

- (void)setItemAction:(ACTIONHANDLER)itemAction
{
    m_handler = [itemAction copy];
}

- (BOOL)changeDebugValue:(NSString *)value
{
    if (self.type == DItemType_None) {
        return NO;
    }else if (self.type == DItemType_Action){
        if (m_handler) {
            m_handler(self);
        }
        return NO;
    }else if (self.type == DItemType_Boolean || self.type == DItemType_Array || self.type == DItemType_List){
        _value = value;
        if (m_handler) {
            m_handler(self);
        }
        return YES;
    }
    
    return NO;
}
@end
#endif

