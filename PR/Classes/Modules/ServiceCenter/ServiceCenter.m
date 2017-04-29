//
//  ServiceCenter.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ServiceCenter.h"
#import "SceneMananger.h"
#import "UserManager.h"

@implementation ServiceCenter
@synthesize standardSceneManager       = m_sceneManager;
@synthesize standardUserMananger       = m_userMananger;

+ (id)defaultCenter
{
    static ServiceCenter * __center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __center = [[ServiceCenter alloc] init];
    });
//    [__center checkDoColorerConfig];
    return __center;
}


- (SceneMananger *)standardSceneManager
{
    if (nil == m_sceneManager) {
        m_sceneManager = [[SceneMananger alloc] init];
    }
    return m_sceneManager;
}

- (UserManager *)standardUserMananger
{
    if (nil == m_userMananger) {
        m_userMananger = [[UserManager alloc] init];
    }
    return m_userMananger;
}

@end
