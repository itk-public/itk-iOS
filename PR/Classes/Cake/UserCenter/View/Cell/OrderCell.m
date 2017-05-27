//
//  OrderCell.m
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderCell.h"
#import "CustomInfoType.h"
#import "ItemView.h"
#import "PRMBWantedOffice.h"
#import "UserCenterModel.h"


@interface SingleOrderViewModel : NSObject

@property (readonly,nonatomic) OrderStatus orderStatus;
@property (strong,nonatomic) NSString *numStr;
@property (readonly,nonatomic) NSString *iconName;
@property (readonly,nonatomic) NSString *title;
-(void)upDate:(OrderStatus)orderStatus num:(NSInteger)num iconName:(NSString *)iconName title:(NSString *)title;

@end

@implementation SingleOrderViewModel
-(void)upDate:(OrderStatus)orderStatus num:(NSInteger)num iconName:(NSString *)iconName title:(NSString *)title;
{
    _orderStatus = orderStatus;
    if(num){
        _numStr  = [NSString stringWithFormat:@"%zd",num];
    }else{
        _numStr  = @"";
    }
    _iconName    = iconName;
    _title       = title;
}


@end

@interface SingleOrderView : UIView
@property (strong,nonatomic) UIImageView          *iconImage;
@property (strong,nonatomic) UILabel              *titleLabel;
@property (strong,nonatomic) UILabel              *numLabel;
@property (strong,nonatomic) SingleOrderViewModel *model;

-(void)upDateWithIconName:(NSString *)iconName title:(NSString *)title numStr:(NSString *)numStr;
@end

@implementation SingleOrderView
-(instancetype)init{
    if (self = [super init]) {
        _iconImage                    = [[UIImageView alloc]init];
        [_iconImage setContentMode: UIViewContentModeScaleAspectFit];
        [self addSubview:_iconImage];

        _titleLabel                   = [[UILabel alloc]init];
        [_titleLabel setTextColor:UIColorFromRGB(0x323232)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor whiteColor]];
        [_titleLabel setFont:KFontNormal(12)];
        [self addSubview:_titleLabel];

        _numLabel                     = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 17, 17)];
        [_numLabel setTextAlignment:NSTextAlignmentCenter];
        [_numLabel setFont:KFontNormal(10)];
        [_numLabel setBackgroundColor:[UIColor whiteColor]];
        _numLabel.layer.borderWidth = 1;
        [_numLabel setTextColor:kColorTheme];
        [_numLabel setBackgroundColor:[UIColor whiteColor]];
        _numLabel.layer.borderColor = kColorTheme.CGColor;
        _numLabel.layer.cornerRadius  = 6.0;
        _numLabel.layer.masksToBounds = YES;
        [self addSubview:_numLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(0,0 , self.width, self.titleLabel.height);
    self.titleLabel.bottom = self.height - 13;
    CGFloat iconLabelW  = 24;
    self.iconImage.frame  = CGRectMake(0, 15, iconLabelW, iconLabelW);
    self.iconImage.centerX = self.width/2.0;
    CGFloat numLabelBottom = self.iconImage.top + 8;
    CGFloat numLabelLeft   = self.iconImage.right - 8;
    CGFloat numLabelH      = 12;
    CGFloat numLableW      = 12+6*[[self.numLabel text]length];
    
    self.numLabel.frame    = CGRectMake(numLabelLeft, numLabelBottom - numLabelH, numLableW, numLabelH);
    
    
}


-(void)setModel:(SingleOrderViewModel *)model
{
    CONDITION_CHECK_RETURN([model isKindOfClass:[SingleOrderViewModel class]]);
    self.iconImage.image = [UIImage imageNamed:model.iconName];
    self.titleLabel.text = model.title?:@"";
    self.numLabel.text   = model.numStr;
    self.numLabel.hidden = ![self.numLabel.text integerValue];
    [self setNeedsLayout];
}
@end

#define  kBaseTag  100000
@interface OrderCell()
@property (strong,nonatomic) NSMutableArray *contentList;
@property (strong,nonatomic) ItemView       *orderHeaderView;
@end

@implementation OrderCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _orderHeaderView = [ItemView itemViewWithIconName:@"icon_usercenter_order" title:@"我的订单" subTitle:nil modelData:nil];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOrderView)];
        [_orderHeaderView addGestureRecognizer:tap];
        [self.contentView addSubview:_orderHeaderView];
        
        for (NSInteger i = 0; i < 4; i++) {
            SingleOrderView *orderView =[[SingleOrderView alloc]init];
            orderView.tag = i + kBaseTag;
            [self.contentView addSubview:orderView];
        }

    }
    return self;
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[OrderInfo class]]);
    _contentList = [NSMutableArray arrayWithCapacity:4];
    OrderInfo *orderInfo = object;
    NSString  *toDeliveryString = nil;
    SingleOrderViewModel *model = [[SingleOrderViewModel alloc]init];
    [model upDate:OrderStatusToDelivery num:orderInfo.toDelivery iconName:@"icon_usercenter_todelivery" title:@"待配送"];
    [((SingleOrderView *)[self.contentView viewWithTag:kBaseTag]) setModel:model];
    
    SingleOrderViewModel *model2 = [[SingleOrderViewModel alloc]init];
    [model2 upDate:OrderStatusToPickUp num:orderInfo.toPick iconName:@"icon_usercenter_pickup" title:@"待自提"];
    [((SingleOrderView *)[self.contentView viewWithTag:kBaseTag + 1]) setModel:model2];
    
    SingleOrderViewModel *model3 = [[SingleOrderViewModel alloc]init];
    [model3 upDate:OrderStatusToComment num:orderInfo.toComment iconName:@"icon_usercenter_tocomment" title:@"待评价"];
     [((SingleOrderView *)[self.contentView viewWithTag:kBaseTag + 2]) setModel:model3];
    
    SingleOrderViewModel *model4 = [[SingleOrderViewModel alloc]init];
    [model4 upDate:OrderStatusFefunding num:orderInfo.refunding iconName:@"icon_usercenter_refund" title:@"退款中"];
    [((SingleOrderView *)[self.contentView viewWithTag:kBaseTag + 3]) setModel:model4];

    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat headerViewH  = 46;
    self.orderHeaderView.frame = CGRectMake(0, 0, self.width, headerViewH);
    NSInteger i = 0;
    for (SingleOrderView *orderView in self.contentView.subviews) {
        if ([orderView isKindOfClass:[SingleOrderView class]]) {
            CGFloat orderViewW = self.width/4.0;
            CGFloat orderViewX = orderViewW *i;
            orderView.frame = CGRectMake(orderViewX, headerViewH, orderViewW, self.height - headerViewH);
            i ++;
        }
        
    }
}

-(void)tapOrderView
{
    [PRMBWantedOffice nativeArrestWarrant:APPURL_VIEW_IDENTIFIER_ORDERLIST param:nil];
}
+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 46+ 72;
}

@end
