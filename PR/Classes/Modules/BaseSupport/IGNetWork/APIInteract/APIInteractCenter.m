//
//  APIInteractCenter.m
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "APIInteractCenter.h"
#import "BaseAPIInteract.h"

@interface APIInteractCenter()
{
    NSMutableDictionary *_interactorPool;
}
@property(nonatomic,readonly)NSMutableDictionary * pool;
@end

@implementation APIInteractCenter
@synthesize  pool = _interactorPool;
IMP_SINGLETON;

-(void)registerAPICall:(NSString *)identify interactor:(id)interactor{
    NSMutableArray *saveInteractors = [self.pool safeObjectForKey:identify];
    if (nil == saveInteractors) {
        saveInteractors = [[NSMutableArray alloc]init];
        [self.pool safeSetObject:saveInteractors forKey:identify];
    }
    [saveInteractors addObject:interactor];
}

-(void)cancelAPICall:(NSString *)identify interactor:(id)interactor
{
    if (interactor) {
        [self finishAPICall:identify interactor:interactor];
    }
}


-(void)cancelAllIdentifyAPICall:(NSString *)identify{
   //删除所有的
    NSMutableArray *savedInteractors = [self.pool safeObjectForKey:identify];
    for (id aSubInteractor in savedInteractors ) {
         [(BaseAPIInteract *)aSubInteractor cancelInteract];
    }
}

-(void)finishAPICall:(NSString *)identify interactor:(id)interactor{
    NSMutableArray *savedInteractors = [self.pool safeObjectForKey:identify];
    if (savedInteractors) {
        [savedInteractors removeObject:interactor];
    }
    // 这个key下没有interactor了，就从池中去除掉
    if ([savedInteractors count] == 0) {
        [self.pool removeObjectForKey:identify];
    }
}

-(BOOL)checkAPIIncall:(NSString *)identify{
    return [[self.pool safeObjectForKey:identify]count];
}


@end
