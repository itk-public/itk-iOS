//
//  SearchResultViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchReustDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"

@interface SearchResultViewController ()<WTNetWorkDataConstructorDelegate>
@property (strong,nonatomic) SearchReustDataConstructor *dataConstructor;
@end

@implementation SearchResultViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)addHeaderView
{
    ;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataConstructor loadData];
}

-(void)constructData
{
    if (self.dataConstructor == nil) {
        self.dataConstructor = [[SearchReustDataConstructor alloc]init];
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
