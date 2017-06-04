//
//  OrderDetailDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderDetailDataConstructor.h"
#import "ShopInfoViewCell.h"
#import "OrderDetailProductViewCell.h"
#import "SeparateCell.h"
#import "PromptViewCell.h"
#import "OrderDetailActionViewCell.h"
#import "DeliveryAddressViewCell.h"
#import "OrderStatusFlowViewCell.h"


#import "YHDataModel.h"

@interface TestModel :YHDataModel

@end

@implementation TestModel

@end
@implementation OrderDetailDataConstructor
-(void)constructData
{
    [self.items removeAllObjects];
    
#warning 构造假数据
    
    PromptModel *model15 = [[PromptModel alloc]init];
    model15.cellClass    = [OrderStatusFlowViewCell class];
    model15.identifier     = @"OrderStatusFlowViewCell";
    [self.items addObject:model15];
    
    SeparateModel *model14 = [[SeparateModel alloc]init];
    model14.identifier = @"sparatemodel";
    model14.cellClass = [SeparateCell class];
    [self.items addObject:model14];
    
    PromptModel *model12 = [[PromptModel alloc]init];
    model12.cellClass    = [DeliveryAddressViewCell class];
    model12.identifier     = @"DeliveryAddressViewCell";
    [self.items addObject:model12];

    
    SeparateModel *model13 = [[SeparateModel alloc]init];
    model13.identifier = @"sparatemodel";
    model13.cellClass = [SeparateCell class];
    [self.items addObject:model13];

    
    TestModel *model1 = [[TestModel alloc]init];
    model1.identifier = @"shopInfoViewCell";
    model1.cellClass = [ShopInfoViewCell class];
    [self.items addObject:model1];
    
    TestModel *model2 = [[TestModel alloc]init];
    model2.identifier = @"OrderDetailProductViewCell";
    model2.cellClass = [OrderDetailProductViewCell class];
    [self.items addObject:model2];
    
    SeparateModel *model3 = [[SeparateModel alloc]init];
    model3.identifier = @"sparatemodel";
    model3.cellClass = [SeparateCell class];
    [self.items addObject:model3];
    
    PromptModel *model5 = [[PromptModel alloc]init];
    model5.identifier     = @"PromptViewCell";
    model5.cellClass    = [PromptViewCell class];
    model5.promptString = @"预约配送";
    model5.valueString  = @"2017.01.23 09:30 -10:30";
    model5.cellHeight   = @(45);
    [self.items addObject:model5];
    
    PromptModel *model6 = [[PromptModel alloc]init];
    model6.identifier     = @"PromptViewCell";
    model6.cellClass    = [PromptViewCell class];
    model6.promptString = @"下单时间";
    model6.valueString  = @"2017.01.23 09:30";
    model6.cellHeight   = @(45);
    [self.items addObject:model6];
    
    SeparateModel *model7 = [[SeparateModel alloc]init];
    model7.identifier = @"sparatemodel";
    model7.cellClass = [SeparateCell class];
    [self.items addObject:model7];
    
    PromptModel *model8 = [[PromptModel alloc]init];
    model8.identifier     = @"PromptViewCell";
    model8.cellClass    = [PromptViewCell class];
    model8.promptString = @"运费";
    model8.valueString  = @"￥0.0";
    model8.hideLineView = YES;
    model8.cellHeight   = @(25);
    [self.items addObject:model8];
    
    PromptModel *model9 = [[PromptModel alloc]init];
    model9.identifier     = @"PromptViewCell";
    model9.cellClass    = [PromptViewCell class];
    model9.promptString = @"实付款(含运费)";
    model9.valueString  = @"￥258.00";
    model9.hideLineView = YES;
    model9.valueColor   = [UIColor orangeColor];
    model9.cellHeight   = @(25);
    [self.items addObject:model9];
    
    SeparateModel *model11 = [[SeparateModel alloc]init];
    model11.identifier = @"sparatemodel";
    model11.cellClass = [SeparateCell class];
    [self.items addObject:model11];
    
    
    PromptModel *model10 = [[PromptModel alloc]init];
    model10.cellClass    = [OrderDetailActionViewCell class];
    model10.identifier     = @"OrderDetailActionViewCell";
    [self.items addObject:model10];
    
}
@end
