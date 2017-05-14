//
//  ServiceCenter.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SceneMananger;
@class UserManager;

@interface ServiceCenter : NSObject
{
     SceneMananger *               m_sceneManager;
     UserManager   *               m_userMananger;
}

@property (nonatomic,readonly) SceneMananger            *standardSceneManager;
@property (nonatomic,readonly) UserManager              *standardUserMananger;

+ (id)defaultCenter;
@end
