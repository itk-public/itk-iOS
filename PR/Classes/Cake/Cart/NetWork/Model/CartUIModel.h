//
//  CartUIModel.h
//  PR
//
//  Created by 黄小雪 on 15/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

@interface CartUIModel : YHDataModel
@property (readonly,nonatomic) NSArray *cartList;
@property (readonly,nonatomic) NSString *pricetotal;
@end
