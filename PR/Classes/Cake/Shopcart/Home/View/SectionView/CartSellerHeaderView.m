//
//  CartSellerHeaderView.m
//  YHClouds
//
//  Created by 黄小雪 on 16/7/26.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartSellerHeaderView.h"
#import "AutoImageView.h"
#import "NSString+Category.h"
#import "ActionHandler.h"
#import "CSXCartCellDefine.h"
#import "CartCouponViewControllerManager.h"
#import "OnePixelSepView.h"

//商家级别不能购买的原因view

#define kSellerNotBuyViewH 34

#define kHeight   HEGIHT_CARTHEADERVIEW
@interface CartSellerHeaderView()

@property (strong,nonatomic) UIButton        *seletedBtn;
@property (strong,nonatomic) UILabel         *shopNameLabel;
@property (strong,nonatomic) UIButton        *eidtBtn;
@property (strong,nonatomic) ShopDescInfo    *model;
@property (assign,nonatomic) NSInteger       section;
@property (strong,nonatomic) UILabel         *promptLabel;
@property (strong,nonatomic) UILabel         *grayLabel;
@property (strong,nonatomic) UIButton        *couponBtn;
@property (strong,nonatomic) UIImageView     *shopIconLabel;
@property (strong,nonatomic) CartCouponViewControllerManager *manager;
@property (strong,nonatomic) UIView         *grayView;

@end
@implementation CartSellerHeaderView


- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        _seletedBtn                  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seletedBtn setImage:[UIImage imageNamed:@"icon_ unselected"]forState:UIControlStateNormal];
        [_seletedBtn setImage:[UIImage imageNamed:@"icon_ selected"] forState:UIControlStateSelected];
        [_seletedBtn setImage: [UIImage imageNamed:@"icon_radio_disable"] forState:UIControlStateDisabled];
        _seletedBtn.tag                = BtnTagSeleted;
        [_seletedBtn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_seletedBtn];
        
        _shopIconLabel              = [[UIImageView alloc]init];
        [_shopIconLabel setBackgroundColor:[UIColor orangeColor]];
        [self.contentView addSubview:_shopIconLabel];
        
        _shopNameLabel              = [[UILabel alloc]init];
        [_shopNameLabel setText:@"xxxxx"];
        [_shopNameLabel setTextColor:kColorNormal];
        [_shopNameLabel setFont:KFontNormal(14)];
        [self.contentView addSubview:_shopNameLabel];
        
        _eidtBtn                    = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eidtBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_eidtBtn setTitleColor:UIColorFromRGB(0x959595) forState:UIControlStateNormal];
        [_eidtBtn setTitle:@"完成" forState:UIControlStateSelected];
        [_eidtBtn.titleLabel setFont:KFontNormal(12)];
        _eidtBtn.tag                   = BtnTagEdit;
        [_eidtBtn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_eidtBtn];
        
        _couponBtn                  = [UIButton buttonWithType:UIButtonTypeSystem];
        [_couponBtn setTitle:@"领券" forState:UIControlStateNormal];
        [_couponBtn setTitleColor:UIColorFromRGB(0x959595) forState:UIControlStateNormal];
        [_couponBtn.titleLabel setFont:KFontNormal(12)];
        [_couponBtn addTarget:self action:@selector(couponeBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_couponBtn];
        
        _grayView = [[UIView alloc]init];
        [_grayView setBackgroundColor:kVCViewBGColor];
        [self.contentView addSubview:_grayView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCartSellerHeaderView)];
        [self.contentView addGestureRecognizer:tap];
        
        [self.contentView setPixelSepSet:PSRectEdgeBottom];
    }
    return self;
};

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kTopMargin      = 10;
    self.grayView.frame     = CGRectMake(0, 0, self.width, kTopMargin);
    CGFloat kContainViewH   = self.height - kTopMargin;
    CGFloat seleteBtnW       = 45;
    self.seletedBtn.frame     = CGRectMake(0, kTopMargin, seleteBtnW, kContainViewH);
    
    CGFloat shopIconLabelW   = 15;
    self.shopIconLabel.frame = CGRectMake(self.seletedBtn.right, (kContainViewH - shopIconLabelW)/2.0 + kTopMargin, shopIconLabelW, shopIconLabelW);
    
    CGFloat shopNameLabelW   = [self.shopNameLabel sizeThatFits:CGSizeMake(MAXFLOAT, kContainViewH)].width;
    self.shopNameLabel.frame = CGRectMake(self.shopIconLabel.right + 5, kTopMargin, shopNameLabelW, kContainViewH);
    
    CGFloat editBtnW         = 40;
    self.eidtBtn.frame       = CGRectMake(self.width - editBtnW, kTopMargin, editBtnW, kContainViewH);
    self.couponBtn.frame     = CGRectMake(self.eidtBtn.left - editBtnW, kTopMargin, editBtnW, kContainViewH);
}


-(void)updateWithSellerInfoModel:(ShopDescInfo *)seller
                        editType:(ShopcartEditType)editType
                  CartDataHandle:(CartDataHandle *)dataHandle
                         section:(NSInteger)section
             freightPromotionMsg:(NSString *)freightPromotionMsg;
{
    self.section    = section;
    CONDITION_CHECK_RETURN([seller isKindOfClass:[ShopDescInfo class]]);
    _model                    = seller;
    self.shopNameLabel.text   = seller.title;
    if (editType == ShopcartEditTypeAll) {
        self.eidtBtn.hidden = YES;
        self.couponBtn.hidden = YES;
    }else{
        self.eidtBtn.selected     = editType == ShopcartEditTypeSeller;
        self.eidtBtn.hidden       = NO;
        self.couponBtn.hidden     = NO;
    }
    BOOL isAllSeleted         = NO;
    if (editType != ShopcartEditTypeAll) {
        isAllSeleted = [dataHandle countOfNormalArr] == [[dataHandle productSeleted] count];
    }else{
        isAllSeleted = [dataHandle countOfSellerProduct] == [dataHandle countOfSeletedToDeletedArr] ;
    }
    self.seletedBtn.selected   = isAllSeleted;
    BOOL enabled = YES;
    if([dataHandle countOfNormalArr] == 0){
        enabled  = NO;
    }
    if (editType != ShopcartEditTypeAll && enabled == NO) {
        self.seletedBtn.selected = NO;
        self.seletedBtn.enabled = NO;
    }else{
        self.seletedBtn.enabled = YES;
    }
    if (freightPromotionMsg && [freightPromotionMsg length]) {
        self.promptLabel.text = freightPromotionMsg;
        self.promptLabel.hidden = NO;
    }else{
        self.promptLabel.hidden = YES;
    }
}


+(CGFloat)getHeight:(NSString *)freightPromotionMsg cartDataHandle:(CartDataHandle *)dataHandle;
{
    return 54;
}


#pragma mark privte method
#pragma mark add
-(void)addSeletedBtn
{
    _seletedBtn                    = [UIButton buttonWithType:UIButtonTypeCustom];
    [_seletedBtn setImage:[UIImage imageNamed:@"icon_ unselected"]forState:UIControlStateNormal];
    [_seletedBtn setImage:[UIImage imageNamed:@"icon_ selected"] forState:UIControlStateSelected];
    [_seletedBtn setImage: [UIImage imageNamed:@"icon_radio_disable"] forState:UIControlStateDisabled];
    [_seletedBtn setBackgroundColor:[UIColor clearColor]];
    _seletedBtn.tag                = BtnTagSeleted;
    [_seletedBtn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_seletedBtn];
}
#pragma mark 交互
-(void)tapCartSellerHeaderView
{
    if (!self.model.action) {
        ActionHandler *actionHandler = [ActionHandler handlerWithAction:self.model.action];
        [actionHandler run];
    }
}

-(void)btnOnClicked:(UIButton *)sender
{
    if (sender.tag == BtnTagSeleted) {
        if (self.shopcartSelectSellerAllProductBlock) {
            self.shopcartSelectSellerAllProductBlock(!sender.isSelected, self.section);
        }
    }else if (sender.tag == BtnTagEdit){
        sender.selected = !sender.isSelected;
        if (self.shopcartEditSellerBlock) {
            ShopcartEditType editType = ShopcartEditTypeNone;
            if (sender.isSelected) {
                editType = ShopcartEditTypeSeller;
            }
            self.shopcartEditSellerBlock(editType, self.section);
        }
    }
}

-(void)couponeBtnOnClicked:(UIButton *)sender
{
    if (self.manager == nil) {
        self.manager = [[CartCouponViewControllerManager alloc]init];
    }
    [self.manager getCartCouponsWithShopId:nil];
}

-(void)eidtBtnOnClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
}


-(void)seleteBtnOnClicked
{
    
}

-(void)tapShopName
{
    NSLog(@"tap店铺名称");
}
@end
