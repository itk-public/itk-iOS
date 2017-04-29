//
//  HomeDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 12/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "HomeDataConstructor.h"
#import "DynamicMananger.h"
#import "DynamicUIModel.h"
#import "HPTopBannerCell.h"
#import "HomeAddressViewCell.h"
#import "HomeIconViewCell.h"
#import "NearbyShopViewCell.h"
#import "DiscountPromptViewCell.h"
#import "HomeThressProductCell.h"
#import "HomeCouponCell.h"
#import "HomeProductScrollviewCell.h"
#import "WTCellDataPipe.h"
#import "GapViewCell.h"

@interface HomeDataConstructor()<DynamicManangerDelegate>
@property (strong,nonatomic) DynamicMananger *dynamicManager;
@property (strong,nonatomic) DynamicUIModel  *responseData;
@end

@implementation HomeDataConstructor

-(void)loadData
{
    if (_dynamicManager == nil) {
        _dynamicManager = [[DynamicMananger alloc]init];
        _dynamicManager.delegate = self;
    }
    [self.dynamicManager requestDynamicUIModel:self.responseData == nil];
}


-(void)constructData
{
    if (self.responseData) {
        [self.items removeAllObjects];
        NSArray *tDataArr = [self.responseData dynamicCards];
        if ([tDataArr count]) {
            for (NSInteger i = 0 ; i < [tDataArr count]; i ++) {
                DynamicCardItem *tItem = tDataArr[i];
                if (tItem.data && [tItem.data isKindOfClass:[NSArray class]]) {
                    if ([tItem.data count] < 1) {
                        continue;
                    }
                }
                Class tClass = [self parseCellClassWithType:tItem.type];
                NSString *tCellType = [self parseCellTypeWityType:tItem.type];
                WTCellDataPipe * viewModel = [[WTCellDataPipe alloc] initWithDataModel:tItem cellClass:tClass cellType:tCellType];
                viewModel.contentModel.cellSelResponse = self.responder;
                [self.items addObject:viewModel.contentModel];
            }
        }
    }
}

#pragma mark - private methods
-(Class)parseCellClassWithType:(DynamicCardType)type
{
    if (type == DynamicCardType_HotBanner) {
        return [HPTopBannerCell class];
    }else if (type == DynamicCardType_HotIcon){
        return [HomeIconViewCell class];
    }else if (type == DynamicCardType_Channels){
        
    }else if (type == DYnamicCardType_SellerInfo){
        return [NearbyShopViewCell class];
    }else if (type == DYnamicCardType_SellerActivity){
        return [DiscountPromptViewCell class];
    }else if (type == DYnamicCardType_SellerProducts){
        return [HomeProductScrollviewCell class];
    }else if (type == DYnamicCardType_SellerCoupon){
        return [HomeCouponCell class];
    }else if (type == DYnamicCardType_ThressProducts){
        return [HomeThressProductCell class];
    }else if (type == DynamicCardType_CellGap){
        return [GapViewCell class];
    }
    return nil;
}
- (NSString *)parseCellTypeWityType:(DynamicCardType)type
{
    if (type == DynamicCardType_HotBanner) {
        return @"HPTopBannerCell";
    }else if (type == DynamicCardType_HotIcon){
        return @"HomeIconViewCell";
    }else if (type == DynamicCardType_Channels){
        
    }else if (type == DYnamicCardType_SellerInfo){
        return @"NearbyShopViewCell";
    }else if (type == DYnamicCardType_SellerActivity){
        return @"DiscountPromptViewCell";
    }else if (type == DYnamicCardType_SellerProducts){
        return @"HomeProductScrollviewCell";
    }else if (type == DYnamicCardType_SellerCoupon){
        return @"HomeCouponCell";
    }else if (type == DYnamicCardType_ThressProducts){
        return @"HomeProductCell";
    }else if (type == DynamicCardType_CellGap){
        return @"DynamicCardTypeCellGap";
    }
    return nil;
}

#pragma mark - DynamicManangerDelegate
- (void)requestDynamicUIModelSuccess:(DynamicUIModel *)modelData isCache:(BOOL)isCache
{
    self.responseData = modelData;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
        [self.delegate dataConstructor:self didFinishLoad:(NSObject *)self.responseData];
    }
}

- (void)requestDynamicUIModelFailed:(id)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}

@end
