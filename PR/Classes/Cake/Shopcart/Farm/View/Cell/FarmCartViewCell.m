//
//  FarmCartViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/8/8.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "FarmCartViewCell.h"
#import "AutoImageView.h"
#import "ProductOutline.h"
#import "CartOrderCellViewModel.h"

@protocol FarmCartNumControllerViewDelegate <NSObject>
-(void)farmCartNumControllerViewAddBtnOnClicked;
-(void)farmCartNumControllerViewMinusBtnOnClicked;
@end


@interface FarmCartNumControllerView : UIView
@property (strong,nonatomic) UIButton *addBtn;
@property (strong,nonatomic) UILabel *numLabel;
@property (strong,nonatomic) UIButton *minusBtn;
@property (weak,nonatomic)   id<FarmCartNumControllerViewDelegate> delegate;
@property (strong,nonatomic) ProductOutline *product;
@end

@implementation FarmCartNumControllerView
-(instancetype)init
{
    if (self = [super init]) {
        _addBtn = [[UIButton alloc]init];
        [_addBtn setBackgroundColor:[UIColor redColor]];
        [_addBtn addTarget:self action:@selector(addBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn setImage:[UIImage imageNamed:@"icon_cartplus"] forState:UIControlStateNormal];
        [self addSubview:_addBtn];
        
        _minusBtn = [[UIButton alloc]init];
        [_minusBtn setBackgroundColor:[UIColor orangeColor]];
        [_minusBtn addTarget:self action:@selector(minusBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_minusBtn setImage:[UIImage imageNamed:@"icon_cartminus"] forState:UIControlStateNormal];
        [self addSubview:_minusBtn];
        
        _numLabel = [[UILabel alloc]init];
        [_numLabel setFont:KFontNormal(12)];
        [_numLabel setTextColor:UIColorFromRGB(0x111111)];
        [_numLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_numLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kAddBtnW  = 30;
    self.addBtn.frame = CGRectMake(15, 0, kAddBtnW, self.height);
    
    CGFloat kNumLabelW = 30;
    self.numLabel.frame = CGRectMake(self.addBtn.right, 0, kNumLabelW, self.height);
    self.minusBtn.frame = CGRectMake(self.numLabel.right, 0, kAddBtnW, self.height);
}

-(void)setProduct:(ProductOutline *)product
{
    if ([product isKindOfClass:[ProductOutline class]]) {
        _product = product;
        self.numLabel.text = [NSString stringWithFormat:@"%zd",product.num];
    }
}

-(void)addBtnOnClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(farmCartNumControllerViewAddBtnOnClicked)]) {
        [self.delegate farmCartNumControllerViewAddBtnOnClicked];
    }
}

-(void)minusBtnOnClicked
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(farmCartNumControllerViewMinusBtnOnClicked)]){
        [self.delegate farmCartNumControllerViewMinusBtnOnClicked];
    }
}


@end


@interface FarmCartViewCell()<FarmCartNumControllerViewDelegate>

@property (strong,nonatomic) UIView *containerView;
@property (strong,nonatomic) UIButton *selectBtn;
@property (strong,nonatomic) AutoImageView *productImageView;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *subtitleLabel;
@property (strong,nonatomic) UILabel *priceLabel;
@property (strong,nonatomic) FarmCartNumControllerView *numController;

@end

@implementation FarmCartViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _containerView = [[UIView alloc]init];
        [_containerView setBackgroundColor:[UIColor whiteColor]];
        _containerView.layer.cornerRadius = 4.0;
        _containerView.layer.borderColor  = [UIColor whiteColor].CGColor;
        _containerView.layer.borderWidth  = OnePoint;
        [self.contentView addSubview:_containerView];
        
        _selectBtn = [[UIButton alloc]init];
        [_selectBtn addTarget:self action:@selector(selectBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_ unselected"]forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_ selected"] forState:UIControlStateSelected];
        [_selectBtn setImage: [UIImage imageNamed:@"icon_radio_disable"] forState:UIControlStateDisabled];
        [_containerView addSubview:_selectBtn];
        
        _productImageView = [[AutoImageView alloc]init];
        [_productImageView setBackgroundColor:[UIColor grayColor]];
        [_containerView addSubview:_productImageView];
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setFont:KFontNormal(14)];
        [_titleLabel setTextColor:UIColorFromRGB(0x111111)];
        [_containerView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]init];
        _subtitleLabel.numberOfLines = 2;
        [_subtitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_subtitleLabel setFont:KFontNormal(12)];
        [_subtitleLabel setTextColor:UIColorFromRGB(0x666666)];
        [_containerView addSubview:_subtitleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextAlignment:NSTextAlignmentLeft];
        [_priceLabel setFont:KFontNormal(12)];
        [_priceLabel setTextColor:UIColorFromRGB(0x666666)];
        [_containerView addSubview:_priceLabel];
        
        _numController = [[FarmCartNumControllerView alloc]init];
        _numController.delegate = self;
        [_containerView addSubview:_numController];
        [self.contentView setBackgroundColor:kVCViewBGColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kContainerViewTop = 10;
    self.containerView.frame = CGRectMake(kContainerViewTop, kContainerViewTop, self.width - 2*kContainerViewTop, self.height - kContainerViewTop);
    
    CGFloat kSelectBtnW      = 40;
    self.selectBtn.frame     = CGRectMake(0, (self.containerView.height - kSelectBtnW)/2.0, kSelectBtnW, kSelectBtnW);
    
    CGFloat kProductImageViewW = 60;
    self.productImageView.frame = CGRectMake(self.selectBtn.right, (self.containerView.height - kProductImageViewW)/2.0, kProductImageViewW, kProductImageViewW);
    
    CGFloat kTitleLabelRightMargin = 15;
    CGFloat kTitleLabelTopMargin   = 10;
    [self.titleLabel sizeToFit];
    self.titleLabel.frame          = CGRectMake(self.productImageView.right + 5,kTitleLabelTopMargin, self.containerView.width - self.productImageView.right - 5 - kTitleLabelRightMargin, self.titleLabel.height);
    
    [self.subtitleLabel sizeToFit];
    self.subtitleLabel.frame  = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + 10, self.titleLabel.width, self.subtitleLabel.height);
    
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(self.titleLabel.left, self.containerView.height - self.priceLabel.height - 10, self.priceLabel.width, self.priceLabel.height);
    
    CGFloat kNumControllerW  = 110;
    CGFloat kNumControllerH  = 40;
    self.numController.frame = CGRectMake(self.containerView.width - 10 - kNumControllerW,self.containerView.height - kNumControllerH - 10, kNumControllerW, kNumControllerH);
    self.numController.right = self.containerView.width;
}


-(void)setVM:(CartOrderCellViewModel *)vM
{
    [super setVM:vM];
    CONDITION_CHECK_RETURN([vM isKindOfClass:[CartOrderCellViewModel class]]);
    [self setObject:vM.product];
    
}
-(void)setObject:(id)object
{
    if ([object isKindOfClass:[ProductOutline class]]) {
        ProductOutline *product = object;
        [self.productImageView setImgInfo:product.imageInfo];
        self.titleLabel.text    = product.title?:@"";
        self.subtitleLabel.text = product.subtitle?:@"";
        self.priceLabel.text    = [NSString stringWithFormat:@"￥%@",product.priceInfo.marketPrice?:@""];
        [self.numController setProduct:product];
        self.selectBtn.selected = product.isSelected;
    }
}

+(CGFloat)getHeightWithCartOrderCellViewModel:(CartOrderCellViewModel *)vM;
{
    CONDITION_CHECK_RETURN_VAULE([vM isKindOfClass:[CartOrderCellViewModel class]], 0);
    return 89;
}

-(void)selectBtnOnClicked:(UIButton *)sender
{
    if (self.shopcartCellBlock) {
        if (!(self.vM.product.isOutOfStock && self.vM.editType != ShopcartEditTypeAll
              )) {
            sender.selected = !sender.isSelected;
        }
        self.shopcartCellBlock(sender.isSelected);
    }

}


#pragma mark FarmCartNumControllerViewDelegate
-(void)farmCartNumControllerViewAddBtnOnClicked
{
    if (self.shopcartCellEditBlock) {
        self.shopcartCellEditBlock(self.vM.product.num + 1);
    }
}
-(void)farmCartNumControllerViewMinusBtnOnClicked
{
    if (self.shopcartCellBlock) {
        self.shopcartCellEditBlock(self.vM.product.num - 1);
    }
}

@end
