//
//  CommitErrorHandler.m
//  YHClouds
//
//  Created by 黄小雪 on 2017/4/27.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "CommitErrorHandler.h"
#import "AlterView.h"
#import "CartModelDefine.h"
//#import "OrderDetail.h"
#import "ServiceCenter.h"
//#import "LocalShopCartHandle.h"


@implementation CommitErrorHandler
-(void)outStockOrOffShelveWithData:(id)data error:(NSError*)error;
{
//    AlterView *alterView = [[AlterView alloc]initWithcancelBtnTitle:@"取消"
//                                                     commitBtnTitle:@"更新购物车"
//                                                            message:[error localizedDescription]
//                                                           delegate:self];
//    alterView.tag       = AlterViewTypeRefreshCart;
//    [alterView show];
}



#pragma mark alterView的代理
- (void) alterViewClickedCommitButton:(AlterView *)alterView;
{
//    if (alterView.tag == AlterViewTypeRefreshCart){
//        BuryingPointEvent(@"Popup_click", @{@"popup_type":@"已下架",@"button_type":@"left"});
//        [self.holder requestShopcartProductList];
//    }
}

-(void) alertViewCancel:(UIAlertView *)alertView{
//    if (alertView.tag == AlterViewTypeRefreshCart){
//        BuryingPointEvent(@"Popup_click", @{@"popup_type":@"已下架",@"button_type":@"left"});
//    }else if (alertView.tag == AlterViewTypeRestr){
//        BuryingPointEvent(@"Popup_click", @{@"popup_type":@"限购提示",@"button_type":@"right"});
//    }
}

@end
