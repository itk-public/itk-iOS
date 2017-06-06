//
//  UserCenterDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "UserCenterDataConstructor.h"
#import "ItemListModel.h"
#import "HeadPortraitCell.h"
#import "ItemViewCell.h"
#import "AssetsCell.h"
#import "OrderCell.h"
#import "SeparateCell.h"
#import "UserCenterModel.h"
#import "SeparateCell.h"
#import "UserDataManager.h"


@interface UserCenterDataConstructor()<UserDataManagerDelegate>
@property (strong,nonatomic) NSMutableArray *itemList;
@property (strong,nonatomic) UserDataManager *userManager;
@property (strong,nonatomic) UserCenterModel *userCenter;

@end
@implementation UserCenterDataConstructor

-(UserDataManager *)userManager
{
    if (_userManager == nil) {
        _userManager = [[UserDataManager alloc]init];
        _userManager.delegate = self;
    }
    return _userManager;
}

-(void)loadData
{
    [self.userManager getCenterInfo];
}
-(void)constructData
{
    [self.items removeAllObjects];
    UserInfo *userInfo = self.userCenter.userInfo;
    if (userInfo == nil) {
        userInfo = [[UserInfo alloc]init];
    }
    userInfo.cellClass = [HeadPortraitCell class];
    userInfo.cellIdentifier  = @"headPortraitcell";
    [self.items addObject:userInfo];
    
    AssetsInfo *asstsInfo = self.userCenter.assetInfo;
    if (asstsInfo == nil) {
        asstsInfo = [[AssetsInfo alloc]init];
    }
    asstsInfo.cellIdentifier  = @"assetsCell";
    asstsInfo.cellClass = [AssetsCell class];
    [self.items addObject:asstsInfo];
    
    SeparateModel *separateModel1 = [[SeparateModel alloc]init];
    separateModel1.cellClass      = [SeparateCell class];
    separateModel1.cellIdentifier      = @"separatecell";
    [self.items addObject:separateModel1];
    
    OrderInfo *orderinfo = self.userCenter.orderInfo;
    if (orderinfo == nil) {
        orderinfo = [[OrderInfo alloc]init];
    }
    orderinfo.cellClass  = [OrderCell class];
    orderinfo.cellIdentifier   = @"orderCell";
    [self.items addObject:orderinfo];
    
    SeparateModel *separateModel2 = [[SeparateModel alloc]init];
    separateModel2.cellClass      = [SeparateCell class];
    separateModel2.cellIdentifier       = @"separatecell";
    [self.items addObject:separateModel2];
    
    [self.items safeAddObjectsFromArray:self.itemList];
    
}


-(NSArray *)itemList{
    if (!_itemList) {
        _itemList = [NSMutableArray array];
        NSString *filePath     = [[NSBundle mainBundle]pathForResource:@"UserInfoItem.plist" ofType:nil];
        NSArray *itemInfo      = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *dict in  itemInfo) {
            ItemListModel *info = [ItemListModel modelFromDictionary:dict];
            info.cellClass      = [ItemViewCell class];
            info.cellIdentifier       = @"itemViewCell";
           [_itemList addObject:info];
        }
    }
    return _itemList;
}

#pragma mark usermanager的代理
-(void)loadDataSuccessful:(UserDataManager *)manager dataType:(UserDataManangerType)dataType  data:(id)data  isCache:(BOOL)isCache
{
    if (data && [data isKindOfClass:[UserCenterModel class]]) {
        self.userCenter = data;
        if ([self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
            [self.delegate dataConstructor:self didFinishLoad:nil];
        }
        
    }
}
-(void)loadDataFailed:(UserDataManager *)manager dataType:(UserDataManangerType)dataType error:(NSError*)error
{
    if ([self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}
@end
