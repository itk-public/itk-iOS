//
//  GoodDetailDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "GoodDetailDataConstructor.h"
#import "GoodDetailManager.h"
#import "GoodDetailModel.h"
#import "SeparateCell.h"
#import "GoodsDetailPicturesInfoCell.h"
#import "GoodDetailMainImageCell.h"
#import "GoodDetailAdditionalInfoCell.h"
#import "GoodDetailTitleViewCell.h"
#import "GoodDetailShopViewCell.h"
#import "GoodDetailCouponViewCell.h"
#import "GoodDetailEvaluteViewCell.h"

@interface GoodDetailDataConstructor()<GoodDetailManagerDelegate>
@property (strong,nonatomic) GoodDetailManager *manager;
@property (strong,nonatomic) GoodDetailModel *goodDtailModel;

@end
@implementation GoodDetailDataConstructor

-(void)loadData
{
    [self.manager getGoodDetailWithId:nil];
}

-(void)constructData
{
    if (self.goodDtailModel) {
        [self.items removeAllObjects];
        
        //商品主图片
        GoodDetailMainImageModel *mainImageModel = [[GoodDetailMainImageModel alloc]init];
        mainImageModel.mainImages = self.goodDtailModel.mainImgs;
        mainImageModel.cellClass  = [GoodDetailMainImageCell class];
        mainImageModel.cellIdentifier = @"GoodDetailMainImageCell";
        [self.items addObject:mainImageModel];
        //商品标题信息
        ProductOutline *product = self.goodDtailModel.product;
        product.cellClass       = [GoodDetailTitleViewCell class];
        product.cellIdentifier  = @"GoodDetailTitleViewCell";
        [self.items addObject:product];
        //产地、销量信息
        GoodDetailAdditionalInfo *additionalInfo = [[GoodDetailAdditionalInfo alloc]init];
        additionalInfo.additionalInfo            = self.goodDtailModel.additionalInfo;
        additionalInfo.cellClass = [GoodDetailAdditionalInfoCell class];
        additionalInfo.cellIdentifier = @"GoodDetailAdditionalInfoCell";
        [self.items addObject:additionalInfo];
        //分割cell
        SeparateModel *separateModel1 = [[SeparateModel alloc]init];
        separateModel1.cellClass      = [SeparateCell class];
        separateModel1.cellIdentifier = @"SeparateCell";
        [self.items addObject:separateModel1];
        //店铺信息
        ShopDescInfo *shopInfo        = self.goodDtailModel.shopInfo;
        shopInfo.cellClass            = [GoodDetailShopViewCell class];
        shopInfo.cellIdentifier       = @"GoodDetailShopViewCell";
        [self.items addObject:shopInfo];
        //优惠券信息
        GoodDetailCouponModel *coupon = [[GoodDetailCouponModel alloc]init];
        coupon.couponDict             = self.goodDtailModel.coupon;
        coupon.cellClass              = [GoodDetailCouponViewCell class];
        coupon.cellIdentifier         = @"GoodDetailCouponViewCell";
        [self.items addObject:coupon];
        //分割cell
        SeparateModel *separateModel2 = [[SeparateModel alloc]init];
        separateModel2.cellClass      = [SeparateCell class];
        separateModel2.cellIdentifier = @"SeparateCell";
        [self.items addObject:separateModel2];
        //评价
        self.goodDtailModel.cellClass = [GoodDetailEvaluteViewCell class];
        self.goodDtailModel.cellIdentifier =  @"GoodDetailEvaluteViewCell";
        [self.items addObject:self.goodDtailModel];
        //分割cell
        SeparateModel *separateModel3 = [[SeparateModel alloc]init];
        separateModel3.cellClass      = [SeparateCell class];
        separateModel3.cellIdentifier = @"SeparateCell";
        [self.items addObject:separateModel3];
        //图文详情
        GoodsDetailPicturesInfoModel *picInfo = [[GoodsDetailPicturesInfoModel alloc]init];
        picInfo.pictureDetailUrlArr            = self.goodDtailModel.pictureDetail;
        picInfo.pictureDetailImgDic            = self.dcPictureDetailImageDict;
        picInfo.cellClass                       = [GoodsDetailPicturesInfoCell class];
        picInfo.cellIdentifier                   = @"GoodsDetailPicturesInfoCell";
        [self.items addObject:picInfo];
        
        
    }
}
-(GoodDetailManager *)manager
{
    if (_manager == nil) {
        _manager = [[GoodDetailManager alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}
#pragma mark CategoryManangerDelegate
-(void)loadDataSuccessful:(GoodDetailManager *)mananger  data:(id)data;
{
    self.goodDtailModel = data;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
        [self.delegate dataConstructor:self didFinishLoad:data];
    }
}

-(void)loadDataFailed:(GoodDetailManager *)manager  error:(NSError*)error;
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}

@end
