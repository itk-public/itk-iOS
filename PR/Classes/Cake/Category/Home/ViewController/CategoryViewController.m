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
#import "CategoryDefine.h"
#import "OnePixelSepView.h"

@interface CategoryViewController ()
@property (strong,nonatomic) CategoryLeftViewController *leftVc;
@property (strong,nonatomic) CategroyRightViewController *rightVc;


@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftVc = [[CategoryLeftViewController alloc]init];
    __weak typeof(self)weakSelf = self;
    self.leftVc.returnBlock = ^(ShopCategoryModel *selectedCategroy){
       [weakSelf.rightVc loadData];
    };
    [self.view addSubview:self.leftVc.view];
    
    self.rightVc = [[CategroyRightViewController alloc]init];
    [self.view addSubview:self.rightVc.view];
    [self addHeaderView];
}

-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.navigationController.navigationBar.hidden = YES;
   [self.leftVc loadData];
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.leftVc.view.frame = CGRectMake(0, 64, kCategoryLeftViewW, self.view.height - 64);
    self.rightVc.view.frame = CGRectMake(self.leftVc.view.width, 64, self.view.width - self.leftVc.view.width, self.view.height - 64);
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)addHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    UISearchBar *bar   = [[UISearchBar alloc]initWithFrame:CGRectMake(0,24 , headerView.width, 30)];
    [bar setBackgroundColor:[UIColor clearColor]];
    bar.tintColor = [UIColor redColor];
    bar.placeholder    = @"搜索附近的商品和商店";
    [headerView addSubview:bar];
    UIButton *backBtn  = [[UIButton alloc]initWithFrame:headerView.bounds];
    [headerView addSubview:backBtn];
    [headerView setPixelSepSet:PSRectEdgeBottom];
    [self.view addSubview:headerView];
}

@end
