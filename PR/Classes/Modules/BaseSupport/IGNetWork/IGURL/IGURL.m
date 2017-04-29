//
//  IGURL.m
//  PR
//
//  Created by 黄小雪 on 10/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "IGURL.h"
#import "IGUtilties.h"

#define ColonString             @":"
#define DoubleBackslashString   @"//"
#define AtString                @"@"
#define BackslashString         @"/"
#define SemicolonString         @";"
#define QuestionMark            @"?"
#define AndString               @"&"
#define PoundString             @"#"
#define EqualString             @"="


@interface IGURL ()
{
    NSString*				m_scheme;
    NSString*				m_user;
    NSString*				m_password;
    NSString*				m_host;
    NSString*				m_port;
    NSString*				m_path;
    NSString*				m_fragment;
    NSString*				m_parameterString;
    NSMutableDictionary*	m_queryDic;
    NSMutableArray*			m_queryIndexs;
}

@end

@implementation IGURL

@synthesize scheme          = m_scheme;
@synthesize user            = m_user;
@synthesize password        = m_password;
@synthesize host            = m_host;
@synthesize path            = m_path;
@synthesize port            = m_port;
@synthesize fragment        = m_fragment;
@synthesize parameterString = m_parameterString;


- (void)dealloc
{
    m_scheme = nil;
    m_user = nil;
    m_password = nil;
    m_host = nil;
    m_port = nil;
    m_path = nil;
    m_fragment = nil;
    m_parameterString = nil;
    m_queryDic = nil;
    m_queryIndexs = nil;
}

+ (id)urlWithIGURL:(IGURL *)url
{
    return [self urlWithNSURL:[url buildUrl]];
}

+ (id)urlWithString:(NSString *)urlStr
{
    urlStr = [urlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [self urlWithNSURL:[NSURL URLWithString:urlStr]];
}

+ (id)urlWithNSURL:(NSURL*)url
{
    IGURL* newUrl = [[IGURL alloc] init];
    [newUrl setScheme:url.scheme];
    [newUrl setUser:url.user];
    [newUrl setPassword:url.password];
    [newUrl setHost:url.host];
    [newUrl setPort:[url.port stringValue]];
    [newUrl setPath:url.path];
    if (url.query) {
        [newUrl setQueryString:url.query];
    }
    [newUrl setFragment:url.fragment];
    [newUrl setParameterString:url.parameterString];
    
    return newUrl;
}

+ (id)urlWithScheme:(NSString*)scheme host:(NSString *)host path:(NSString *)path
{
    IGURL* newUrl = [[IGURL alloc] init];
    [newUrl setScheme:scheme];
    [newUrl setHost:host];
    [newUrl setPath:path];
    return newUrl;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        m_scheme	= nil;
        m_user		= nil;
        m_password	= nil;
        m_host		= nil;
        m_port		= nil;
        m_path		= nil;
        m_fragment	= nil;
        m_parameterString = nil;
        m_queryDic	= [[NSMutableDictionary alloc] init];
        m_queryIndexs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)description
{
    NSString * selfInfo = [super description];
    NSString * urlInfo = [[self buildUrl] description];
    
    return [NSString stringWithFormat:@"%@\n%@",selfInfo,urlInfo];
}

- (void)setQuery:(NSString*)value forKey:(NSString*)key
{
    if (key.length > 0)
    {
        value = (nil == value) ? @"" : value;
        [m_queryDic setObject:[IGUtilties encodeURL:[value description]] forKey:key];
        [m_queryIndexs removeObject:key];
        [m_queryIndexs addObject:key];
    }
}

- (void)setQueryString:(NSString *)query
{
    NSArray* components = [query componentsSeparatedByString:AndString];
    for (NSString* item in components)
    {
        NSArray* keyValue = [item componentsSeparatedByString:EqualString];
        NSUInteger num = [keyValue count];
        NSString* key = num > 0 ? [keyValue objectAtIndex:0] : @"";
        NSString* value = num > 1 ? [keyValue objectAtIndex:1] : @"";
        [self setQuery:value forKey:key];
    }
}

/**
 *	将dic中的key value添加到query中，已经存在相同的则替换
 */
- (void)setQueryFromDic:(NSDictionary*)dic
{
    NSEnumerator* keyEnum = [dic keyEnumerator];
    NSString * key = nil;
    
    while ((key = [keyEnum nextObject]))
    {
        NSString * value = [dic objectForKey:key];
        value = (nil == value) ? @"" : value;
        [self setQuery:value forKey:key];
    }
}

- (BOOL)bringQueryToFront:(NSString *)key
{
    if (key && [m_queryIndexs containsObject:key])
    {
        [m_queryIndexs removeObject:key];
        [m_queryIndexs insertObject:key atIndex:0];
        return YES;
    }
    return NO;
}

- (NSString*)getQueryString
{
    if ([m_queryDic count] < 1)
    {
        return nil;
    }
    NSMutableString *queryStr = [[NSMutableString alloc] init];
    NSArray* allKeys = [self orderedKeys];
    for (int index = 0; index < [allKeys count]; index++)
    {
        if (index != 0)
        {
            [queryStr appendString:AndString];
        }
        NSString* key = [allKeys objectAtIndex:index];
        NSString* value = [m_queryDic objectForKey:key];
        NSString* queryItem = [NSString stringWithFormat:@"%@%@%@",key,EqualString,value];
        [queryStr appendString:queryItem];
    }
    
    return queryStr;
}


- (void)removeQueryForKey:(NSString*)key
{
    if (key.length > 0)
    {
        [m_queryDic removeObjectForKey:key];
        [m_queryIndexs removeObject:key];
    }
}

- (void)removeQueryForKey:(NSString *)key isCaseSensitive:(BOOL)sensitive
{
    if (sensitive)
    {
        [self removeQueryForKey:key];
    }
    else
    {
        NSArray* allKeys = [m_queryDic allKeys];
        [m_queryIndexs removeObject:key];
        for (int index = 0; index < [allKeys count]; index++)
        {
            NSString* keyItem = [allKeys objectAtIndex:index];
            if (NSOrderedSame == [key compare:keyItem options:NSCaseInsensitiveSearch])
            {
                [self removeQueryForKey:keyItem];
            }
        }
    }
}

- (BOOL)queryExist:(NSString *)key isCaseSensitive:(BOOL)yesOrNo
{
    BOOL result = NO;
    NSArray* allKeys = [m_queryDic allKeys];
    NSStringCompareOptions opt = yesOrNo ? NSLiteralSearch : NSCaseInsensitiveSearch;
    for (NSString* keyItem in allKeys)
    {
        if (NSOrderedSame == [key compare:keyItem options:opt])
        {
            result = YES;
            break;
        }
    }
    return result;
}

- (NSString*)queryForKey:(NSString *)key isCaseSensitive:(BOOL)yesOrNo
{
    NSString* result = nil;
    NSArray* allKeys = [m_queryDic allKeys];
    NSStringCompareOptions opt = yesOrNo ? NSLiteralSearch : NSCaseInsensitiveSearch;
    for (NSString* keyItem in allKeys)
    {
        if (NSOrderedSame == [key compare:keyItem options:opt])
        {
            result = [m_queryDic objectForKey:keyItem];
            break;
        }
    }
    return [IGUtilties decodeURL:result];
}

- (NSURL*)buildUrl
{
    NSMutableString *urlString = [[NSMutableString alloc] init];
    
    // add scheme
    if (nil != m_scheme)
    {
        [urlString appendString:m_scheme];
        [urlString appendString:ColonString DoubleBackslashString];
    }
    
    // add user and password
    if (nil != m_user)
    {
        [urlString appendString:m_user];
        if (nil != m_password)
        {
            [urlString appendString:[ColonString stringByAppendingString:m_password]];
        }
        
        [urlString appendString:AtString];
    }
    
    // add host
    if (nil != m_host)
    {
        [urlString appendString:m_host];
    }
    
    // add port
    if (nil != m_port)
    {
        [urlString appendString:ColonString];
        [urlString appendString:m_port];
    }
    
    // add path
    if (nil != m_path)
    {
        [urlString appendString:m_path];
    }
    
    // add parameter
    if (nil != m_parameterString)
    {
        [urlString appendString:[SemicolonString stringByAppendingString:m_parameterString]];
    }
    
    // add query
    if (0 !=  [m_queryDic count])
    {
        [urlString appendString:QuestionMark];
        NSString *queryStr = [self getQueryString];
        [urlString appendString:queryStr==nil?@"":queryStr];
    }
    
    // add fragment
    if (nil != m_fragment)
    {
        [urlString appendString:[PoundString stringByAppendingString:m_fragment]];
    }
    
    return [NSURL URLWithString:urlString];
}

/**
 *	获取排序过的key数组
 **/
- (NSArray*)orderedKeys
{
    NSMutableArray* resKeys = [NSMutableArray arrayWithArray:m_queryIndexs];
    NSArray* allKeys = [m_queryDic allKeys];
    for (NSString* key in allKeys)
    {
        if (NO == [resKeys containsObject:key])
        {
            [resKeys addObject:key];
        }
        
    }
    return resKeys;
}

- (NSDictionary *)allQueryPairs
{
    return m_queryDic;
}

@end

#pragma mark -- NSURL扩展类

@implementation NSURL (IGURL)

- (BOOL)checkExistInQuery:(NSString*)key isCaseSensitive:(BOOL)yesOrNo
{
    if (nil == key || nil == self.query)
    {
        return NO;
    }
    
    IGURL* url = [IGURL urlWithNSURL:self];
    return [url queryExist:key isCaseSensitive:yesOrNo];
}

- (NSString*)getValueInQueryForKey:(NSString*)key isCaseSensitive:(BOOL)yesOrNo
{
    if (nil == key || nil == self.query)
    {
        return nil;
    }
    
    IGURL* url = [IGURL urlWithNSURL:self];
    return [url queryForKey:key isCaseSensitive:yesOrNo];
}

+ (NSURL*)URLWithString:(NSString*)originalString addQuerys:(NSArray*)toAdd delQuerys:(NSArray*)toDel isCaseSensitive:(BOOL)yesOrNo
{
    NSURL *originalURL = [NSURL URLWithString:originalString];
    
    if (nil == originalURL || (nil == toAdd && nil == toDel))
    {
        return originalURL;
    }
    else
    {
        IGURL* url = [IGURL urlWithNSURL:originalURL];
        for (NSString* query in toDel)
        {
            [url removeQueryForKey:query isCaseSensitive:yesOrNo];
        }
        for (NSString* query in toAdd)
        {
            [url setQueryString:query];
        }
        return [url buildUrl];
    }
}

@end

