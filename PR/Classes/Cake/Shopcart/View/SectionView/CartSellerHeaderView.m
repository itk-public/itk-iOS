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
//@property (strong,nonatomic) UIImageView     *arrowIcon;
//@property (strong,nonatomic) UILabel         *sellerNotBuyLabel;

@end
@implementation CartSellerHeaderView


- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:UIColorFromRGB(0xFBFBFB)];
       /* [self addSeletedBtn];
        [self addTitle];
        [self addEditBtn];
        [self addPromptLabel];
        [self addGrayLabel]; */
        _seletedBtn                  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seletedBtn setImage:[UIImage imageNamed:@"icon_ unselected"]forState:UIControlStateNormal];
        [_seletedBtn setImage:[UIImage imageNamed:@"icon_ selected"] forState:UIControlStateSelected];
        [_seletedBtn setImage: [UIImage imageNamed:@"icon_radio_disable"] forState:UIControlStateDisabled];
        _seletedBtn.tag                = BtnTagSeleted;
        [_seletedBtn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_seletedBtn];
        
        _shopIconLabel              = [[UIImageView alloc]init];
        [_shopIconLabel setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:_shopIconLabel];
        
        _shopNameLabel              = [[UILabel alloc]init];
        [_shopNameLabel setText:@"xxxxx"];
        [_shopNameLabel setTextColor:kColorNormal];
        [_shopNameLabel setFont:KFontNormal(14)];
        [self addSubview:_shopNameLabel];
        
       /* _arrowIcon                 = [[UIImageView alloc]init];
        [_arrowIcon setBackgroundColor:[UIColor brownColor]];
        [self addSubview:_arrowIcon]; */
        
        _eidtBtn                    = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eidtBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_eidtBtn setTitleColor:UIColorFromRGB(0x959595) forState:UIControlStateNormal];
        [_eidtBtn setTitle:@"完成" forState:UIControlStateSelected];
        [_eidtBtn.titleLabel setFont:KFontNormal(12)];
        _eidtBtn.tag                   = BtnTagEdit;
        [_eidtBtn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_eidtBtn];
        
        _couponBtn                  = [UIButton buttonWithType:UIButtonTypeSystem];
        [_couponBtn setTitle:@"领券" forState:UIControlStateNormal];
        [_couponBtn setTitleColor:UIColorFromRGB(0x959595) forState:UIControlStateNormal];
        [_couponBtn.titleLabel setFont:KFontNormal(12)];
        [_couponBtn addTarget:self action:@selector(couponeBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_couponBtn];
        

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCartSellerHeaderView)];
        [self addGestureRecognizer:tap];
    }
    return self;
};

-(void)layoutSubviews
{
    [super layoutSubviews];
    /*CGFloat marginX         = 15;
    self.grayLabel.frame    = CGRectMake(0, 0, self.width, 10);
    
    CGFloat marginTopX      = 12;
    CGFloat seletedBtnW     = 25;
    CGFloat titleMarginX    = 15;
    self.seletedBtn.frame   = CGRectMake(0, 0, seletedBtnW + titleMarginX,self.height );
    
    CGFloat editBtnW        = 40;
    self.editBtn.frame      = CGRectMake(self.width - editBtnW - marginX, 0, editBtnW, self.height);
    
    CGFloat titleLabX       = self.seletedBtn.right;
    CGFloat titleLabW       = self.width - titleLabX - editBtnW - 2*marginX ;
    CGFloat titleLabH       = [self.title sizeThatFits:CGSizeMake(titleLabW, MAXFLOAT)].height;
    self.title.frame        = CGRectMake(titleLabX,(self.height - titleLabH)/2.0,titleLabW, titleLabH);
    
    if (self.promptLabel.hidden == NO) {
        CGFloat promptLabelW = self.width - titleLabX - marginX;
        CGFloat promptLabelH = [self.promptLabel sizeThatFits:CGSizeMake(promptLabelW, MAXFLOAT)].height;
        self.promptLabel.frame = CGRectMake(titleLabX, self.height - marginTopX - promptLabelH, promptLabelW, promptLabelH);
    } */
    CGFloat seleteBtnW       = 35;
    self.seletedBtn.frame     = CGRectMake(0, 0, seleteBtnW, self.height);
    
    CGFloat shopIconLabelW   = 15;
    self.shopIconLabel.frame = CGRectMake(self.seletedBtn.right, (self.height - shopIconLabelW)/2.0, shopIconLabelW, shopIconLabelW);
    
    CGFloat shopNameLabelW   = [self.shopNameLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.height)].width;
    self.shopNameLabel.frame = CGRectMake(self.shopIconLabel.right + 5, 0, shopNameLabelW, self.height);
    
   /* CGFloat arrowLabelW      = 6;
    CGFloat arrowLabelH      = 11;
    self.arrowIcon.frame    = CGRectMake(self.shopIconLabel.right + 5,(self.height - arrowLabelH)/2.0, arrowLabelW, arrowLabelH); */
    
    CGFloat editBtnW         = 40;
    self.eidtBtn.frame       = CGRectMake(self.width - editBtnW, 0, editBtnW, self.height);
    self.couponBtn.frame     = CGRectMake(self.eidtBtn.left - editBtnW, 0, editBtnW, self.height);
}


-(void)updateWithSellerInfoModel:(ShopDescInfo *)seller
                          isEdit:(BOOL)isEdit
                  CartDataHandle:(CartDataHandle *)dataHandle
                         section:(NSInteger)section
             freightPromotionMsg:(NSString *)freightPromotionMsg;
{
    self.section    = section;
    CONDITION_CHECK_RETURN([seller isKindOfClass:[ShopDescInfo class]]);
    _model                    = seller;
    self.shopNameLabel.text   = seller.title;
    self.eidtBtn.selected     = isEdit;
    
    BOOL isAllSeleted         = NO;
    if (!isEdit) {
        isAllSeleted = [dataHandle countOfNormalArr] == [[dataHandle productSeleted] count];
    }else{
        isAllSeleted = [dataHandle countOfSellerProduct] == [dataHandle countOfSeletedToDeletedArr] ;
    }
    self.seletedBtn.selected   = isAllSeleted;
    BOOL enabled = YES;
    if([dataHandle countOfNormalArr] == 0){
        enabled  = NO;
    }
    if (!isEdit && enabled == NO) {
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
    return 51;
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

/* -(void)addTitle
{
    _title                         = [[UILabel alloc]init];
    _title.textColor               = UIColorFromRGB(0x333333);
    _title.font                    = KFontNormal(14);
    _title.lineBreakMode           = NSLineBreakByClipping;
    [_title setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:_title];
}

-(void)addEditBtn
{
    _editBtn                       = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn setTitleColor:kColorSubTitleInfo_Desalination forState:UIControlStateNormal];
    [_editBtn setTitleColor:kColorReferenceTawnyColor forState:UIControlStateSelected];
    [_editBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setTitle:@"完成" forState:UIControlStateSelected];
    _editBtn.titleLabel.font       = KFontNormal(13);
    _editBtn.tag                   = BtnTagEdit;
    [_editBtn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_editBtn];
}

-(void)addPromptLabel
{
    _promptLabel = [[UILabel alloc]init];
    [_promptLabel setTextColor:UIColorFromRGB(0x666666)];
    [_promptLabel setFont:KFontNormal(12)];
    [_promptLabel setTextAlignment:NSTextAlignmentLeft];
    _promptLabel.hidden = YES;
    _promptLabel.lineBreakMode   = NSLineBreakByClipping;
    [self addSubview:_promptLabel];
}

-(void)addGrayLabel
{
    _grayLabel = [[UILabel alloc]init];
    [_grayLabel setBackgroundColor:UIColorFromRGB(0x666666)];
    [self addSubview:_grayLabel];
} */
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
            self.shopcartEditSellerBlock(sender.isSelected, self.section);
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
