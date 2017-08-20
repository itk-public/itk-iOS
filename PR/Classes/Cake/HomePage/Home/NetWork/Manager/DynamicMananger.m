//
//  DynamicMananger.m
//  PR
//
//  Created by 黄小雪 on 12/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "DynamicMananger.h"
#import "MTCacheCenter.h"
#import "HomeAPIInteract.h"

@interface DynamicMananger()

@property(nonatomic,getter = isInCacheObtain,assign)     BOOL inCacheObtain;
@property(nonatomic,getter = isServerDataArrived,assign) BOOL serverDataArrived;
@property (strong,nonatomic) HomeAPIInteract *interact ;

@end


@implementation DynamicMananger
-(void)requestDynamicUIModel:(BOOL)needCache
{
    NSString *homeModelSubName = @"sInfo";
    self.serverDataArrived = NO;
    if (needCache && NO == self.inCacheObtain) {
        self.inCacheObtain = YES;
        [MTCacheCenter getElementByName:MTCacheElementHomeData
                                subName:homeModelSubName completion:^(id cache) {
                                    if (NO == self.serverDataArrived) {
                                        id theModel = cache;
                                        if ([cache isKindOfClass:[NSArray class]]) {
                                            theModel = [(NSArray *)cache firstObject];
                                        }
                                        if (theModel != nil) {
                                            [self.delegate requestDynamicUIModelSuccess:theModel isCache:YES];
                                        }
                                        self.inCacheObtain = NO;
                                    }
                                }];
    }
    if (self.interact == nil) {
        self.interact = [[HomeAPIInteract alloc]init];
    }
    OSStatus status = [self.interact interactScuess:^(BaseAPIInteract *interact, id modelData) {
        [MTCacheCenter saveElement:modelData
                       elementName:MTCacheElementHomeData
                           subName:homeModelSubName completion:^{
                               
                           }];
        self.serverDataArrived = YES;
        [self.delegate requestDynamicUIModelSuccess:modelData isCache:NO];
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        [self.delegate requestDynamicUIModelFailed:error];
    }];
    if (status != noErr) {
        [self.delegate requestDynamicUIModelFailed:nil];
    }
}
@end
