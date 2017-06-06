//
//  CategroyRightViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/6/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CategroyRightViewController.h"
#import "CategoryRightDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"

@interface CategroyRightViewController ()<WTNetWorkDataConstructorDelegate>
@property (strong,nonatomic) CategoryRightDataConstructor *dataConstructor;
@end

@implementation CategroyRightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)loadData
{
    [self.dataConstructor loadData];
}
-(void)constructData
{
    if (self.dataConstructor == nil) {
        self.dataConstructor = [[CategoryRightDataConstructor alloc]init];
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

@end
