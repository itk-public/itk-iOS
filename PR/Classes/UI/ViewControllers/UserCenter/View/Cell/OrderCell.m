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


@interface SingleOrderViewModel : NSObject

@property (readonly,nonatomic) OrderStatus orderStatus;
@property (strong,nonatomic) NSString *numStr;
@property (readonly,nonatomic) NSString *iconName;
@property (readonly,nonatomic) NSString *title;
-(void)upDate:(OrderStatus)orderStatus numStr:(NSString *)numStr iconName:(NSString *)iconName title:(NSString *)title;

@end

@implementation SingleOrderViewModel
-(void)upDate:(OrderStatus)orderStatus numStr:(NSString *)numStr iconName:(NSString *)iconName title:(NSString *)title;
{
    _orderStatus = orderStatus;
    _numStr      = numStr;
    _iconName    = iconName;
    _title       = title;
}


@end

@interface SingleOrderView : UIView
@property (strong,nonatomic) UILabel              *iconLabel;
@property (strong,nonatomic) UILabel              *titleLabel;
@property (strong,nonatomic) UILabel              *numLabel;
@property (strong,nonatomic) SingleOrderViewModel *model;

-(void)upDateWithIconName:(NSString *)iconName title:(NSString *)title numStr:(NSString *)numStr;
@end

@implementation SingleOrderView
-(instancetype)init{
    if (self = [super init]) {
        _iconLabel                    = [[UILabel alloc]init];
        [_iconLabel setTextAlignment:NSTextAlignmentCenter];
        [_iconLabel setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:_iconLabel];

        _titleLabel                   = [[UILabel alloc]init];
        [_titleLabel setTextColor:kColorGray];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor whiteColor]];
        [_titleLabel setFont:KFontNormal(14)];
        [self addSubview:_titleLabel];

        _numLabel                     = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 17, 17)];
        [_numLabel setTextAlignment:NSTextAlignmentCenter];
        [_numLabel setFont:KFontNormal(12)];
        [_numLabel setBackgroundColor:[UIColor whiteColor]];
        _numLabel.layer.borderWidth = OnePoint;
        [_numLabel setTextColor:[UIColor redColor]];
        [_numLabel setBackgroundColor:[UIColor whiteColor]];
        _numLabel.layer.borderColor = kColorTheme.CGColor;
        _numLabel.layer.cornerRadius  = _numLabel.width/2.0;
        _numLabel.layer.masksToBounds = YES;
        [self addSubview:_numLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat titleLabelH  = 18;
    self.titleLabel.frame = CGRectMake(0,self.height - titleLabelH , self.width, titleLabelH);
    CGFloat iconLabelW  = 35;
    self.iconLabel.frame  = CGRectMake(0, 0, iconLabelW, iconLabelW);
    self.iconLabel.centerX = self.width/2.0;
    self.iconLabel.bottom = self.titleLabel.top;
    CGFloat numLabelBottom = self.iconLabel.top + 8;
    CGFloat numLabelLeft   = self.iconLabel.right - 8;
    CGFloat numLabelW      = 17;
    self.numLabel.frame    = CGRectMake(numLabelLeft, numLabelBottom - numLabelW, numLabelW, numLabelW);
    
    
}

-(void)showNumLabelWithNumStr:(NSString *)numStr
{
    if ([numStr length] && [numStr integerValue]) {
        self.numLabel.hidden = NO;
        CGFloat labelW = 17 + 6*(numStr.length - 1);
        _numLabel.frame = CGRectMake(self.numLabel.left,self.numLabel.top, labelW, 17);
        self.numLabel.text = numStr;
    }else{
        self.numLabel.hidden = YES;
    }
}


-(void)setModel:(SingleOrderViewModel *)model
{
    CONDITION_CHECK_RETURN([model isKindOfClass:[SingleOrderViewModel class]]);
    self.iconLabel.text = model.iconName?:@"";
    self.titleLabel.text = model.title?:@"";
    [self showNumLabelWithNumStr:model.numStr];
}
@end

@interface OrderCell()
@property (strong,nonatomic) NSMutableArray *contentList;
@property (strong,nonatomic) NSMutableArray *viewArray;
@property (strong,nonatomic) ItemView       *orderHeaderView;
@end

@implementation OrderCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _contentList = [NSMutableArray arrayWithCapacity:4];
        SingleOrderViewModel *model = [[SingleOrderViewModel alloc]init];
        [model upDate:OrderStatusToDelivery numStr:@"1" iconName:nil title:@"待配送"];
        [_contentList addObject:model];
        
        SingleOrderViewModel *model2 = [[SingleOrderViewModel alloc]init];
        [model2 upDate:OrderStatusToPickUp numStr:@"1" iconName:nil title:@"待自提"];
        [_contentList addObject:model2];
        
        SingleOrderViewModel *model3 = [[SingleOrderViewModel alloc]init];
        [model3 upDate:OrderStatusToComment numStr:@"1" iconName:nil title:@"待评价"];
        [_contentList addObject:model3];
        
        SingleOrderViewModel *model4 = [[SingleOrderViewModel alloc]init];
        [model4 upDate:OrderStatusFefunding numStr:@"1" iconName:nil title:@"退款中"];
        [_contentList addObject:model4];
        
        _viewArray = [NSMutableArray arrayWithCapacity:4];
        for (SingleOrderViewModel *info in _contentList) {
            SingleOrderView *orderView =[[SingleOrderView alloc]init];
            [orderView setModel:info];
            [_viewArray addObject:orderView];
            [self.contentView addSubview:orderView];
        }
        
        _orderHeaderView = [ItemView itemViewWithIconName:nil title:@"我的订单" subTitle:@"查看全部订单" modelData:nil];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOrderView)];
        [_orderHeaderView addGestureRecognizer:tap];
        [self.contentView addSubview:_orderHeaderView];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat headerViewH  = 46;
    self.orderHeaderView.frame = CGRectMake(0, 0, self.width, headerViewH);
    NSInteger i = 0;
    for (SingleOrderView *orderView in self.viewArray) {
        CGFloat orderViewW = self.width/[self.viewArray count];
        CGFloat orderViewX = orderViewW *i;
        orderView.frame = CGRectMake(orderViewX, headerViewH, orderViewW, self.height - headerViewH);
        i ++;
    }
}

-(void)tapOrderView
{
    [PRMBWantedOffice nativeArrestWarrant:APPURL_VIEW_IDENTIFIER_ORDERLIST param:nil];
}
+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 46+ 80;
}

@end
