//
//  CartShopInfoVieCell.m
//  PR
//
//  Created by 黄小雪 on 21/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartShopInfoViewCell.h"
#import "ShopDescInfo.h"
#import "AutoImageView.h"
#import "OnePixelSepView.h"
#import "NSObject+MSignal.h"
#import "ShopCartInfo.h"
#import "CartCouponViewControllerManager.h"

@interface CartShopInfoViewCell()

@property (strong,nonatomic) UIButton *seleteBtn;
@property (strong,nonatomic) AutoImageView *shopIcon;
@property (strong,nonatomic) UILabel *shopNameLabel;
@property (strong,nonatomic) UIImageView *arrowIcon;
@property (strong,nonatomic) UIButton *eidtBtn;
@property (strong,nonatomic) UIButton *couponBtn;
@property (strong,nonatomic)  CartCouponViewControllerManager *manager;


@end

@implementation CartShopInfoViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _seleteBtn                  = [[UIButton alloc]init];
        [_seleteBtn setImage:[UIImage imageNamed:@"icon_radio_normal"]forState:UIControlStateNormal];
        [_seleteBtn setImage:[UIImage imageNamed:@"icon_radio_selected"] forState:UIControlStateSelected];
        [_seleteBtn setImage: [UIImage imageNamed:@"icon_radio_disable"] forState:UIControlStateDisabled];
        [_seleteBtn addTarget:self action:@selector(seleteBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_seleteBtn];
        
        _shopIcon              = [[AutoImageView alloc]init];
        [self.contentView addSubview:_shopIcon];
        
        _shopNameLabel              = [[UILabel alloc]init];
        [_shopNameLabel setTextColor:kColorNormal];
        [_shopNameLabel setFont:KFontNormal(14)];
        [self.contentView addSubview:_shopNameLabel];
        
        _arrowIcon                 = [[UIImageView alloc]init];
        [_arrowIcon setImage:[UIImage imageNamed:@"icon_arrow_right"]];
        [self.contentView addSubview:_arrowIcon];
        
        _eidtBtn                    = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eidtBtn.titleLabel setFont:KFontNormal(14)];
        [_eidtBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_eidtBtn setTitleColor:kColorGray forState:UIControlStateNormal];
        [_eidtBtn setTitle:@"完成" forState:UIControlStateSelected];
        [_eidtBtn addTarget:self action:@selector(eidtBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_eidtBtn];
        
        _couponBtn                  = [UIButton buttonWithType:UIButtonTypeSystem];
        [_couponBtn setTitle:@"领券" forState:UIControlStateNormal];
        [_couponBtn setTitleColor:kColorGray forState:UIControlStateNormal];
        [_couponBtn addTarget:self action:@selector(couponeBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_couponBtn];
        
        [self.contentView setPixelSepSet:PSRectEdgeBottom];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShopName)];
        [self.shopNameLabel addGestureRecognizer:tap];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat seleteBtnW       = 35;
    self.seleteBtn.frame     = CGRectMake(15, 0, seleteBtnW, self.height);
    
    CGFloat shopIconLabelW   = 15;
    self.shopIcon.frame = CGRectMake(self.seleteBtn.right, (self.height - shopIconLabelW)/2.0, shopIconLabelW, shopIconLabelW);
    
    CGFloat shopNameLabelW   = [self.shopNameLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.height)].width;
    self.shopNameLabel.frame = CGRectMake(self.shopIcon.right + 5, 0, shopNameLabelW, self.height);
    
    CGFloat arrowLabelW      = 6;
    CGFloat arrowLabelH      = 11;
    self.arrowIcon.frame    = CGRectMake(self.shopNameLabel.right + 5,(self.height - arrowLabelH)/2.0, arrowLabelW, arrowLabelH);
    
    CGFloat editBtnW         = 40;
    self.eidtBtn.frame       = CGRectMake(self.width - editBtnW, 0, editBtnW, self.height);
    self.couponBtn.frame     = CGRectMake(self.eidtBtn.left - editBtnW, 0, editBtnW, self.height);
}


-(void)couponeBtnOnClicked:(UIButton *)sender
{
    if (self.manager == nil) {
        self.manager = [[CartCouponViewControllerManager alloc]init];
    }
    [self.manager getCartCouponsWithShopId:nil];
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[ShopDescInfo class]]);
    [super setObject:object];
    ShopDescInfo *info = object;
    self.shopNameLabel.text = info.title;
    [self.shopIcon setImgInfo:info.icon withPlaceholderImage:[UIImage imageNamed:@"icon_default"]];
}
-(void)eidtBtnOnClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
     [self triggerSignal:ShopCardEditSignal withObj:self.object];
}

-(void)seleteBtnOnClicked:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

-(void)tapShopName
{
    NSLog(@"tap店铺名称");
}

@end
