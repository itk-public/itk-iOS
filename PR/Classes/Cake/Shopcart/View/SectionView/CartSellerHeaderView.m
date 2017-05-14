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

//商家级别不能购买的原因view

#define kSellerNotBuyViewH 34

#define kHeight   HEGIHT_CARTHEADERVIEW
@interface CartSellerHeaderView()

@property (strong,nonatomic) UIButton        *seletedBtn;
@property (strong,nonatomic) UILabel         *title;
@property (strong,nonatomic) UIButton        *editBtn;
@property (strong,nonatomic) ShopDescInfo    *model;
@property (assign,nonatomic) NSInteger       section;
@property (strong,nonatomic) UILabel         *promptLabel;
@property (strong,nonatomic) UILabel         *grayLabel;
@property (strong,nonatomic) UILabel         *sellerNotBuyLabel;

@end
@implementation CartSellerHeaderView


- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:UIColorFromRGB(0xFBFBFB)];
        [self addSeletedBtn];
        [self addTitle];
        [self addEditBtn];
        [self addPromptLabel];
        [self addGrayLabel];
        [self addSellerNotBuyLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCartSellerHeaderView)];
        [self addGestureRecognizer:tap];
    }
    return self;
};

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat marginX         = 15;
    self.grayLabel.frame    = CGRectMake(0, 0, self.width, 10);
    CGFloat sellerNotBuyLabelH = 34;
    if (self.sellerNotBuyLabel.hidden) {
        sellerNotBuyLabelH = 0;
    }
    self.sellerNotBuyLabel.frame = CGRectMake(marginX, self.grayLabel.bottom, self.width - 2*marginX,sellerNotBuyLabelH);
    
    CGFloat marginTopX      = 12;
    CGFloat seletedBtnW     = 25;
    CGFloat titleMarginX    = 15;
    self.seletedBtn.frame   = CGRectMake(0, self.sellerNotBuyLabel.bottom, seletedBtnW + titleMarginX,self.height - self.grayLabel.height);
    
    CGFloat editBtnW        = 40;
    self.editBtn.frame      = CGRectMake(self.width - editBtnW - marginX, self.sellerNotBuyLabel.bottom, editBtnW, 41);
    
    CGFloat titleLabX       = self.seletedBtn.right;
    CGFloat titleLabW       = self.width - titleLabX - editBtnW - 2*marginX ;
    CGFloat titleLabH       = [self.title sizeThatFits:CGSizeMake(titleLabW, MAXFLOAT)].height;
    self.title.frame        = CGRectMake(titleLabX,marginTopX + self.sellerNotBuyLabel.bottom,titleLabW, titleLabH);
    
    if (self.promptLabel.hidden == NO) {
        CGFloat promptLabelW = self.width - titleLabX - marginX;
        CGFloat promptLabelH = [self.promptLabel sizeThatFits:CGSizeMake(promptLabelW, MAXFLOAT)].height;
        self.promptLabel.frame = CGRectMake(titleLabX, self.height - marginTopX - promptLabelH, promptLabelW, promptLabelH);
    }
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
    self.title.text           = seller.title;
    self.editBtn.selected     = isEdit;
    
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
    if ([[self class] showSellerNotBuyLabel:dataHandle]) {
        self.sellerNotBuyLabel.text = [self sellerNotBuyLabelTitle:dataHandle]?:@"";
        self.sellerNotBuyLabel.hidden = NO;
    }else{
        self.sellerNotBuyLabel.hidden = YES;
    }
}


+(CGFloat)getHeight:(NSString *)freightPromotionMsg cartDataHandle:(CartDataHandle *)dataHandle;
{
    CGFloat cartSellerHeaderViewH  = 51;
    if (freightPromotionMsg && [freightPromotionMsg length]) {
        cartSellerHeaderViewH = cartSellerHeaderViewH + 20;
    }
    if ([[self class] showSellerNotBuyLabel:dataHandle]) {
         cartSellerHeaderViewH = cartSellerHeaderViewH + 34;
    }
    return cartSellerHeaderViewH;
}

+(BOOL)showSellerNotBuyLabel:(CartDataHandle *)dataHandle
{
    return YES;
    NSInteger countOfSellerProduct = [dataHandle countOfSellerProduct];
    NSInteger countOfOffShelfProduct = [dataHandle countOfOffTheShelfArr];
    NSInteger countOfOutOfStockProduct = [dataHandle countOfOutOfDelivered];
    NSInteger countOfOutOfDeliveredProduct = [dataHandle countOfOutOfDelivered];
    if (countOfSellerProduct == countOfOffShelfProduct ||
        countOfSellerProduct == countOfOutOfStockProduct ||
        countOfSellerProduct == countOfOutOfDeliveredProduct) {
        return YES;
    }
    return NO;
}

-(NSString *)sellerNotBuyLabelTitle:(CartDataHandle *)dataHandle
{
    return @"巴巴爸爸吧";
    NSInteger countOfSellerProduct = [dataHandle countOfSellerProduct];
    NSInteger countOfOffShelfProduct = [dataHandle countOfOffTheShelfArr];
    NSInteger countOfOutOfStockProduct = [dataHandle countOfOutOfDelivered];
    NSInteger countOfOutOfDeliveredProduct = [dataHandle countOfOutOfDelivered];
    if (countOfSellerProduct == countOfOutOfDeliveredProduct) {
        return @"以下商家超出配送范围";
    }else if (countOfSellerProduct == countOfOutOfStockProduct){
        return @"以下商家库存不足文案待定";
    }else if (countOfSellerProduct == countOfOffShelfProduct){
        return @"以下商家商品已下架文案待定";
    }
    return nil;
}
#pragma mark privte method
#pragma mark add
-(void)addSeletedBtn
{
    _seletedBtn                    = [UIButton buttonWithType:UIButtonTypeCustom];
    [_seletedBtn setBackgroundColor:[UIColor clearColor]];
    [_seletedBtn setImage:[UIImage imageNamed:@"The-radio"]
                 forState:UIControlStateNormal];
    [_seletedBtn setImage:[UIImage imageNamed:@"The-radio-is-selected"]
                 forState:UIControlStateSelected];
    [_seletedBtn setImage:[UIImage imageNamed:@"Do-not-choose"]
                 forState:UIControlStateDisabled];
    _seletedBtn.tag                = BtnTagSeleted;
    [_seletedBtn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_seletedBtn];
}

-(void)addTitle
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
}

-(void)addSellerNotBuyLabel
{
    _sellerNotBuyLabel = [[UILabel alloc]init];
    [_sellerNotBuyLabel setBackgroundColor:[UIColor brownColor]];
    [self addSubview:_sellerNotBuyLabel];
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
            self.shopcartEditSellerBlock(sender.isSelected, self.section);
        }
    }
}
@end
