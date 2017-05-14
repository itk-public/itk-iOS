//
//  PRMBOperationGroup.m
//  PR
//
//  Created by 黄小雪 on 14/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PRMBOperationGroup.h"
#import "PRMBPageIDCard.h"
#import "BaseViewController.h"

@interface PRMBOperationGroup()
/*!
 @property
 @abstract      存放viewcontroller相关信息,key是viewcontroller对象的identifier，
 value是PAViewDataModel对象
 */
@property (nonatomic, strong) NSDictionary * viewModalDict;
@property (nonatomic, strong) NSDictionary * hangViewModelDict;   // 挂载的的前置viewModel


@end

@implementation PRMBOperationGroup
IMP_SINGLETON

#pragma mark - interface
- (UIViewController *)arrestWithPageID:(NSString *)pageID andParam:(NSDictionary *)params
{
    PRMBPageIDCard *viewDataModel = [self viewDataModelForIdentifier:pageID];
    viewDataModel.queryForInitMethod = [NSMutableDictionary dictionaryWithDictionary:params];
    viewDataModel.viewInstanceMethod = nil;
    viewDataModel.queryForInstanceMethod = nil;
    viewDataModel.propertyDictionary = params;
    return [self pageArrestWithIDCard:viewDataModel];
}

- (BOOL)authenticateViewContorller:(UIViewController *)vc withPageID:(NSString *)pageID
{
    PRMBPageIDCard * idCard = [self viewDataModelForIdentifier:pageID];
    if (idCard.viewClass == [NullViewController class]) {
        return NO;
    }
    if ([vc isKindOfClass:idCard.viewClass]) {
        return YES;
    }
    return NO;
}


#pragma mark - setter/getter
- (UIViewController *)pageArrestWithIDCard:(PRMBPageIDCard *)idcard
{
    UIViewController *controller  = nil;
    if (idcard) {
        //获取相关参数
        Class viewClass = idcard.viewClass;
        SEL   initMethod = [idcard.viewInitMethod pointerValue];
        if (viewClass && initMethod) {
            controller = [[viewClass alloc]init];
            //配置object
            [self configObject:controller withViewDataModel:idcard shouldCallInitMethod:YES];
        }
    }
    return controller;
}


- (PRMBPageIDCard *)viewDataModelForIdentifier:(NSString *)identifier
{
    PRMBPageIDCard *viewDataModel = nil;
    if (nil == viewDataModel) {
        viewDataModel = [self.viewModalDict objectForKey:identifier];
    }
    return viewDataModel;
}

#pragma mark - page config
- (void)configObject:(NSObject *)object withViewDataModel:(PRMBPageIDCard *)viewDataModel shouldCallInitMethod:(BOOL)shouldCallInitMethod{
    if (viewDataModel && object) {
        // 获取相关参数
        Class       viewClass               = viewDataModel.viewClass;
        SEL         initMethod              = [viewDataModel.viewInitMethod pointerValue];
        SEL         instanceMethod          = [viewDataModel.viewInstanceMethod pointerValue];
        NSDictionary * queryForInitM        = viewDataModel.queryForInitMethod;
        NSDictionary * queryForInstanceM    = viewDataModel.queryForInstanceMethod;
        NSDictionary * propertyDict         = viewDataModel.propertyDictionary;
        
        //queryForInitM                       = queryForInitM == nil ? [NSDictionary dictionary] : queryForInitM;
        //queryForInstanceM                   = queryForInstanceM == nil ? [NSDictionary dictionary] : queryForInstanceM;
        
        
        if (viewClass && initMethod) {
            // 初始化
            if ([object respondsToSelector:initMethod] && shouldCallInitMethod) {
                NSArray * params            = nil;
                if (queryForInitM) {
                    params                  = @[queryForInitM];
                }
                //                [object performSelector:initMethod withObjects:params];
                IMP tImp = [object methodForSelector:initMethod];
                UIViewController * (*func)(id, SEL, NSDictionary*) = (void *)tImp;
                object = func(object, initMethod, queryForInitM);
            }
            // 属性
            if (propertyDict) {
                for (NSString * key in propertyDict.allKeys) {
                    id value                = [propertyDict objectForKey:key];
                    SEL getMethod           = NSSelectorFromString(key);
                    if ([object respondsToSelector:getMethod]) {
                        [object setValue:value forKey:key];
                    }
                }
            }
            // 实例方法
            if ([object respondsToSelector:instanceMethod]) {
                NSArray * params            = nil;
                if (queryForInstanceM) {
                    params                  = @[queryForInstanceM];
                }
                //                [object performSelector:instanceMethod withObjects:params];
                IMP tImp = [object methodForSelector:instanceMethod];
                UIViewController * (*func)(id, SEL, NSDictionary*) = (void *)tImp;
                object = func(object, instanceMethod, queryForInstanceM);
            }
        }
    }
}

#pragma mark -config load
- (NSDictionary *)viewMapFromFile:(NSString *)fileName
{
    NSString *viewMapPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSArray  *viewMaps    = [NSArray arrayWithContentsOfFile:viewMapPath];
    
    NSMutableDictionary *viewConfigs = [NSMutableDictionary dictionary];
    if (viewMaps && [viewMaps count]) {
        for (NSDictionary *viewMap in viewMaps) {
            NSString *className  = [viewMap safeObjectForKey:@"className"];
            NSString *identifier = [viewMap safeObjectForKey:@"identifier"];
            if (className && [className length] && identifier && [identifier length]) {
                Class viewClass = NSClassFromString(className);
                //YHNavigatorProtocol协议规范的方法
                SEL initMethod     = nil;
                SEL instanceMethod = nil;
                if (YES == class_respondsToSelector(viewClass, @selector(initWithQuery:))) {
                    initMethod = @selector(initWithQuery:);
                    if (class_respondsToSelector(viewClass, @selector(doInitializeWithQuery:))) {
                        instanceMethod = @selector(doInitializeWithQuery:);
                    }
                }
                 // 创建viewcontroller配置对象
                PRMBPageIDCard *viewDataModel    = [[PRMBPageIDCard alloc]init];
                viewDataModel.viewClass          = viewClass;
                viewDataModel.viewInitMethod     = [NSValue valueWithPointer:initMethod];
                viewDataModel.viewInstanceMethod = [NSValue valueWithPointer:instanceMethod];
                [viewConfigs setObject:viewDataModel forKey:identifier];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:viewConfigs];
}

-(void)readViewControllerConfigurations{
    self.viewModalDict = [self viewMapFromFile:@"ViewMap"];
}

#pragma mark - init
-(instancetype)init{
    if (self = [super init]) {
        //读取viewcontroller相关配置
        [self readViewControllerConfigurations];
    }
    return self;
}
@end
