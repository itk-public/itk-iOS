//
//  AddressListModel.h
//  PR
//
//  Created by 黄小雪 on 2017/5/16.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"
#import "AddressModel.h"

@interface AddressListModel : YHDataModel
@property (readonly,nonatomic) NSArray<AddressModel *> *addressList;
@end
