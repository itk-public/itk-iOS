//
//  UserCenterViewController.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "UserCenterViewController.h"
#import "LoginViewController.h"
#import "PRMBWantedOffice.h"
#import "UserCenterDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"
#import "HeadPortraitCell.h"
#import "SceneMananger.h"
#import "SetupViewController.h"

@interface UserCenterViewController ()<WTNetWorkDataConstructorDelegate>
@property (strong,nonatomic) UserCenterDataConstructor *dataConstructor;
@property (strong,nonatomic) UIImageView *zoomImageView;
@property (strong,nonatomic) UIButton *setBtn;
@end

@implementation UserCenterViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addZoomImageView];
    [self addSetBtn];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataConstructor loadData];
    [self.tableView reloadData];
    self.navigationController.navigationBar.hidden = YES;
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat kSetBtnTop = 28;
    CGFloat kSetBtnRightMargin = 10;
    CGFloat kSetBtnW  = 40;
    self.setBtn.frame = CGRectMake(self.view.width - kSetBtnRightMargin - kSetBtnW , kSetBtnTop, kSetBtnW, kSetBtnW);
}

-(void)addZoomImageView
{
    if (self.zoomImageView == nil) {
        self.zoomImageView             = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, kHeadPortraitCellHeight)];
        self.zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.zoomImageView.image       = [UIImage imageNamed:@"icon_userCenter_bg"];
        [self.tableView addSubview:self.zoomImageView];
        [self.tableView sendSubviewToBack:self.zoomImageView];
    }
}


-(void)addSetBtn
{
    UIButton *setBtn = [[UIButton alloc]init];
    [setBtn setImage:[UIImage imageNamed:@"icon_usercenter_setting"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setBtn];
    [self.view bringSubviewToFront:setBtn];
    self.setBtn = setBtn;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.hidden = NO;
}

- (void)constructData
{
    if (_dataConstructor == nil) {
        _dataConstructor          = [[UserCenterDataConstructor alloc] init];
        _dataConstructor.delegate = self;
    }
    self.tableViewAdaptor.items = self.dataConstructor.items;
}
#pragma mark - WTNetWorkDataConstructorDelegate
- (void)dataConstructor:(id)dataConstructor didFinishLoad:(id)dataModel
{
    [[PRLoadingAnimation sharedInstance] removeLoadingAnimation:self.view];
    [self.dataConstructor constructData];
    [self.tableView reloadData];
}


- (void)dataConstructorDidFailLoadData:(id)dataConstructor withError:(NSError *)errorDataModel
{
    [[PRLoadingAnimation sharedInstance] removeLoadingAnimation:self.view];
    [PRShowToastUtil showNotice:errorDataModel.localizedDescription];
}

- (void)tableViewDidScrolled:(UITableView *)tableView
{
    CGFloat y = tableView.contentOffset.y;
    if (y < 90) {
        CGRect frame             = self.zoomImageView.frame;
        frame.origin.y           = y;
        frame.size.height        = -y+ kHeadPortraitCellHeight;
        self.zoomImageView.frame = frame;
    }
}


-(void)setBtnOnClicked
{
    [[SceneMananger shareMananger]showViewController:[[SetupViewController alloc]init] withStyle:U_SCENE_SHOW_DEFAULT];
}
@end
