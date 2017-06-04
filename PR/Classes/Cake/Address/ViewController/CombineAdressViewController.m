//
//  CombineAdressViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/5/31.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CombineAdressViewController.h"
#import "SelectAddressViewController.h"
#import "SelectPickUpSiteViewController.h"

@interface CombineAdressViewController ()
@property (strong,nonatomic) UISegmentedControl  *segment;
@property (strong,nonatomic) SelectAddressViewController *addressVC;
@property (strong,nonatomic) SelectPickUpSiteViewController *siteVC;

@end

@implementation CombineAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatChooseAddressTypeBtn];
    self.addressVC = [[SelectAddressViewController alloc]init];
    self.siteVC    = [[SelectPickUpSiteViewController alloc]init];
    [self addChildViewController:self.addressVC];
    [self addChildViewController:self.siteVC];
    [self.view addSubview:self.addressVC.view];
    [self.view addSubview:self.siteVC.view];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.segment setSelectedSegmentIndex:self.selectedSegmentIndex];
    [self segmentValueChanged:self.segment];
}
#pragma mark --- 配置segmentCollector
-(void)creatChooseAddressTypeBtn
{
    UISegmentedControl  *segment  = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 100, 24)];
    segment.momentary             = NO;
    segment.tintColor             = kColorTheme ;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@" " size:15.f],NSFontAttributeName ,nil];
    [segment setTitleTextAttributes:dic forState:UIControlStateSelected];
    [segment insertSegmentWithTitle:@"送货上门" atIndex:0 animated:NO];
    [segment insertSegmentWithTitle:@"门店自提" atIndex:1 animated:NO];
    [segment setWidth:170];
    CGRect frame  = segment.frame;
    [segment setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 32)];
    [segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex  = self.selectedSegmentIndex;
    self.navigationItem.titleView = segment;
    self.segment                  = segment;
    
}

-(void)segmentValueChanged:(UISegmentedControl *)segement
{
    if (segement.selectedSegmentIndex == 0) {
        [self.addressVC loadData];
        self.addressVC.view.frame = self.view.bounds;
        self.siteVC.view.frame    = CGRectMake(-self.view.width, 0, self.view.width, self.view.height);
    }else{
        [self.siteVC loadData];
        self.siteVC.view.frame = self.view.bounds;
        self.addressVC.view.frame    = CGRectMake(-self.view.width, 0, self.view.width, self.view.height);
    }
}

-(void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    self.segment.selectedSegmentIndex = selectedSegmentIndex;
//    [self segmentValueChanged:self.segment];
}
@end
