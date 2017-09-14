//
//  OrderListSectionFooterView.h
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
#import "YHDataModel.h"

@interface OrderListSubtotalViewCellModel : YHDataModel
@property (assign,nonatomic) NSInteger proudctCount;
@property (strong,nonatomic) NSString  *totalPayment;
@end

@interface OrderListSubtotalViewCell : WTTableViewCell

@end
