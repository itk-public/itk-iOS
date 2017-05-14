//
//  CartSellerFooterView.m
//  YHClouds
//
//  Created by 黄小雪 on 16/7/27.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartSellerFooterView.h"
#import "CartModelDefine.h"
#import "CartMananger.h"
#import "ServiceCenter.h"
#import "OnePixelSepView.h"

#define kHeight  HEGIHT_CARTFOOTERVIEW

@interface CartSellerFooterView ()
@property (strong,nonatomic) UILabel                       *priceLab;//总计
@property (strong,nonatomic) UILabel                       *freightLab;//运费
@property (strong,nonatomic) UIButton                      *submitBtn;//结算
@property (strong,nonatomic) CartDataHandle                *dataHandle;
@property (assign,nonatomic) BOOL                          isEdit;
@property (strong,nonatomic) ShopCartSellerProductModel   *cartAllInfo;
@property (assign,nonatomic) NSInteger                      section;

@end
@implementation CartSellerFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        _priceLab                  = [[UILabel alloc]init];
        [_priceLab setBackgroundColor:[UIColor clearColor]];
        [_priceLab setFont:KFontNormal(14)];
        [_priceLab setTextColor:kColorRed];
        [_priceLab setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_priceLab];
        
        _freightLab                = [[UILabel alloc]init];
        [_freightLab setBackgroundColor:[UIColor clearColor]];
        [_freightLab setFont:KFontNormal(10)];
        [_freightLab setTextColor:kColorGray];
        [_freightLab setText:@"  (不含运费)"];
        [_freightLab setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_freightLab];
        
        _submitBtn                 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundColor:kColorReferenceTawnyColor];
        [_submitBtn setTitle:@"去结算" forState:UIControlStateNormal];
        _submitBtn.tag             = BtnTypeCommit;
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = KFontNormal(14);
        [_submitBtn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_submitBtn];
        [self setPixelSepSet:PSRectEdgeTop];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat submitBtnW   = 110;
    self.submitBtn.frame = CGRectMake(0, 0, submitBtnW, kHeight);
    self.submitBtn.right = ScreenWidth;

    CGFloat margin       = 15;
    CGFloat priceLabW    = ScreenWidth - margin - submitBtnW;
    self.priceLab.frame  = CGRectMake(margin, 0,priceLabW , kHeight);
    
}


-(void)btnOnClicked:(UIButton *)sender
{
    if (sender.tag == BtnTypeCommit) {
        if (self.shopcartCommitSellerProductBlock) {
            self.shopcartCommitSellerProductBlock(self.section);
        }
    }else if(self.shopcartDeleteSellerProductBlock){
        self.shopcartDeleteSellerProductBlock(self.section);
    }
}


-(void)updateWithCartDataHandle:(CartDataHandle *)dataHandle
                    cartAllInfo:(ShopCartSellerProductModel *)cartAllInfo
                         isEdit:(BOOL)isEidt
                       isEnable:(BOOL)isEnable
                        section:(NSInteger)section
{
    _section           = section;
    _submitBtn.enabled = isEnable;
    _isEdit            = isEidt;
    _dataHandle        = dataHandle;
    NSString *title    = nil;
    UIColor *bgColor   = nil;
    if (isEidt) {
        title = @"删除";
        if ([dataHandle countOfSeletedToDeletedArr] == 0) {
            bgColor = UIColorFromRGB(0xaaaaaa);
        }else{
            bgColor = UIColorFromRGB(0xff4600);
        }
    }else{
        title = @"去结算";
        if ([dataHandle countOfNormalArr] == 0) {
            bgColor = UIColorFromRGB(0xaaaaaa);
        }else{
            bgColor = kColorReferenceTawnyColor;
        }
    }
    if (isEnable == NO) {
         bgColor = UIColorFromRGB(0xaaaaaa);
    }
    [self.submitBtn setTitle:title forState:UIControlStateNormal];
    [self.submitBtn setBackgroundColor:bgColor];
    self.priceLab.hidden         = isEidt;
    self.priceLab.attributedText = cartAllInfo.infoModel.allprice;
    self.submitBtn.tag           = isEidt?BtnTypeDeleted:BtnTypeCommit;
    if (self.isEdit) {
         self.freightLab.hidden  = isEidt;
    }else{
//        self.freightLab.hidden   =  [ShipAddrManager sharedInstance].deliveryInfo.pickselfStyle;
    }
}


+(CGFloat)getHeightWithCartDataHandle:(CartDataHandle *)dataHandle isEdit:(BOOL)isEidt
{
    return kHeight;
}


#pragma mark - init
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
