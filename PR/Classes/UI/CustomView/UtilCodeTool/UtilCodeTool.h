//
//  UtilCodeTool.h
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "NSObject+NSCoding.h"
#import <objc/runtime.h>

#ifndef UtilCodeTool_h
#define UtilCodeTool_h

#define FUNCTION_NSCODINGIMP_WITHCLAZZ(clazz)\
- (void)encodeWithCoder:(NSCoder *)aCoder\
{\
    [super encodeWithCoder:aCoder];\
    unsigned int num = 0;\
    Ivar* var = class_copyIvarList(clazz, &num);\
    NSString* idKey = [NSString stringWithUTF8String:@encode(id)];\
    \
    for (int i = 0; i < num; i++)\
    {\
        const char* name = ivar_getName(*(var+i));\
        const char* type = ivar_getTypeEncoding(*(var+i));\
        NSString* typeName = [NSString stringWithUTF8String:type];\
        NSString* objName = [NSString stringWithUTF8String:name];\
        if([typeName hasPrefix:idKey])\
        {\
            id v0 = object_getIvar(self, *(var+i));\
            if (v0)\
            {\
                [aCoder encodeObject:v0 forKey:objName];\
            }\
        }\
        else\
        {\
            id value = [self valueForKey:objName];\
            if (value)\
            {\
                [aCoder encodeObject:value forKey:objName];\
            }\
        }\
        \
    }\
    free(var);\
}\
\
- (id)initWithCoder:(NSCoder *)aDecoder\
{\
    self = [super initWithCoder:aDecoder];\
    if (self)\
    {\
        unsigned int num = 0;\
        NSString* idKey = [NSString stringWithUTF8String:@encode(id)];\
        \
        Ivar* var = class_copyIvarList(clazz, &num);\
        for (int i = 0; i < num; i++)\
        {\
            const char* name = ivar_getName(*(var+i));\
            const char* type = ivar_getTypeEncoding(*(var+i));\
            NSString* typeName = [NSString stringWithUTF8String:type];\
            NSString* objName = [NSString stringWithUTF8String:name];\
            \
            if ([typeName hasPrefix:idKey])\
            {\
                id v = [aDecoder decodeObjectForKey:objName];\
                if (v)\
                {\
                    object_setIvar(self, *(var+i), v);\
                }\
            }\
            else\
            {\
                id value = [aDecoder decodeObjectForKey:objName];\
                if (value) {\
                    [self setValue:value forKey:objName];\
                }\
            }\
        }\
        free(var);\
    }\
    return self;\
}\


#endif /* UtilCodeTool_h */
