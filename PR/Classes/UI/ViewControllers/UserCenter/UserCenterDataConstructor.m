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


@interface UserCenterDataConstructor()
@property (strong,nonatomic) NSMutableArray *itemList;

@end
@implementation UserCenterDataConstructor

-(void)constructData
{
    [self.items removeAllObjects];
    
//    UserCenterModel *model = [[UserCenterModel alloc]init];
//    [self.items addObject:model];
//    
//    [self.items addObjectsFromArray:self.itemList];
    
    UserInfo *userInfo = [[UserInfo alloc]init];
    userInfo.cellClass = [HeadPortraitCell class];
    userInfo.cellType  = @"headPortraitcell";
    [self.items addObject:userInfo];
    
    AssetsInfo *asstsInfo = [[AssetsInfo  alloc]init];
    asstsInfo.cellType  = @"assetsCell";
    asstsInfo.cellClass = [AssetsCell class];
    [self.items addObject:asstsInfo];
    
    SeparateModel *separateModel1 = [[SeparateModel alloc]init];
    separateModel1.cellClass      = [SeparateCell class];
    separateModel1.cellType       = @"separatecell";
    [self.items addObject:separateModel1];
    
    OrderInfo *orderinfo = [[OrderInfo alloc]init];
    orderinfo.cellClass  = [OrderCell class];
    orderinfo.cellType   = @"orderCell";
    [self.items addObject:orderinfo];
    
    SeparateModel *separateModel2 = [[SeparateModel alloc]init];
    separateModel2.cellClass      = [SeparateCell class];
    separateModel2.cellType       = @"separatecell";
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
            info.cellType       = @"itemViewCell";
           [_itemList addObject:info];
        }
    }
    return _itemList;
}
@end
