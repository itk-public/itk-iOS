//
//  ItemListModel.h
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

typedef NS_ENUM(NSInteger,ItemType)
{
    ItemTypeH5  = 0,    //H5
    ItemTypeAddress,    //地址管理
    ItemTypeFeedback,   //意见反馈
    
};
@interface ItemListModel : YHDataModel
@property (readonly,nonatomic) ItemType type;
@property (readonly,nonatomic) NSString *iconName;
@property (readonly,nonatomic) NSString *title;
@property (readonly,nonatomic) NSString *action;
@end
