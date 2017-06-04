//
//  CategoryViewController.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryLeftViewController.h"
#import "CategroyRightViewController.h"

@interface CategoryViewController ()
@property (strong,nonatomic) CategoryLeftViewController *leftVc;
@property (strong,nonatomic) CategroyRightViewController *rightVc;


@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"分类";
    self.leftVc = [[CategoryLeftViewController alloc]init];
    [self.view addSubview:self.leftVc.view];
    
    self.rightVc = [[CategroyRightViewController alloc]init];
    [self.view addSubview:self.rightVc.view];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.leftVc loadData];
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.leftVc.view.frame = CGRectMake(0, 0, 80*DDDisplayScale, self.view.height);
    self.rightVc.view.frame = CGRectMake(self.leftVc.view.width, 0, self.view.width - self.leftVc.view.width, self.view.height);
}

@end
