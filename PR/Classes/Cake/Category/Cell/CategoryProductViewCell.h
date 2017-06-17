//
//  CategoryProductViewCell.h
//  PR
//
//  Created by 黄小雪 on 2017/6/5.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
#import "YHDataModel.h"
#import "ProductOutline.h"

//1行3个
@interface CategoryProductViewCellModel : YHDataModel
@property (strong,nonatomic) NSMutableArray<ProductOutline *> *products;
@end

@interface CategoryProductViewCell : WTTableViewCell

@end
