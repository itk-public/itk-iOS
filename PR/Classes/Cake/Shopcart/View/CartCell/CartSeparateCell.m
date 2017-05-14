//
//  CartSeparateCellTableViewCell.m
//  YHClouds
//
//  Created by 黄小雪 on 16/9/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartSeparateCell.h"

//#define HEGIHT_CARTHEADERVIEW 42

@interface CartSeparateCell()
@property (strong,nonatomic) UIButton          *seletedBtn;
@property (strong,nonatomic) UILabel           *titleLab;
@property (strong,nonatomic) UILabel           *promptLab;
@property (strong,nonatomic) UIImageView       *arrowImg;
@property (strong,nonatomic) CartSeparateModel *model;

@end
@implementation CartSeparateCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID                 = @"CartSeparateCell";
    CartSeparateCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat margin           = 15;
        CGFloat titleLabW        = self.contentView.width - 2*margin;
        CGFloat titleLabH        = self.contentView.height;
        CGFloat titleCenterY     = (titleLabH + 15)/2.0;
        CGFloat titleLabX        = margin;
        CGFloat titleLabY        = 0;
        _titleLab                = [[UILabel alloc]initWithFrame:CGRectMake(titleLabX, titleLabY, titleLabW, titleLabH)];
        _titleLab.centerY        = titleCenterY;
        [_titleLab setBackgroundColor:[UIColor clearColor]];
        [_titleLab setTextColor:kColorReferenceTawnyColor];
        [_titleLab setFont:KFontNormal(12)];
        [_titleLab setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_titleLab];
        
        _arrowImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_cartarrow"]];
        _arrowImg.frame = CGRectMake(0, HEGIHT_CARTHEADERVIEW/2.0, 5, 9);
        [_arrowImg setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_arrowImg];
        
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLab.height = self.contentView.height;
    CGFloat titleLabW    = [self.titleLab.text sizeWithAttributes:@{NSFontAttributeName:self.titleLab.font}].width;
    self.titleLab.width  = titleLabW;
    CGFloat arrowX       = self.titleLab.right + 4;
    _arrowImg.left       = arrowX;
    _arrowImg.centerY    = self.titleLab.centerY;
    
    
}


-(void)updateWithSellerInfoModel:(CartSeparateModel *)model
                          isEdit:(BOOL)isEdit
                  CartDataHandle:(CartDataHandle *)dataHandle
{
    CONDITION_CHECK_RETURN([model isKindOfClass:[CartSeparateModel class]] && [dataHandle countOfOutOfDelivered]);
    _model                    = model;
    
//    DeliveryInfo * deliveryInfoM = [[ShipAddrManager sharedInstance] deliveryInfo];
//    NSString *titleString        = nil;
//    if (deliveryInfoM.pickselfStyle) { //自提
//        titleString = @"以下商品暂不支持自提";
//    }else{ //配送
//         titleString = @"以下商品暂不支持配送";
//    }
//    self.titleLab.text = titleString?:@"";
}


+(CGFloat)getHeight
{
    return HEGIHT_CARTHEADERVIEW;
}
@end
