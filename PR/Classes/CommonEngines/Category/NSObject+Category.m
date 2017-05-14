//
//  NSObject+Category.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "NSObject+Category.h"

@implementation NSObject (Category)

- (BOOL)isNilOrNull{
    BOOL flag = self && self != [NSNull null];
    return !flag;
}


- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects{
    // 方法签名
    NSMethodSignature * signature   = [self methodSignatureForSelector:aSelector];
    
    if (signature) {
        NSString * selectorString       = NSStringFromSelector(aSelector);
        int colonCount                  = [self countOfAppearanceOfString:@":" inString:selectorString];
        
        // 判断传入参数数量是否跟方法中参数数量相同
        if (objects) {
            if (objects.count != colonCount) {
                return nil;
            }
        }else{
            if (colonCount) {
                return nil;
            }
        }
        
        // 调用对象
        NSInvocation * invocation   = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        
        // 传入参数
        if (objects && objects.count) {
            for (int i = 0; i < objects.count; i++) {
                id obj = [objects objectAtIndex:i];
                [invocation setArgument:&obj atIndex:i+2];
            }
        }
        
        // 调用
        [invocation invoke];
        if (signature.methodReturnLength) {
            id returnValue;
            [invocation getReturnValue:&returnValue];
            
            return returnValue;
        }else{
            return nil;
        }
    }
    return nil;
}

- (int)countOfAppearanceOfString:(NSString *)string inString:(NSString *)originalString{
    int count           = 0;
    
    if (originalString) {
        if ([originalString rangeOfString:string].location != NSNotFound) {
            NSArray * components = [originalString componentsSeparatedByString:string];
            
            if (components && components.count) {
                count   = (int)components.count - 1;
            }
        }
    }
    
    return count;
}
@end