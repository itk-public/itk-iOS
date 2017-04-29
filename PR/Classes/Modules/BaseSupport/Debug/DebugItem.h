//
//  DebugItem.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//
//

#ifdef ISDebugOptionValid
#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString * DebugOption_AllControl;

@class DebugItem;
typedef NS_ENUM(NSInteger,DebugItemType)
{
    DItemType_None = 0,
    DItemType_Action,
    DItemType_Boolean,
    DItemType_Array,
    DItemType_List,
};

typedef void (^ACTIONHANDLER)(DebugItem * item);

@interface DebugItem : NSObject
@property(nonatomic,readonly)NSString * promptTitle;
@property(nonatomic,readonly)NSString * dId;
@property(nonatomic,readonly)DebugItemType type;
@property(nonatomic,readonly)BOOL   isValid;
@property(nonatomic,readonly)NSString * value;
@property(nonatomic,readonly) ACTIONHANDLER  handler;

- (NSArray *)mutiOptionValue;

+ (id)ita:(NSString *)title id:(NSString *)dId a:(ACTIONHANDLER)action;
+ (id)itb:(NSString *)title id:(NSString *)dId a:(ACTIONHANDLER)action ;
+ (id)itay:(NSString *)title id:(NSString *)dId ay:(NSArray *)valueProbably a:(ACTIONHANDLER)action;
+ (id)itlt:(NSString *)title id:(NSString *)dId lt:(NSArray *)valueProbably a:(ACTIONHANDLER)action;

- (BOOL)changeDebugValue:(NSString *)value;

@end

#endif
