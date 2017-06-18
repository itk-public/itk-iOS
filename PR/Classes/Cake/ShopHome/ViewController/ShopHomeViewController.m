//
//  ShopHomeViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/6/10.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeViewController.h"
#import "ShopHomeDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"
#import "ShopHomeSectionHeaerView.h"
#import "ShopHomeShopInfoView.h"

@interface ShopHomeViewController ()<WTNetWorkDataConstructorDelegate>
@property (strong,nonatomic) ShopHomeDataConstructor *dataConstructor;
@property (strong,nonatomic) ShopHomeSectionHeaerView *sectionHeaderView;
@property (strong,nonatomic) ShopHomeShopInfoView     *shopInfoView;

@end

@implementation ShopHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"店铺首页";
    self.tableView.sectionHeaderHeight = [ShopHomeSectionHeaerView height];
    self.shopInfoView = [[ShopHomeShopInfoView alloc]init];
    self.shopInfoView.frame = CGRectMake(0, 0, 0, [ShopHomeShopInfoView height]);
    [self.tableView setTableHeaderView:self.shopInfoView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)loadData
{
    [self.dataConstructor loadData];
}
-(void)constructData
{
    if (self.dataConstructor == nil) {
        self.dataConstructor = [[ShopHomeDataConstructor alloc]init];
        self.dataConstructor.delegate = self;
    }
    self.tableViewAdaptor.items = self.dataConstructor.items;
}

- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section
{
    static NSString *ID = @"ShopHomeSectionHeaerView";
    if (self.sectionHeaderView == nil) {
        self.sectionHeaderView = [[ShopHomeSectionHeaerView alloc]initWithReuseIdentifier:ID];
    }
    return self.sectionHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
#pragma mark WTNetWorkDataConstructorDelegate
- (void)dataConstructor:(id)dataConstructor didFinishLoad:(id)dataModel
{
    [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    [self.dataConstructor constructData];
    [self.tableView reloadData];
}

- (void)dataConstructorDidFailLoadData:(id)dataConstructor withError:(NSError *)errorDataModel
{
    [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    [PRShowToastUtil showNotice:[errorDataModel localizedDescription] inView:self.view];
    
}



@end
