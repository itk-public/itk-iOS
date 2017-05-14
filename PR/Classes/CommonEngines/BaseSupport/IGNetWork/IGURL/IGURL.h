//
//  IGURL.h
//  PR
//
//  Created by 黄小雪 on 10/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  提供一个更为灵活的URL操作类。
 *  可以与NSURL进行无缝对接。
 */
@interface IGURL : NSObject
@property (strong,nonatomic) NSString *scheme;
@property (strong,nonatomic) NSString *user;
@property (strong,nonatomic) NSString *password;
@property (strong,nonatomic) NSString *host;
@property (strong,nonatomic) NSString *path;
@property (strong,nonatomic) NSString* port;
@property (strong,nonatomic) NSString *fragment;
@property (strong,nonatomic) NSString *parameterString;

/**
 *  根据一个NSURL对象新建一个IGURL
 *
 */
+(instancetype)urlWithNSURL:(NSURL *)url;

/**
 *	根据一个IGURL对象新建一个IGURL
 */
+(instancetype)urlWithIGURL:(IGURL *)url;

/**
 *  @param urlString 初始化的url字符串
 *
 *  @return 返回一个新的对象
 */
+(instancetype)urlWithString:(NSString *)urlString;

/**
 *	返回一个新的IGURL对象 并设定scheme host path
 */
+(instancetype)urlWithScheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path;

/**
 *	添加一个query参数 已经存在相同的则替换
 */
-(void)setQuery:(NSString *)value forKey:(NSString *)key;

/**
 *  添加一段query字符串
 */
-(void)setQueryString:(NSString *)query;

/**
 *	将dic中的key value添加到query中，已经存在相同的则替换
 */
-(void)setQueryFromDic:(NSDictionary *)dic;

/**
 *	将制定参数添加到最前面
 */
- (BOOL)bringQueryToFront:(NSString*)key;

/**
 *获取整个query string
 *如果没有query则返回nil
 */
- (NSString*)getQueryString;

/**
 *	移除一个query参数,默认严格区分大小写
 */
- (void)removeQueryForKey:(NSString*)key;

/**
 *	移除一个query参数,指定是否大小写敏感
 */
- (void)removeQueryForKey:(NSString *)key isCaseSensitive:(BOOL)sensitive;

/**
 *	检测query是否存在
 */
- (BOOL)queryExist:(NSString*)key isCaseSensitive:(BOOL)yesOrNo;
/**
 *  获取指定query
 */
- (NSString*)queryForKey:(NSString*)key isCaseSensitive:(BOOL)yesOrNo;

/**
 *  获取所有的 Key vale 的query
 */
- (NSDictionary *)allQueryPairs;

/**
 *	生成新的NSUrl对象
 */
- (NSURL*)buildUrl;

@end

/****
 *	为了兼容原有的NSURL+Ordertrack类以及一些特殊场景下的简单使用
 *	提供一些简易的url拼接，和属性获取方法
 *	复杂的应用方式，比如需要对URL进行多次修改和查询等操作简易使用IGURL类
 ****/
@interface NSURL (IGURL)

/**
 *	检测url中是否存在对应的query
 */
- (BOOL)checkExistInQuery:(NSString*)key isCaseSensitive:(BOOL)yesOrNo;

/**
 *	获取url中对应的query
 */
- (NSString*)getValueInQueryForKey:(NSString*)key isCaseSensitive:(BOOL)yesOrNo;

/**
 *	通过指定一个url和需要更新的query参数(query只接受标准格式key=value)，生成一个新的url
 */
+ (NSURL*)URLWithString:(NSString*)originalString addQuerys:(NSArray*)toAdd delQuerys:(NSArray*)toDel isCaseSensitive:(BOOL)yesOrNo;


@end

