//
//  ShopCartCell.m
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ShopCartCell.h"
#import "OnePixelSepView.h"
#import "AutoImageView.h"
//#import "GoodNumController.h"
#import "CartOrderCellViewModel.h"
#import "QuantityView.h"

@interface EditingView : UIView

@property (strong,nonatomic) QuantityView *numController;
@property (strong,nonatomic) UILabel *priceLabel;
@property (strong,nonatomic) UIButton *deleteBtn;
@property (strong,nonatomic) CartOrderCellViewModel *product;

@end

@implementation EditingView
-(instancetype)init
{
    if (self = [super init]) {
        _numController = [[QuantityView alloc]init];
        [self addSubview:_numController];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setText:@"xxxx"];
        [_priceLabel setTextColor:UIColorFromRGB(0xff9219)];
        [_priceLabel setFont:KFontNormal(12)];
        [_priceLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_priceLabel];
        
        _deleteBtn = [[UIButton alloc]init];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn.titleLabel setFont:KFontNormal(15)];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn setBackgroundColor:UIColorFromRGB(0xff7272)];
        [self addSubview:_deleteBtn];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat deleteBtnW       = 60*DDDisplayScale;
    self.deleteBtn.frame     = CGRectMake(self.width - deleteBtnW, 0, deleteBtnW, self.height);
    CGFloat leftMargin       = 0;
    
    CGFloat numControllerW   = self.deleteBtn.hidden?(self.width - 15):177*DDDisplayScale;
    self.numController.frame = CGRectMake(leftMargin, 10, numControllerW, kHeight);
    if (self.deleteBtn.hidden) {
        self.numController.right = self.width - 10;
    }else{
         self.numController.right = self.deleteBtn.left - 10;
    }
    self.priceLabel.frame    = CGRectMake(leftMargin, 0, numControllerW, 21);
    self.priceLabel.bottom   = self.height - 10;
}

-(void)setProduct:(CartOrderCellViewModel *)product
{
    _product = product;
    self.priceLabel.text = product.product.priceInfo.marketPrice?:@"";
    [self.numController setTempModel:product];
    [self.numController updateQuantityViewCount:product.product.num];
    self.deleteBtn.hidden = product.editType == ShopcartEditTypeAll?YES:NO;
}
@end

@interface DetailView:UIView

@property (strong,nonatomic) UILabel         *titleLabel;
@property (strong,nonatomic) UILabel         *subTitleLabel;
@property (strong,nonatomic) UILabel         *priceLabel;
@property (strong,nonatomic) UILabel         *numLabel;
@property (strong,nonatomic) CartOrderCellViewModel *product;

@end

@implementation DetailView
-(instancetype)init{
    if (self = [super init]) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:kColorNormal];
        [_titleLabel setFont:KFontNormal(14)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 2;
        [self addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc]init];
        [_subTitleLabel setTextColor:kColorGray];
        [_subTitleLabel setFont:KFontNormal(12)];
        [_subTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_subTitleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextColor:UIColorFromRGB(0xff8219)];
        [_priceLabel setFont:KFontNormal(12)];
        [_priceLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_priceLabel];
        
        _numLabel = [[UILabel alloc]init];
        [_numLabel setFont:KFontNormal(12)];
        [_numLabel setTextColor:kColorGray];
        [_numLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_numLabel];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize tempSize = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat titleLabelW = tempSize.width;
    CGFloat titleLabelH = tempSize.height;
    if (titleLabelW > self.width) {
        titleLabelH = 2*titleLabelH;
    }
    self.titleLabel.frame    = CGRectMake(0, 10, self.width, titleLabelH);
    self.subTitleLabel.frame = CGRectMake(0, self.titleLabel.bottom + 5, self.width, 18);
    self.numLabel.frame      = CGRectMake(0, 0, 40, 18);
    self.numLabel.right      = self.width;
    self.numLabel.bottom     = self.height - self.titleLabel.top;
    
    self.priceLabel.frame    = CGRectMake(0, 0, self.width - self.numLabel.width, 18);
    self.priceLabel.bottom   = self.height - self.titleLabel.top;
    
}

-(void)setProduct:(CartOrderCellViewModel *)product
{
    _product = product;
    
    self.priceLabel.text = product.product.priceInfo.marketPrice?:@"";
    self.titleLabel.text = product.product.title?:@"";
    self.subTitleLabel.text = product.product.subtitle?:@"";
    self.numLabel.text      = [NSString stringWithFormat:@"x%zd",product.product.num];
}
@end

@interface ShopCartCell()

@property (strong,nonatomic) UIButton      *seletedBtn;
@property (strong,nonatomic) AutoImageView *goodImageView;
@property (strong,nonatomic) DetailView    *detailView;
@property (strong,nonatomic) EditingView   *editingView;

@end
@implementation ShopCartCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ShopCartCell";
    ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ShopCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _seletedBtn         = [UIButton  buttonWithType:UIButtonTypeCustom];
        [_seletedBtn setImage:[UIImage imageNamed:@"icon_ unselected"]forState:UIControlStateNormal];
        [_seletedBtn setImage:[UIImage imageNamed:@"icon_ selected"] forState:UIControlStateSelected];
        [_seletedBtn setImage: [UIImage imageNamed:@"icon_radio_disable"] forState:UIControlStateDisabled];
        [_seletedBtn addTarget:self action:@selector(seletedBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_seletedBtn];

        _goodImageView      = [[AutoImageView alloc]init];
        [self.contentView addSubview:_goodImageView];

        _detailView         = [[DetailView alloc]init];
        _detailView.hidden  = YES;
        [self.contentView addSubview:_detailView];

        _editingView        = [[EditingView alloc]init];
        __weak typeof(self)weakSelf = self;
        _editingView.numController.quantityViewEditBlock = ^(NSInteger count){
            if (weakSelf.shopcartCellEditBlock) {
                weakSelf.shopcartCellEditBlock(count);
            }
        };
        _editingView.numController.quantityViewBeginEditBlock = ^(UITextField *textfiled){
            if (weakSelf.shopcartCellBeginEditBlock) {
                weakSelf.shopcartCellBeginEditBlock(textfiled);
            }
        };
        _editingView.hidden = NO;
        [self.contentView addSubview:_editingView];
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView setPixelSepSet:PSRectEdgeBottom];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat seletedBtnW      = 48 * DDDisplayScale;
    self.seletedBtn.frame    = CGRectMake(0, 0, seletedBtnW, self.height);
    CGFloat goodImageViewW   = 70 *DDDisplayScale;
    self.goodImageView.frame = CGRectMake(self.seletedBtn.right, (self.height - goodImageViewW)/2.0, goodImageViewW, goodImageViewW);
    self.detailView.frame    = CGRectMake(self.goodImageView.right + 10, 0, self.width - self.goodImageView.right - 15 -10, self.height);
    
    self.editingView.frame   = self.detailView.frame;
    self.editingView.frame   = CGRectMake(self.detailView.left, 0, self.detailView.width + 15, self.height);
}

-(void)setVM:(CartOrderCellViewModel *)vM
{
    [super setVM:vM];
    CONDITION_CHECK_RETURN([vM isKindOfClass:[CartOrderCellViewModel class]]);
    //_vM = vM;
    CartOrderCellViewModel *info = vM;
    if (vM.editType == ShopcartEditTypeAll) {
        self.seletedBtn.selected = vM.deletedState;
    }else{
         self.seletedBtn.selected  = vM.product.isSelected;
    }
    [self.detailView setProduct:info];
    [self.editingView setProduct:info];
    self.detailView.hidden  = vM.editType != ShopcartEditTypeNone;
    self.editingView.hidden = !self.detailView.hidden;
    [self.goodImageView setImgInfo:vM.product.imageInfo withPlaceholderImage:[UIImage imageNamed:@"icon_default"]];
}


+(CGFloat)getHeightWithCartOrderCellViewModel:(CartOrderCellViewModel *)vM;
{
    CONDITION_CHECK_RETURN_VAULE([vM isKindOfClass:[CartOrderCellViewModel class]], 0);
    return 79;
}



-(void)seletedBtnOnClicked:(UIButton *)sender
{
    if (self.shopcartCellBlock) {
        if (!(self.vM.product.isOutOfStock && self.vM.editType != ShopcartEditTypeAll
              )) {
            sender.selected = !sender.isSelected;
        }
        self.shopcartCellBlock(sender.isSelected);
    }
}
@end
