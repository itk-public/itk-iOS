//
//  Action.h
//  PR
//
//  Created by 黄小雪 on 21/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

/*
 *点击的行为类型
 */
typedef enum _ActionType{
    ActionNone = 0,
    ActionGo ,              //点击跳转指定链接
    ActionDefault = ActionGo
    
}ActionType;


@interface Action : NSObject

@property (nonatomic,assign)ActionType         type;
@property (nonatomic,copy) NSString*              link;

+(id)actionWithDic:(NSDictionary*)actionDic;
+(id)actionWithString:(NSString *)actionstr;

@end
