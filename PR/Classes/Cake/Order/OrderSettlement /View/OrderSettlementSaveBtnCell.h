//
//  OrderSettlementSaveBtnCell.h
//  PR
//
//  Created by 黄小雪 on 2017/9/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
#import "YHDataModel.h"

@protocol OrderSettlementSaveBtnCellDelegate <NSObject>
-(void)orderSettlementSaveBtnOnClicked;
@end

@interface OrderSettlementSaveBtnCellModel : YHDataModel

@end

@interface OrderSettlementSaveBtnCell : WTTableViewCell
@property (weak,nonatomic) id<OrderSettlementSaveBtnCellDelegate> delegate;
@end
