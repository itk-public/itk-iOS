//
//  WTTableViewController.m
//  PR
//
//  Created by 黄小雪 on 18/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "WTTableViewController.h"

@interface WTTableViewController()<WTTableViewCellConfig>

@end
@implementation WTTableViewController

#pragma mark -functions
-(void)createTableView
{
    //初始化tableview
    self.tableView                      = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor      = [UIColor clearColor];
    self.tableView.backgroundView       = nil;
    self.tableView.separatorStyle       = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource           = self.tableViewAdaptor;
    self.tableView.delegate             = self.tableViewAdaptor;
    self.tableView.autoresizingMask     = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.tableViewAdaptor.tableView     = self.tableView;
    [self.view addSubview:self.tableView];
    
}

- (void)createTableViewAdaptor{
    self.tableViewAdaptor               = [[WTTableViewAdaptor alloc] init];
    self.tableViewAdaptor.delegate      = self;
    self.tableViewAdaptor.cellConfiger  = self;
}

//构造数据
- (void)constructData{
    // 子类实现
}

#pragma mark - initialize
- (void)wtInitialize{
    //创建tableview 适配类
    [self createTableViewAdaptor];
    
    //构造数据
    [self constructData];
    
    //创建tableview
    [self createTableView];
}

#pragma mark - view life circle
- (void)loadView
{
    [super loadView];
    //初始化
    [self wtInitialize];
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}


@end
