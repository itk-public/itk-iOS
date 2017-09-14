//
//  OrderListSectionFooterView.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderListSubtotalViewCell.h"
#import "SubtotalView.h"
#import "ShopDiscountView.h"
#import "OrderListActionViewCell.h"
#import "OnePixelSepView.h"

@implementation OrderListSubtotalViewCellModel

@end

@interface OrderListSubtotalViewCell()
@property (strong,nonatomic) UILabel *leftLable;
@property (strong,nonatomic) UILabel *priceLabel;
@end
@implementation OrderListSubtotalViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _leftLable = [[UILabel alloc]init];
        [_leftLable setTextAlignment:NSTextAlignmentLeft];
        [_leftLable setTextColor:UIColorFromRGB(0x030303)];
        [_leftLable setFont:KFontNormal(12)];
        [self.contentView addSubview:_leftLable];
        
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextColor:kColorPrice];
        [_priceLabel setTextAlignment:NSTextAlignmentRight];
        [_priceLabel setFont:KFontNormal(12)];
        [self.contentView addSubview:_priceLabel];
        
        [self.contentView setPixelSepSet: PSRectEdgeBottom];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kPriceLabelRightMargin = 15;
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(self.width - self.priceLabel.width - kPriceLabelRightMargin, 0, self.priceLabel.width, self.height);
    [self.leftLable sizeToFit];
    self.leftLable.frame  = CGRectMake(self.priceLabel.left - 5 - self.leftLable.width, 0, self.leftLable.width, self.height);
}


-(void)setObject:(id)object
{
    if ([object isKindOfClass:[OrderListSubtotalViewCellModel class]]) {
        OrderListSubtotalViewCellModel *model = object;
        self.leftLable.text = [NSString stringWithFormat:@"共%zd件商品  小记",model.proudctCount];
        self.priceLabel.text = model.totalPayment;
    }
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 46;
}
@end
