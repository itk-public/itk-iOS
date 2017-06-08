//
//  GoodDetailViewController.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "GoodDetailDataConstructor.h"
#import "GoodDetailModel.h"
#import "WTImageView.h"

@interface GoodDetailViewController ()<WTNetWorkDataConstructorDelegate>
@property (strong,nonatomic) GoodDetailDataConstructor *dataConstructor;
@property (strong,nonatomic) NSMutableDictionary *tempPicDetailDict;
@end

@implementation GoodDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataConstructor loadData];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setAlpha:0];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)constructData
{
    if (self.dataConstructor == nil) {
        self.dataConstructor = [[GoodDetailDataConstructor alloc]init];
        self.dataConstructor.delegate = self;
    }
    self.tableViewAdaptor.items = self.dataConstructor.items;
}

-(NSMutableDictionary *)tempPicDetailDict
{
    if (_tempPicDetailDict == nil) {
        _tempPicDetailDict = [[NSMutableDictionary alloc]init];
    }
    return _tempPicDetailDict;
}
- (void)updateWithProductImage:(UIImage *)image forURL:(NSString *)url
{
    // 为了支持变高 & 懒加载，因此这里load一张图片就刷新这个整个页面的数据
    // 因此会触发多次数据到了的情况
    if (nil == image) {
        [self.tempPicDetailDict setObject:[NSNull null] forKey:url];
    }else{
        [self.tempPicDetailDict setObject:image forKey:url];
    }
    [self loadTabelViewWithPictureArray:self.tempPicDetailDict];
}


- (void)loadTabelViewWithPictureArray:(NSDictionary *)imageDict
{
    
    self.dataConstructor.dcPictureDetailImageDict = imageDict;
    [self.dataConstructor constructData];
    [self.tableView reloadData];
}


#pragma mark - WTNetWorkDataConstructorDelegate
- (void)dataConstructor:(id)dataConstructor didFinishLoad:(NSObject *)dataModel
{
    GoodDetailModel *tM = (GoodDetailModel *)dataModel;
    if ([tM.pictureDetail count]) {
        
         [self.tempPicDetailDict removeAllObjects];
        for (NSString *str in tM.pictureDetail)
        {
            [self.tempPicDetailDict setObject:[NSNull null] forKey:str];
        }
        [self loadTabelViewWithPictureArray:self.tempPicDetailDict];
    }
    
    __weak typeof(self) weakself = self;
    for (NSString *str in tM.pictureDetail) {
        WTImageView * detailImgView = [[WTImageView alloc] initWithFrame:CGRectMake(INT16_MAX, INT16_MAX, 10, 1)];
        [self.view addSubview:detailImgView];
        detailImgView.defaultImage = [UIImage new];
        detailImgView.urlPath = str;
        detailImgView.imageDidLoadHandler = ^(WTImageView * imageView, UIImage * image) {
            [weakself updateWithProductImage:image forURL:imageView.urlPath];
        };
        [detailImgView reload];

    }
}
- (void)dataConstructorDidFailLoadData:(id)dataConstructor withError:(NSError *)errorDataModel
{
    
}
@end
