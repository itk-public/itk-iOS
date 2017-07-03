//
//  SetupViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/6/22.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SetupViewController.h"
#import "SeparateCell.h"
#import "SetupDefine.h"
#import "FileManager.h"
#import "SetupLogoutView.h"
#import "UserManager.h"
#import "SetupViewCell.h"


@interface SetupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSDictionary *pwdDic;
@property (strong,nonatomic) NSMutableArray *dataSource;
@property (strong,nonatomic) SetupLogoutView   *logoutView;
@property (strong,nonatomic) UITableView       *tableView;

@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"设置";
    [self addTableView];
    [self structureDataSource];
    [self addLogoutView];
}

-(void)addTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:kVCViewBGColor];
    [self.view addSubview:self.tableView];
}

-(void)adjustUI
{
    if ([[UserManager shareMananger] isUserLogin]) {
        if (![self.dataSource containsObject:self.pwdDic]) {
            [self.dataSource insertObject:self.pwdDic atIndex:0];
            [self.tableView setTableFooterView:self.logoutView];
        }
    }else if ([self.dataSource containsObject:self.pwdDic]){
        [self.dataSource removeObject:self.pwdDic];
        [self.tableView setTableFooterView:nil];
    }
    [self.tableView reloadData];
}

-(void)structureDataSource
{

    SeparateModel *separate1 = [[SeparateModel alloc]init];
    //登录密码
    NSDictionary *pwdDic = @{kLeftString:@"修改密码",kTnteractiveType:@(SetupViewTnteractiveTypeModifyPwd)};
    self.pwdDic          = pwdDic;

    
    //清除本地缓存
    NSDictionary *clearCacheDic = @{kLeftString:@"清除本地缓存",kSubTitleString: [NSString stringWithFormat:@"%@M",[FileManager getCacheSize]],kTnteractiveType:@(SetupViewTnteractiveTypeClearCache)};
    
     SeparateModel *separate2 = [[SeparateModel alloc]init];

    //版本信息
    // 获取版本号
    NSString *version       = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];//获取项目版本号
//    NSString * patchVersion = [WTPatchService patchVersion];
     NSString * patchVersion = @"1.0";
    if (patchVersion) {
        version                  = [NSString stringWithFormat:@"V%@.%@",version,patchVersion];
    }
    NSDictionary *versionInfoDic = @{kLeftString:@"版本信息",kTnteractiveType:@(SetupViewTnteractiveTypeVersionInfo)};
    
    //关于我们
    NSDictionary *aboutUsDic = @{kLeftString:@"关于",kTnteractiveType:@(SetupViewTnteractiveTypeAbout)};
    
     SeparateModel *separate3 = [[SeparateModel alloc]init];
     SeparateModel *separate4 = [[SeparateModel alloc]init];
    NSArray *tempArrary = @[separate1,pwdDic,clearCacheDic,separate2 ,versionInfoDic,aboutUsDic,separate3,separate4];
    self.dataSource = [NSMutableArray arrayWithArray:tempArrary];
    
}
-(void)addLogoutView
{
    self.logoutView = [[SetupLogoutView alloc]init];
    self.logoutView.frame = CGRectMake(0, 0, 0, [SetupLogoutView getHeight]);
    __weak typeof(self)weakSelf = self;
    self.logoutView.returnBlock = ^{
//        [weakSelf logout];
    };
}


#pragma mark tableview的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource) {
        return [self.dataSource count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataSource safeObjectAtIndex:indexPath.row];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [SetupViewCell tableView:tableView rowHeightForObject:nil];
    }
    return [SeparateCell tableView:tableView rowHeightForObject:nil];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataSource safeObjectAtIndex:indexPath.row];
    if ([object isKindOfClass:[NSDictionary class]]) {
        static NSString *ID = @"SetupViewCell";
        SetupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[SetupViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        [cell setObject:object];
        return cell;
    }
    static NSString *ID = @"SetupSeparateViewCell";
    SeparateCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SeparateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
    
}


@end
