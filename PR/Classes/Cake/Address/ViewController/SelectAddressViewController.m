//
//  SelectAddressViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/5/16.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SelectAddressViewController.h"
#import "SelectAddressDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"
#import "PRMBWantedOffice.h"

#define kFooterBtnH   49
@interface SelectAddressViewController ()<WTNetWorkDataConstructorDelegate,UISearchBarDelegate>
@property (strong,nonatomic) SelectAddressDataConstructor *dataConstructor;
@property (strong,nonatomic) UIButton *footerBtn;
@end

@implementation SelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _needLogin = YES;
    self.navTitle = @"选择收货地址";
    [self addTableViewHeaderView];
    [self addFooterBtn];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.footerBtn.frame = CGRectMake(0, self.view.height - 49, self.view.width, 49);
    self.tableView.height = self.view.height - self.footerBtn.height;
}
-(void)addTableViewHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    UISearchBar *bar   = [[UISearchBar alloc]initWithFrame:headerView.bounds];
    bar.placeholder    = @"搜索你的收货地址";
    bar.delegate       = self;
    [headerView addSubview:bar];
    [self.tableView setTableHeaderView:headerView];
}

-(void)addFooterBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:kColorTheme];
    [btn.titleLabel setFont:KFontNormal(18)];
    [btn setTitle:@"新建收货地址" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(footerBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.footerBtn = btn;
}

-(void)loadData
{
    [[PRLoadingAnimation sharedInstance]addLoadingAnimationOnView:self.view];
    [self.dataConstructor loadData];
}

#pragma mark ---getter ---
-(void)constructData
{
    if (self.dataConstructor == nil) {
        self.dataConstructor = [[SelectAddressDataConstructor alloc]init];
        self.dataConstructor.delegate = self;
    }
    self.tableViewAdaptor.items = self.dataConstructor.items;
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

#pragma mark  UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    PRLOG(@"========%@",searchBar.text);
}

//新建收货地址
-(void)footerBtnOnClicked
{
    [PRMBWantedOffice nativeArrestWarrant:APPURL_VIEW_IDENTIFIER_CREATEADDRESS param:nil];
}
@end
