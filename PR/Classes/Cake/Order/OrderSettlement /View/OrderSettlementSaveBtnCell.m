//
//  OrderSettlementSaveBtnCell.m
//  PR
//
//  Created by 黄小雪 on 2017/9/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderSettlementSaveBtnCell.h"

@implementation OrderSettlementSaveBtnCellModel

@end


@interface OrderSettlementSaveBtnCell()
@property (strong,nonatomic) UIButton *saveBtn;
@end

@implementation OrderSettlementSaveBtnCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _saveBtn = [[UIButton alloc]init];
        [_saveBtn setBackgroundColor:kColorTheme];
        [_saveBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveBtn.layer.borderColor = kColorTheme.CGColor;
        _saveBtn.layer.borderWidth = OnePoint;
        _saveBtn.layer.cornerRadius = 8.0;
        [_saveBtn addTarget:self action:@selector(saveBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_saveBtn];
        
        [self.contentView setBackgroundColor:kVCViewBGColor];

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kSaveBtnH          = 49;
    CGFloat kSaveBtnTopMargin  = 15;
    CGFloat kSaveBtnLeftMargin = 10;
    self.saveBtn.frame = CGRectMake(kSaveBtnLeftMargin, kSaveBtnTopMargin, self.width - 2*kSaveBtnLeftMargin, kSaveBtnH);
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 79;
}

-(void)setObject:(id)object
{
    if ([object isKindOfClass:[OrderSettlementSaveBtnCellModel class]]) {
        OrderSettlementSaveBtnCellModel *saveBtnModel = object;
        self.delegate = saveBtnModel.cellSelResponse;
    }
}

-(void)saveBtnOnClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderSettlementSaveBtnOnClicked)]) {
        [self.delegate orderSettlementSaveBtnOnClicked];
    }
}
@end
