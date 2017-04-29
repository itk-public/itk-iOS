//
//  NHProcessorFactory.m
//  PR
//
//  Created by 黄小雪 on 13/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "NHProcessorFactory.h"
#import "NHProcessorBase.h"

// 配置目前有效的命令处理体类，以逗号隔开。
// 未最佳到 kValidProcessors 的类，不会起作用。

#define kValidProcessors	  @"NHPShowNative,NHPShowWeb,NHPParamExpress,NHProcessorUserLogin,NHProcessorBase,NHPOrderCenter,NHPGoodsCenter"

@implementation NHProcessorFactory

#define kWarnningLineNum	10


+ (NSArray *)generatePrecessorClass:(NSArray *)classStrs
{
    // 1. 判断参数有效性
    if (0 == [classStrs count])
    {
        return nil;
    }
    
    // 构建存放的容器
    NSMutableArray * processorClasses = [NSMutableArray arrayWithCapacity:[classStrs count]];
    for (NSString * aClassStr in classStrs)
    {
        // 过滤掉空字符串
        if(aClassStr.length > 0)
        {
            Class theClass = NSClassFromString(aClassStr);
            if (theClass)
            {
                [processorClasses addObject:theClass];
            }else{
                // TODO : 打印一条ERORR记录
                PRLOG(@"cannot found the class for %@",aClassStr);
            }
        }
    }
    
    return processorClasses;
}

- (id)generateProcessorFor:(NSString *)ifanliURL
{
    static NSArray * checkProcessClass = nil;
    
    // 配置当前可用的processor
    NSArray * processClassStrs = [kValidProcessors componentsSeparatedByString:@","];
    
    // 无有效的processor
    if(0 == [processClassStrs count])
    {
        PRLOG(@"无有效的processor配置,请确认是否在 ‘kValidProcessors’宏  中添加了processor 类名");
        return nil;
    }
    
    // 构建一次class信息
    if (nil == checkProcessClass)
    {
        checkProcessClass = [NHProcessorFactory generatePrecessorClass:processClassStrs];
    }
    
    NSURL *url = [NSURL URLWithString:ifanliURL];
    // 1. 确认是有效的自定义协议
    if ([url.host isEqualToString:INTERNAL_HOST])
    {
        NSString *path = url.path;
        // 2. 遍历所有带处理的class，找到可以处理这个命令的class
        for (Class aProcessClass in checkProcessClass)
        {
            // 3. 确保可以访问指定的方法，防止出错
            if ([aProcessClass respondsToSelector:@selector(matchCMDPath:inCMDURL:)])
            {
                // 4. 查询class是否能处理这个命令
                if([aProcessClass  matchCMDPath:path inCMDURL:ifanliURL])
                {
                    // 5. 构建指定的process
                    static NSMutableDictionary* singletonProcessers = nil;
                    if (!singletonProcessers) {
                        singletonProcessers = [[NSMutableDictionary alloc] init];
                    }
                    
                    id theProcess = nil;
                    
                    if ([aProcessClass respondsToSelector:@selector(isSingleton)] && [aProcessClass isSingleton])
                    {
                        theProcess = [singletonProcessers safeObjectForKey:[aProcessClass description] hintClass:[NHProcessorBase class]];
                        if (!theProcess) {
                            theProcess = [[aProcessClass alloc] initWithHandleCMD:ifanliURL];
                            [singletonProcessers setObject:theProcess forKey:[aProcessClass description]];
                        }
                        ((NHProcessorBase*)theProcess).cmdURL = ifanliURL;
                    }
                    else
                    {
                        theProcess =  [[aProcessClass alloc] initWithHandleCMD:ifanliURL];
                    }
                    
                    
                    // 6. 确认构建出正确的 process 对象
                    assert([theProcess isKindOfClass:[NHProcessorBase class]]);
                    return theProcess;
                }
            }
            
        }
        
    }
    
    return nil;
}


@end
