//
//  ShopCartTableFooterView.m
//  PR
//
//  Created by 黄小雪 on 2017/5/28.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopCartTableFooterView.h"
#import "OnePixelSepView.h"

@interface ShopCartTableFooterView()

@property (strong,nonatomic) UIButton *selectBtn;
@property (strong,nonatomic) UILabel *promptLabel;
@property (strong,nonatomic) UILabel *priceLabel;
@property (strong,nonatomic) UIButton *commitBtn;

@end

@implementation ShopCartTableFooterView
-(instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _selectBtn         = [UIButton  buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_ unselected"]forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_ selected"] forState:UIControlStateSelected];
        [_selectBtn setImage: [UIImage imageNamed:@"icon_radio_disable"] forState:UIControlStateDisabled];
        [_selectBtn addTarget:self action:@selector(seletedBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectBtn];
        
        _promptLabel = [[UILabel alloc]init];
        [_promptLabel setText:@"全选"];
        [_promptLabel setFont:KFontNormal(14)];
        [_promptLabel setTextColor:UIColorFromRGB(0x959595)];
        [_promptLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_promptLabel];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_priceLabel];
        
        _commitBtn = [[UIButton alloc]init];
        [_commitBtn setBackgroundColor:kColorTheme];
        [_commitBtn addTarget:self action:@selector(commitBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commitBtn];
        [self setPixelSepSet:PSRectEdgeTop];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kSelectBtnW = 35;
    self.selectBtn.frame = CGRectMake(0, 0, kSelectBtnW, self.height);
    
    [self.promptLabel sizeToFit];
    self.promptLabel.frame = CGRectMake(self.selectBtn.right, 0, self.promptLabel.width, self.height);
    
    CGFloat kCommitBtnW = 100;
    self.commitBtn.frame = CGRectMake(self.width - kCommitBtnW, 0, kCommitBtnW, self.height);
    
    CGFloat kPriceLabelW = self.commitBtn.left - self.promptLabel.right - 10;
    self.priceLabel.frame = CGRectMake(0, 0, kPriceLabelW, self.height);
    self.priceLabel.right = self.commitBtn.left - 5;
}

-(void)updateWithCartTableViewDataSource:(CartTableViewDataSource *)dataSource
{
    CONDITION_CHECK_RETURN([dataSource isKindOfClass:[CartTableViewDataSource class]]);
    NSInteger productCount = 0;
    NSInteger selectedCount = 0;
    NSInteger normalCount   = 0;
    for (NSInteger i = 0; i <[dataSource.sellerList.sellerArray count]; i ++) {
        CartSectionData *sellerData = [dataSource sellerProductAtSection:i];
        if (sellerData) {
             productCount += [sellerData.dataHandle countOfSellerProduct];
            normalCount   += [sellerData.dataHandle countOfNormalArr];
            if (dataSource.editType == ShopcartEditTypeNone) {
                selectedCount += [[sellerData.dataHandle productSeleted] count];
            }else{
                selectedCount += [sellerData.dataHandle countOfSeletedToDeletedArr];
            }
        }
    }
    if (normalCount) {
        self.selectBtn.enabled = YES;
        if (productCount && productCount == selectedCount) {
            self.selectBtn.selected = YES;
        }else{
            self.selectBtn.selected = NO;
        }
    }else{
        self.selectBtn.selected  = NO;
        self.selectBtn.enabled = YES;
    }
    
    if (dataSource.editType == ShopcartEditTypeNone) {
        [self.commitBtn setTitle:@"结算" forState:UIControlStateNormal];
        [self.commitBtn setBackgroundColor:kColorTheme];
    }else{
        [self.commitBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.commitBtn setBackgroundColor:UIColorFromRGB(0xff7272)];
    }
    
}

+(CGFloat)height
{
    return 46;
}

-(void)seletedBtnOnClicked:(UIButton *)sender
{
    if (self.selectBtnBlock) {
        sender.selected = !sender.isSelected;
        self.selectBtnBlock(sender.isSelected);
    }
}

-(void)commitBtnOnClicked:(UIButton *)sender
{
    if (self.commitBtnBlock) {
        self.commitBtnBlock();
    }
}
@end
