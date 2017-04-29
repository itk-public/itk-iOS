//
//  PRTabbarItem.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PRTabbarItem : NSObject

@property (strong,nonatomic) UIViewController *rootvc;
@property (nonatomic,strong) UIImage          * image;
@property (nonatomic,strong) UIImage          * selectedImage;
@property (nonatomic,strong) NSString         * tabbarTitle;

+ (instancetype)mainPage;
+ (instancetype)categoryPage;
+ (instancetype)cartPage;
+ (instancetype)userCenterPage;

- (UINavigationController *) vcInNavViewController;

@end
