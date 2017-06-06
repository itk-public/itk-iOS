//
//  CategoryLeftViewController.m
//  PR
//
//  Created by 黄小雪 on 2017/6/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CategoryLeftViewController.h"
#import "CategoryLeftDataConstructor.h"
#import "PRLoadingAnimation.h"
#import "PRShowToastUtil.h"
#import "ShopCategoryModel.h"

@interface CategoryLeftViewController ()<WTNetWorkDataConstructorDelegate>
@property (strong,nonatomic) CategoryLeftDataConstructor *dataConstructor;
@property (strong,nonatomic) ShopCategoryModel *lastSelecteModel;
@end

@implementation CategoryLeftViewController
-(void)loadData
{
    [self.dataConstructor loadData];
}
-(void)constructData
{
    if (self.dataConstructor == nil) {
        self.dataConstructor = [[CategoryLeftDataConstructor alloc]init];
        self.dataConstructor.delegate = self;
    }
    self.tableViewAdaptor.items = self.dataConstructor.items;
}

-(void)tableView:(UITableView *)tableView  didSelectObject:(id<YHTableViewCellItemProtocol>)object
  rowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCategoryModel *model = [self.tableViewAdaptor.items safeObjectAtIndex:indexPath.row hintClass:[ShopCategoryModel class]];
    if (model && self.lastSelecteModel == model) {
        return;
    }
    if (self.lastSelecteModel && self.lastSelecteModel != model) {
        self.lastSelecteModel.isSelected = NO;
    }
    model.isSelected = YES;
    self.lastSelecteModel = model;
    if (self.returnBlock) {
        self.returnBlock(model);
    }
    [tableView reloadData];
}
#pragma mark WTNetWorkDataConstructorDelegate
- (void)dataConstructor:(id)dataConstructor didFinishLoad:(id)dataModel
{
    [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    [self.dataConstructor constructData];
    if (self.returnBlock) {
        self.returnBlock([self.dataConstructor.items safeObjectAtIndex:0]);
        self.lastSelecteModel = [self.dataConstructor.items safeObjectAtIndex:0];
        self.lastSelecteModel.isSelected = YES;
        
    }
     [self.tableView reloadData];
}

- (void)dataConstructorDidFailLoadData:(id)dataConstructor withError:(NSError *)errorDataModel
{
    [[PRLoadingAnimation sharedInstance]removeLoadingAnimation:self.view];
    [PRShowToastUtil showNotice:[errorDataModel localizedDescription] inView:self.view];
    
}

@end
