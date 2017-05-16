//
//  ShopcartFormat.m
//  YHClouds
//
//  Created by 黄小雪 on 2017/4/26.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "ShopcartFormat.h"

#import "CartTableViewDataSource.h"
#import "CartSectionData.h"
#import "CartModelDefine.h"

#import "UserManager.h"
#import "SceneMananger.h"
#import "ShopcartManager.h"

#import "AdjustDataSouceHandler.h"
#import "CommitErrorHandler.h"
#import "ParameterHandler.h"

#import "CartOrderCellViewModel.h"
#import "PRShowToastUtil.h"
#import "LocalShopcartDataHandler.h"

NSString * kToCommitStoridKey     = @"toCommitStorid";
NSString * kToCommitSelleridKey   = @"toCommitSellerid";

@interface ShopcartFormat()<ShopcartManagerDelegate>
@property (strong,nonatomic) ShopcartManager         *cartManager;
@property (strong,nonatomic) CartTableViewDataSource *dataSource;
//@property (strong,nonatomic) OrderManager            *orderGenerateManager;
@property (strong,nonatomic) NSString                *toCommitStorid;
@property (strong,nonatomic) NSString                *toCommitSellerid;
@property (strong,nonatomic) CommitErrorHandler      *commitErrorHandler;

@property (strong,nonatomic) AdjustDataSouceHandler  *adjustHandler;
@property (strong,nonatomic) LocalShopcartDataHandler *dataBaseHandler;
@end
@implementation ShopcartFormat

#pragma mark public method
- (void)requestShopcartProductList
{
     [self.cartManager refreshCart];
}

//勾选商品
- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected
{
    CartOrderCellViewModel *pModel = [self orderCellViewModelAtIndexPath:indexPath];
    CartSectionData *sellerData    = [self sellerDataAtIndex:indexPath.section];
    if (pModel == nil)  return;
    if (pModel.isEdit) { //编辑状态下(删除)
        pModel.deletedState = isSelected;
        pModel.isEdit       = YES;
        [sellerData.dataHandle upDateModel:pModel isEdit:YES seletedState:isSelected];
        [sellerData.dataHandle adjustFinalCellBottomLineView];
        if(self.reloadTableViewBlock){
            self.reloadTableViewBlock();
        }
    }else if(pModel.product.isOutOfStock && !isSelected){ //非编辑状态下，勾选的库存不足
        AlterView *view = [[AlterView alloc]initWithcancelBtnTitle:@"好"
                                                    commitBtnTitle:nil
                                                           message:[NSString stringWithFormat:@"\"%@\"库存不足,请根据提示修改",pModel.product.title]
                                                              delegate:nil];
        [view show];
    }else{ //非编辑状态下，正常能购买的商品
        pModel.product.isSelected = isSelected;
        [self.dataBaseHandler updateProductWithProductId:pModel.product.cid
                                                     num:pModel.product.num
                                              isSelected:isSelected
                                                  shopId:pModel.product.shopid
                                               extraInfo:nil];
        [sellerData.dataHandle adjustFinalCellBottomLineView];
        if(self.reloadTableViewBlock){
            self.reloadTableViewBlock();
        }
#warning 暂时在注释掉
//        [self requestShopcartProductList];
    }
}

//商家的全选或非全选操作
- (void)selectSellerAtSection:(NSInteger)section isSelected:(BOOL)isSelected
{
    CartSectionData *sellerData = [self sellerDataAtIndex:section];
    NSInteger countOfOutStock  = [sellerData.dataHandle countOfOutOfStockArr];
    if (countOfOutStock &&isSelected &&!sellerData.isEdit) { //全选、有库存不足时给提示
        [PRShowToastUtil showNotice:[NSString stringWithFormat:@"购物车中%zd种商品库存不足\n请根据库存提示修改",countOfOutStock]];
    }
    [sellerData.dataHandle emptyDeleteProducts];
    for(CartOrderCellViewModel *vm in sellerData.dataHandle.sortedSellerProducts) {
        if([vm isKindOfClass:[CartOrderCellViewModel class]]){
            BOOL isNormal = [self.adjustHandler modelIsNormal:vm section:section dataSource:self.dataSource];
            BOOL seletedState = isNormal?isSelected:NO;
            [sellerData.dataHandle upDateModel:vm
                             isEdit:sellerData.isEdit
                       seletedState:seletedState];
            [self.dataBaseHandler updateProductWithProductId:vm.product.cid
                                                         num:vm.product.num
                                                  isSelected:vm.isEdit?vm.product.isSelected:seletedState
                                                      shopId:vm.product.shopid
                                                   extraInfo:nil];
        }
    }
    if(self.reloadTableViewBlock){
        self.reloadTableViewBlock();
    }
#warning 暂时注释掉
//    if (!sellerData.isEdit) {
//        [self requestShopcartProductList];
//    }
}

//修改个数
- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count
{
    if (count == 0) {
        [self quantityOneMinusAtIndexPath:indexPath];
        return;
    }
    CartOrderCellViewModel *vM  = [self orderCellViewModelAtIndexPath:indexPath];
    CartSectionData *sellerData = [self sellerDataAtIndex:indexPath.section];
    if(vM.isEdit){
        vM.deletedState         = YES;
        [sellerData.dataHandle upDateModel:vM isEdit:YES seletedState:YES];
    }else{
        vM.deletedState         = NO;
    }
    vM.product.num = count;
    BOOL isSeleted              = vM.product.isOutOfStock?NO:YES;
    vM.product.isSelected       = isSeleted;
    [self.dataBaseHandler updateProductWithProductId:vM.product.cid
                                                 num:vM.product.num
                                          isSelected:isSeleted
                                              shopId:vM.product.shopid
                                           extraInfo:nil];
   
    
    [sellerData.dataHandle adjustFinalCellBottomLineView];
    if(self.reloadTableViewBlock){
        self.reloadTableViewBlock();
    }
#warning 暂时注释掉
//    if (vM.isEdit == NO) {
//        [self requestShopcartProductList];
//    }
}

//删除一个商品
- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath
{
    [self deleteCartItem:indexPath];
}

//点击编辑
- (void)editSellerAtSection:(NSInteger)section isEdit:(BOOL)isEdit
{
    CartSectionData *sellerData = [self sellerDataAtIndex:section];
    sellerData.isEdit = !sellerData.isEdit;
    [sellerData.dataHandle upDateAllProductEditState:sellerData.isEdit];
    if(self.reloadTableViewBlock){
        self.reloadTableViewBlock();
    }
//    if(!sellerData.isEdit){
//        [self requestShopcartProductList];
//    }
}
//结算
-(void)commitSellerProductAtSection:(NSInteger)section
{
    if (![self.adjustHandler isSeletedProductWithSection:section dataSource:self.dataSource]) return;
    if ([[UserManager shareMananger]isUserLogin]) {
        [self generateOrderWithSection:section];
    }else{
        [[SceneMananger shareMananger]showLoginViewWithCallback:nil];
    }
}

//删除商家下的所有选中商品
- (void)deleteSellerProductAtSection:(NSInteger)section
{
     CartSectionData *sellerData = [self sellerDataAtIndex:section];
    if ([sellerData.dataHandle countOfSeletedToDeletedArr] == 0) {
        [PRShowToastUtil showNotice:@"请选择至少一种商品"];
        return;
    }
    AlterView *view = [[AlterView alloc]initWithcancelBtnTitle:@"取消"
                                                commitBtnTitle:@"删除"
                                                       message:[NSString stringWithFormat:@"确认删除购物车中 %zd 种商品吗?",[sellerData.dataHandle countOfSeletedToDeletedArr]]
                                                      delegate:self];
    view.object   = sellerData;
    view.tag = AlterViewTypeDeletedAll;
    [view show];
}


#pragma mark private method
-(CartSectionData *)sellerDataAtIndex:(NSInteger)index
{
    if (self.dataSource) {
        return [self.dataSource sellerProductAtSection:index];
    }
    return nil;
}


-(CartOrderCellViewModel *)orderCellViewModelAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource) {
        CartSectionData *sellerData = [self.dataSource sellerProductAtSection:indexPath.section];
        if ([sellerData isKindOfClass:[CartSectionData  class]]) {
            return [sellerData.sortedSellerProducts safeObjectAtIndex:indexPath.row hintClass:[CartOrderCellViewModel class]];
        }
    }
    return nil;
}


//商品数量为1的，操作减号按钮
-(void)quantityOneMinusAtIndexPath:(NSIndexPath *)indexPath
{
    CartOrderCellViewModel *vM  = [self orderCellViewModelAtIndexPath:indexPath];
    NSString *title = [NSString stringWithFormat:@"\"%@\"\n确定删除吗?",vM.product.title];
    AlterView *alterView = [[AlterView alloc]initWithcancelBtnTitle:@"取消"
                                                     commitBtnTitle:@"删除"
                                                            message:title
                                                           delegate:self];
    alterView.object       = indexPath;
    alterView.tag          = AlterViewTypeDeletedOne;
    [alterView show];
}


//删除一个商品
- (void)deleteCartItem:(NSIndexPath *)indexPath
{
    CartOrderCellViewModel *vM  = [self orderCellViewModelAtIndexPath:indexPath];
    CartSectionData *sellerData = [self sellerDataAtIndex:indexPath.section];
    if ([vM isKindOfClass:[CartOrderCellViewModel class]]) {
        ProductOutline *model = vM.product;
        model.num = 0;
        [sellerData.dataHandle removeProduct:vM];
        if(vM.isEdit){ //删除状态下
            vM.deletedState  = NO;
            [sellerData.dataHandle upDateModel:vM isEdit:YES seletedState:NO];
        }
        [sellerData.dataHandle adjustFinalCellBottomLineView];
        if(self.reloadTableViewBlock){
            self.reloadTableViewBlock();
        }
//        [self requestShopcartProductList];
        
    }
}

- (void)generateOrderWithSection:(NSInteger)section
{
//    OrderGenerateParam *param = [self generateParamWithSection:section];
//    __weak typeof(self)weakSelf = self;
//    LOGINCALLBACK doGenerateOrderBlock = ^(BOOL suc) {
//        if (suc) {
//            BOOL reqSuc = [weakSelf.orderGenerateManager generateOrderWithParam:param];
//            if (reqSuc) {
//                [[PRShowToastUtil sharedInstance] addUnableTouchLoadingAnimationOnView:[[SceneMananger shareMananger] topViewController].view];
//            }
//        }
//    };
    if (NO == [[UserManager shareMananger] isUserLogin])
    {
//        [[SceneMananger shareMananger] showLoginViewWithCallback:doGenerateOrderBlock];
    }else{
//        doGenerateOrderBlock(YES);
    }
}


//- (OrderGenerateParam *)generateParamWithSection:(NSInteger)section
//{
//    OrderGenerateParam * generateInfo          = [ParameterHandler generateParamAtSection:section
//                                                                               dataSource:self.dataSource];
//    self.toCommitSellerid                      = generateInfo.sellerid;
//    self.toCommitStorid                        = generateInfo.storeID;
//    return generateInfo;
//}


#pragma mark - getter
- (ShopcartManager *)cartManager
{
    if (!_cartManager){
        _cartManager = [[ShopcartManager alloc]init];
        _cartManager.delegate = self;
    }
    return _cartManager;
}

//-(OrderManager *)orderGenerateManager{
//    if (!_orderGenerateManager) {
//        _orderGenerateManager          = [[OrderManager alloc] init];
//        _orderGenerateManager.delegate = self;
//    }
//    return _orderGenerateManager;
//}

-(CommitErrorHandler *)commitErrorHandler
{
    if (!_commitErrorHandler) {
        _commitErrorHandler = [[CommitErrorHandler alloc]init];
    }
    return _commitErrorHandler;
}

-(AdjustDataSouceHandler *)adjustHandler
{
    if (!_adjustHandler) {
        _adjustHandler = [[AdjustDataSouceHandler alloc]init];
    }
    return _adjustHandler;
}

-(LocalShopcartDataHandler *)dataBaseHandler
{
    return [LocalShopcartDataHandler sharedInstance];
}

#pragma mark alterview的代理
- (void) alterViewClickedCommitButton:(AlterView *)alterView;
{
    if (alterView.tag == AlterViewTypeDeletedAll) {
        CartSectionData *setionData  = alterView.object;
        if ([setionData.dataHandle deleteAllSeletedProducts]) {
            [setionData.dataHandle adjustFinalCellBottomLineView];
            if (self.reloadTableViewBlock) {
                self.reloadTableViewBlock();
            }
//            [self requestShopcartProductList];
        }
    }else if (alterView.tag == AlterViewTypeDeletedOne){
        [self deleteCartItem:alterView.object];
    }
}


#pragma mark CartShopAPIDelegate
-(void)loadDataSuccessful:(ShopcartManager *)cartShopApi dataType:(CartDataAPIType)dataType  data:(id)data  isCache:(BOOL)isCache
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:extraInfo:)]) {
        if (self.dataSource == nil) {
            self.dataSource = [[CartTableViewDataSource alloc]init];
        }
        self.dataSource.sellerList  = data;
//        if (self.restrictInfos) {
//            [self.adjustHandler adjustDataSource:self.dataSource.sellerList
//                                 restrictedGoods:self.restrictInfos];
//            self.restrictInfos= nil;
//        }
        [self.delegate loadDataSuccessful:self
                                 dataType:ShopcartFormatDataTypeFreshen
                                     data:self.dataSource
                                extraInfo:nil];
    }
}


-(void)loadDataFailed:(ShopcartManager*)cartShopApi dataType:(CartDataAPIType)dataType error:(NSError*)error
{
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
        [self.delegate loadDataFailed:self
                             dataType:ShopcartFormatDataTypeFreshen
                                error:error];
    }
}

#pragma mark - order manager delegate
//-(void)loadOMDataFailed:(OrderManager*)manager dataType:(OMDataType)dataType error:(NSError*)error data:(id)data
//{
//    [[YHLoadingAnimation sharedInstance] removeLoadingAnimation:[[SceneMananger shareMananger] topViewController].view];
//    if (error.code == 20019 || error.code == 20005) { //提交的商品有已下架和库存不足的情况
//        [self.commitErrorHandler outStockOrOffShelveWithData:data error:error];
//        return;
//    }else if (error.code == 20082 && data && [data isKindOfClass:[OrderDetail class]]){
//        self.restrictInfos = [self.commitErrorHandler restrictedGoodsWithData:data];
//        return;
//    }
//    [YHShowToastUtil showNotice:[ErrorHandler errorDescForError:error] inView:[[SceneMananger shareMananger] topViewController].view];
//    UIViewController *currentVC = [[SceneMananger shareMananger]currentViewController];
//    [ErrorHandler error:error viewController:currentVC requestNeedLogin:YES];
//    
//}
//
//// order place 回调
//- (void)loadOMDataSuccessful:(OrderManager*)manager dataType:(OMDataType)dataType data:(id)data
//{
//    NSDictionary *extraInfo = @{kToCommitStoridKey:self.toCommitStorid?:@"",
//                                kToCommitSelleridKey:self.toCommitSellerid?:@""};
//    if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:extraInfo:)]) {
//        [self.delegate loadDataSuccessful:self dataType:ShopcartFormatDataTypeCommit data:data extraInfo:extraInfo];
//    }
//}

@end
