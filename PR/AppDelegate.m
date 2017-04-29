//
//  AppDelegate.m
//  PR
//
//  Created by 黄小雪 on 04/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "AppDelegate.h"
#import "SceneMananger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


+(instancetype)sharedAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //构建window
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor  = [UIColor whiteColor];
    [self checkWhetherOpen];
    return YES;
}


-(void)checkWhetherOpen
{
     [[SceneMananger shareMananger] setupRootViewController];
}

@end
