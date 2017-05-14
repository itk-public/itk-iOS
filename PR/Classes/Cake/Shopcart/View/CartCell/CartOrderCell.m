//
//  HYCartOrderCell.m
//  YHClouds
//
//  Created by 黄小雪 on 15/10/20.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "CartOrderCell.h"
#import "NSString+Category.h"
#import "UIView+Category.h"
#import "AutoImageView.h"
//#import "QuantityView.h"
//#import "ShipAddrManager.h"
#import "CartModelDefine.h"
////#import "YHIFManager.h"
//#import "YHColorManager.h"

#define COLOR_LINE          UIColorFromRGB(0xf1f6f9)
#define COLOR_BOLD_LINE     kVCViewBGColor
#define KMargin             15

@interface CartOrderCell ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic  ) AutoImageView  *imgeView;
@property (strong, nonatomic  ) UILabel        *goodNameLab;
@property (strong, nonatomic  ) UIButton       *seleteBtn;
@property (strong, nonatomic  ) UILabel        *goodMarketPriceLab;
@property (nonatomic, strong  ) UILabel        *stockNumLabel;
@property (nonatomic, strong  ) UILabel        *offShelfLabel;
@property (nonatomic, strong  ) UIView         *bottomLine;
@property (strong,  nonatomic ) UILabel        *specLab;
//@property (nonatomic, strong )  QuantityView     *quantityView;

@end

@implementation CartOrderCell

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self.contentView setBackgroundColor:[UIColor whiteColor]];
//        [self addSeleteBtn];
//        [self addImgeView];
//        [self addGoodNameLab];
//        [self addSpecLab];
//        [self addGoodMarketPriceLab];
//        [self addQuantityView];
//        [self addStockNumLabel];
//        [self addOffShelfLabel];
//        [self addBottomLine];
//    }
//    return self;
//}
//
//
//-(void)layoutSubviews
//{
//    [super layoutSubviews];
////    self.seleteBtn.frame = CGRectMake(0, 0, 45, self.height);
////    CGFloat imageVieTopMargin = 15;
////    self.imgeView.frame  = CGRectMake(self.seleteBtn.right, imageVieTopMargin, 65, 65);
////    CGFloat goodNameLabH  = 21;
////    if ([[self class]titleLabShowTwoLineWithCartOrderCellViewModel:self.vM]) {
////        goodNameLabH      = 46;
////    }
////    self.goodNameLab.frame = CGRectMake(self.imgeView.right + 10, 9,self.width - self.imgeView.right - imageVieTopMargin , goodNameLabH);
////    
////    CGFloat specLabH               = [self.specLab sizeThatFits:CGSizeMake(self.width, MAXFLOAT)].height;
////    self.specLab.frame             = CGRectMake(self.goodNameLab.left, self.goodNameLab.bottom, self.goodNameLab.width, specLabH);
////
////    self.quantityView.frame        = CGRectMake(0, 0, 96, 27);
////    self.quantityView.right        = self.width - imageVieTopMargin;
////    self.quantityView.bottom       = self.height - 20;
////
////    self.goodMarketPriceLab.frame  = CGRectMake(self.goodNameLab.left, 0, self.quantityView.left - self.goodNameLab.left, 25);
////    self.goodMarketPriceLab.bottom = self.quantityView.bottom;
////
////    self.offShelfLabel.frame       = self.goodMarketPriceLab.frame;
////    self.stockNumLabel.frame       = CGRectMake(0, self.quantityView.bottom, self.quantityView.width, 21);
////    CGFloat stockNumLabelW         = [self.stockNumLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.stockNumLabel.height)].width;
////    self.stockNumLabel.width = stockNumLabelW;
////    if (self.stockNumLabel.width > self.quantityView.width) {
////        self.stockNumLabel.right = self.width - 15;
////    }else{
////        self.stockNumLabel.centerX = self.quantityView.centerX;
////    }
////    
////    self.bottomLine.bottom     = self.height;
//    
//}
//
//
//+(instancetype)cellWithTableView:(UITableView *)tableView;
//{
//    static NSString *ID  = @"CartOrdersCell";
//    CartOrderCell *cell  = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell                 = [[CartOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor colorWithRed:0.3 green:0.4 blue:0.5 alpha:0.3];
//    }
//    
//    return cell;
//}
//
//+(CGFloat)getHeightWithCartOrderCellViewModel:(CartOrderCellViewModel *)vM;
//{
//    CONDITION_CHECK_RETURN_VAULE([vM isKindOfClass:[CartOrderCellViewModel class]], 0);
//    if ([CartOrderCell titleLabShowTwoLineWithCartOrderCellViewModel:vM]) {
//        return HEGIHT_CARTORDERCELL + 25;
//    }
//    return HEGIHT_CARTORDERCELL;
//}
//
//+(BOOL)titleLabShowTwoLineWithCartOrderCellViewModel:(CartOrderCellViewModel *)vM
//{
//    CGFloat titleLabW = [vM.product.title sizeWithAttributes:@{NSFontAttributeName:KFontNormal(14)}].width;
//    if (titleLabW > ScreenWidth - 130 - 8 - 40) {
//        return YES;
//    }
//    return NO;
//}
//
//-(void)setVM:(CartOrderCellViewModel *)vM
//{
//    CONDITION_CHECK_RETURN([vM isKindOfClass:[CartOrderCellViewModel class]]);
//    _vM   = vM;
//    BOOL isEnable                = YES;
//    self.seleteBtn.enabled       = YES;
//    _bottomLine.hidden               = vM.bottomLineHide;
//    if (vM.product.isOutDelivered || vM.product.isOffTheShelf || vM.product.isOutOfStock) {
//        isEnable = NO;
//    }
//     [self updateSelectBtn:isEnable];
//    if (!vM.product.isOutDelivered && !vM.product.isOffTheShelf && !isEnable) { //库存不足的 商品不设置灰色
//        isEnable = YES;
//    }
//    [self updateGoodNameLab:isEnable];
//    [self updateImgeView:isEnable];
//    [self updateStockNumLabel];
//    [self updateGoodMarketPriceLab:isEnable];
//    [self updateQuantityView:isEnable];
//    [self updateUnitPrice:isEnable];
//    [self setNeedsLayout];
//}
//
//#pragma mark 按钮被点击
//- (void)btnOnClick:(UIButton *)sender {
//    if (self.shopcartCellBlock) {
//        if (!(self.vM.product.isOutOfStock && !self.vM.isEdit)) {
//            sender.selected = !sender.isSelected;
//        }
//        self.shopcartCellBlock(sender.isSelected);
//    }
//}
//
//
//#pragma mark private method
//#pragma mark add
//-(void)addImgeView
//{
//    _imgeView                      = [[AutoImageView alloc]init];
//    [self.contentView addSubview:_imgeView];
//}
//-(void)addSeleteBtn
//{
//    _seleteBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_seleteBtn setImage:[UIImage imageNamed:@"The-radio-is-selected"] forState:UIControlStateSelected];
//    [_seleteBtn setImage:[UIImage imageNamed:@"The-radio"] forState:UIControlStateNormal];
//    [_seleteBtn setImage:[UIImage imageNamed:@"Do-not-choose"] forState:UIControlStateDisabled];
//    [_seleteBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_seleteBtn];
//}
//-(void)addGoodNameLab
//{
////    _goodNameLab                   = [[UILabel alloc]init];
////    [_goodNameLab setTextAlignment:NSTextAlignmentLeft];
////    _goodNameLab.numberOfLines     = 2;
////    [_goodNameLab setFont:KFontNormal(14)];
////    [_goodNameLab setTextColor:YHColor(B1)];
////    _goodNameLab.lineBreakMode = NSLineBreakByClipping;
////    [self.contentView addSubview:_goodNameLab];
//}
//-(void)addSpecLab
//{
//    _specLab                       = [[UILabel alloc]init];
//    [_specLab setTextAlignment:NSTextAlignmentLeft];
//    [_specLab setFont:KFontNormal(12)];
//    [_specLab setTextColor:UIColorFromRGB(0xb9b9b9)];
//    [self.contentView addSubview:_specLab];
//}
//
//-(void)addGoodMarketPriceLab
//{
//    _goodMarketPriceLab            = [[UILabel alloc]init];
//    [_goodMarketPriceLab setTextAlignment:NSTextAlignmentLeft];
//    [_goodMarketPriceLab setFont:KFontNormal(12)];
//    [_goodMarketPriceLab setTextColor:UIColorFromRGB(0xb9b9b9)];
//    [self.contentView addSubview:_goodMarketPriceLab];
//}
//
//-(void)addQuantityView
//{
//    _quantityView                  = [[QuantityView alloc]initWithFrame:CGRectZero];
//    __weak typeof(self)weakSelf = self;
//    _quantityView.quantityViewEditBlock = ^(NSInteger count){
//        if (weakSelf.shopcartCellEditBlock) {
//            weakSelf.shopcartCellEditBlock(count);
//        }
//    };
//    _quantityView.quantityViewBeginEditBlock = ^(UITextField *textfiled){
//        if (weakSelf.shopcartCellBeginEditBlock) {
//            weakSelf.shopcartCellBeginEditBlock(textfiled);
//        }
//    };
//    [self.contentView addSubview:_quantityView];
//}
//
//-(void)addBottomLine
//{
//    _bottomLine                    = [[UIView alloc] initWithFrame:CGRectMake(KMargin, HEGIHT_CARTORDERCELL - OnePoint, APPLICATIONWIDTH, OnePoint)];
//    _bottomLine.backgroundColor    = COLOR_LINE;
//    [self.contentView addSubview:_bottomLine];
//}
//-(void)addOffShelfLabel
//{
//    _offShelfLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(145,0, 50, 22)];
//    _offShelfLabel.left            = self.goodNameLab.left;
//    _offShelfLabel.bottom          = self.goodMarketPriceLab.bottom ;
//    _offShelfLabel.textColor       = UIColorFromRGB(0xff4600);
//    _offShelfLabel.font            = KFontNormal(14);
//    _offShelfLabel.text            = @"已下架";
//    _offShelfLabel.textAlignment   = NSTextAlignmentLeft;
//    [self.contentView addSubview:_offShelfLabel];
//}
//
//-(void)addStockNumLabel
//{
//    _stockNumLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.quantityView.bottom + 2, 70, 15)];
//    _stockNumLabel.centerX         = ScreenWidth - self.quantityView.width/2.0 - 15;
//    _stockNumLabel.textColor       = UIColorFromRGB(0xff4600);
//    _stockNumLabel.font            = KFontNormal(10);
//    _stockNumLabel.backgroundColor = [UIColor clearColor];
//    _stockNumLabel.textAlignment   = NSTextAlignmentCenter;
//    [self.contentView addSubview:_stockNumLabel];
//}
//
//#pragma mark update
//
//-(void)updateGoodMarketPriceLab:(BOOL)isEnable
//{
//    UIColor *color                         = isEnable?UIColorFromRGB(0xff4600):[UIColor colorWithRed:255/255.0 green:70/255.0 blue:0 alpha:0.5];
//    NSMutableAttributedString * attrStr    = [[NSMutableAttributedString alloc] init];
//    [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"￥ " attributes:ATTR_DICTIONARY(color, KFontNormal(10))]];
//    NSString * tempPriceStr                = [self.vM.product.priceInfo.priceDes?:@"" stringByReplacingOccurrencesOfString:@"￥" withString:@""];
//    [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:tempPriceStr?:@"" attributes:ATTR_DICTIONARY(color, KFontNormal(16))]];
//    self.goodMarketPriceLab.attributedText = attrStr;
//}
//-(void)updateImgeView:(BOOL)isEnable
//{
//    self.imgeView.defaultImage       = [UIImage imageNamed:@"pic_default_200"];
//    if (self.vM.product.mainImage && self.vM.product.mainImage.imgUrl.length > 0) {
//        [self.imgeView setImgURLString:self.vM.product.mainImage.imgUrl];
//    }
//     self.imgeView.alpha                    = isEnable?1.0:0.5;
//}
//-(void)updateUnitPrice:(BOOL)isEnable
//{
//    self.specLab.text                = @"";
//    BOOL showUnitPrice = NO;
//    if (self.vM.product.unitPrice && [self.vM.product.unitPrice length]) {
//        showUnitPrice = YES;
//    }
//    if (showUnitPrice) { //显示散装价格
//        NSString *subTitle = [NSString stringWithFormat:@"￥%@",self.vM.product.unitPrice];
//        if (self.vM.product.smallSpce && [self.vM.product.smallSpce length]) {
//            subTitle =  [subTitle stringByAppendingString:[NSString stringWithFormat:@"/%@",self.vM.product.smallSpce]];
//        }
//        if ([self.vM.product.prefixdes length]) {
//            subTitle   = [subTitle stringByAppendingString:[NSString stringWithFormat:@" %@",self.vM.product.prefixdes?:@""]];
//        }
//        self.specLab.text     = subTitle?:@"";
//    }
//    self.specLab.highlighted               = !isEnable;
//}
//
//-(void)updateStockNumLabel
//{
//    if ([self.quantityView quantityViewCount] > (self.vM.product.stockInfo.num - 1) || self.vM.product.restricemsg) {
//        if (self.vM.product.isOffTheShelf) {
//            _stockNumLabel.hidden  = YES;
//        }else{
//            _stockNumLabel.hidden = NO;
//        }
//        if ([self.quantityView quantityViewCount]> (self.vM.product.stockInfo.num - 1)) {
//            _stockNumLabel.text   = [NSString stringWithFormat:@"仅剩 %ld 件", (long)(self.vM.product.stockInfo.num)];
//        }else {
//            _stockNumLabel.text  = self.vM.product.restricemsg?:@"";
//        }
//    }else{
//        _stockNumLabel.hidden = YES;
//    }
//    
//}
//-(void)updateGoodNameLab:(BOOL)isEnable
//{
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.vM.product.title?:@""];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    [paragraphStyle  setLineSpacing:5];
//    [attributedString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString.string length])];
//    self.goodNameLab.attributedText = attributedString;
//    self.goodNameLab.highlighted           = !isEnable;
//    UIColor *nameLabColor                  = isEnable?YHColor(B1):YHColor(B2);
//    self.goodNameLab.textColor             = nameLabColor;
//    if (self.vM.product.isOffTheShelf) {
//        self.goodMarketPriceLab.hidden = YES;
//        self.offShelfLabel.hidden       = NO;
//    }else{
//        self.goodMarketPriceLab.hidden = NO;
//        self.offShelfLabel.hidden       = YES;
//    }
//}
//
//-(void)updateQuantityView:(BOOL)isEnable
//{
//     self.quantityView.tempModel  = self.vM;
//     [self.quantityView updateQuantityViewCount:self.vM.product.num];
//    BOOL addBtnEnable = YES;
//    if (!(self.vM.product.num > 0 && self.vM.product.num < (self.vM.product.stockInfo.num))) { //库存不足
//        addBtnEnable            = NO;
//    }
//     [self.quantityView quantityViewEnable:isEnable addBtnEnable:addBtnEnable];
//}
//
//-(void)updateSelectBtn:(BOOL)isEnable
//{
//    if (self.vM.isEdit) { //编辑状态
//        self.seleteBtn.selected     = self.vM.deletedState;
//    }else{
//        self.seleteBtn.selected      = self.vM.product.isSelected;
//    }
//    self.seleteBtn.enabled                 = self.vM.isEdit?YES:isEnable;
//    if (!self.seleteBtn.enabled) {
//        self.seleteBtn.selected            = NO;
//    }
//}

@end
