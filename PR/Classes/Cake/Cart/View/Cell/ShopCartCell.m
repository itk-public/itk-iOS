//
//  ShopCartCell.m
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ShopCartCell.h"
#import "CartProductInfo.h"
#import "OnePixelSepView.h"
#import "AutoImageView.h"
#import "GoodNumController.h"
#import "CartOrderCellViewModel.h"

@interface EditingView : UIView

@property (strong,nonatomic) GoodNumController *numController;
@property (strong,nonatomic) UILabel *priceLabel;
@property (strong,nonatomic) UIButton *deleteBtn;
@property (strong,nonatomic) CartOrderCellViewModel *product;

@end

@implementation EditingView
-(instancetype)init
{
    if (self = [super init]) {
        _numController = [[GoodNumController alloc]init];
        [self addSubview:_numController];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setText:@"xxxx"];
        [_priceLabel setTextColor:kColorRed];
        [_priceLabel setFont:KFontNormal(12)];
        [_priceLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_priceLabel];
        
        _deleteBtn = [[UIButton alloc]init];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn.titleLabel setFont:KFontNormal(14)];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn setBackgroundColor:[UIColor redColor]];
        [self addSubview:_deleteBtn];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat deleteBtnW       = 50;
    self.deleteBtn.frame     = CGRectMake(self.width - deleteBtnW, 0, deleteBtnW, self.height);
    CGFloat leftMargin       = 15;
    CGFloat numControllerW   = kWidth;
    self.numController.frame = CGRectMake(leftMargin, 10, numControllerW, kHeight);
    self.priceLabel.frame    = CGRectMake(leftMargin, 0, numControllerW, 21);
    self.priceLabel.bottom   = self.height - 10;
}

-(void)setProduct:(CartOrderCellViewModel *)product
{
    _product = product;
    self.priceLabel.text = product.product.priceInfo.marketPrice?:@"";
    [self.numController setProduct:(ProductOutline *)product];
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
        [_subTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_subTitleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextColor:kColorRed];
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
        [_seletedBtn setImage:[UIImage imageNamed:@"icon_radio_normal"]forState:UIControlStateNormal];
         [_seletedBtn setImage:[UIImage imageNamed:@"icon_radio_selected"] forState:UIControlStateSelected];
         [_seletedBtn setImage: [UIImage imageNamed:@"icon_radio_disable"] forState:UIControlStateDisabled];
        [_seletedBtn addTarget:self action:@selector(seletedBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_seletedBtn];

        _goodImageView      = [[AutoImageView alloc]init];
        [self.contentView addSubview:_goodImageView];

        _detailView         = [[DetailView alloc]init];
        _detailView.hidden  = YES;
        [self.contentView addSubview:_detailView];

        _editingView        = [[EditingView alloc]init];
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
    
    CGFloat seletedBtnW      = 25;
    self.seletedBtn.frame    = CGRectMake(15, 0, seletedBtnW, self.height);
    CGFloat goodImageViewW   = 65;
    self.goodImageView.frame = CGRectMake(self.seletedBtn.right + 10, (self.height - goodImageViewW)/2.0, goodImageViewW, goodImageViewW);
    self.detailView.frame    = CGRectMake(self.goodImageView.right + 10, 0, self.width - self.goodImageView.right - 15 -10, self.height);
    
    self.editingView.frame   = self.detailView.frame;
    self.editingView.frame   = CGRectMake(self.detailView.left, 0, self.detailView.width + 15, self.height);
}

-(void)setVM:(CartOrderCellViewModel *)vM
{
    CONDITION_CHECK_RETURN([vM isKindOfClass:[CartOrderCellViewModel class]]);
    CartOrderCellViewModel *info = vM;
    [self.detailView setProduct:info];
    [self.editingView setProduct:info];
    self.detailView.hidden  = info.isEdit;
    self.editingView.hidden = !info.isEdit;
    [self.goodImageView setImgInfo:vM.product.imageInfo withPlaceholderImage:[UIImage imageNamed:@"icon_default"]];
}


+(CGFloat)getHeightWithCartOrderCellViewModel:(CartOrderCellViewModel *)vM;
{
    CONDITION_CHECK_RETURN_VAULE([vM isKindOfClass:[CartProductInfo class]], 0);
    return 95;
}


-(void)seletedBtnOnClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
@end
