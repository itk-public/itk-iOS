//
//  CouponsSelectView.m
//  PR
//
//  Created by 黄小雪 on 28/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CouponsSelectView.h"
#import "ThemeButton.h"
#import "ChooseCouponCell.h"
#import "TableViewHeaderView.h"

#import "CouponModel.h"

static UIView *hudView  = nil;
#define kCouponsSelectViewH  320
@interface CouponsSelectView()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView         *tableView;
@property (strong,nonatomic) ThemeButton         *closeBtn;
@property (strong,nonatomic) TableViewHeaderView *headerView;
@property (strong,nonatomic) NSArray             *couponsList;

@end

@implementation CouponsSelectView

+(instancetype)defaultCouponsSelectView
{
    return [[self alloc]init];
}

-(instancetype)init
{
    if (self = [super init]) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        _headerView = [[TableViewHeaderView alloc]init];
        _headerView.frame = CGRectMake(0, 0, 0, 60);
        [_headerView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_headerView];
        
        _closeBtn = [ThemeButton buttonWithType:UIButtonTypeSystem];
        [_closeBtn setType:CustomBtnTypeGreenBg];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        _closeBtn.frame = CGRectMake(0, 0, 0, 60);
        [_closeBtn addTarget:self action:@selector(closeBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeBtn];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.headerView.frame = CGRectMake(0, 0, self.width, 60);
    self.closeBtn.frame   = CGRectMake(0, self.height - 60, self.width, 60);
    self.tableView.frame = CGRectMake(0, self.headerView.bottom, self.width, self.closeBtn.top - self.headerView.bottom);
}

-(void)setCouponsList:(NSArray *)couponsList
{
    CONDITION_CHECK_RETURN(couponsList && [couponsList count]);
    _couponsList = couponsList;
}

-(void)closeBtnOnClicked
{
    [self disappear];
}


-(void)show
{
    CONDITION_CHECK_RETURN(self.couponsList && [self.couponsList count]);
    if (hudView.superview) {
        [hudView removeFromSuperview];
        hudView = nil;
    }
    
    UIWindow *window = [[[UIApplication sharedApplication]delegate]window];
    UIView  *background = [[UIView alloc]initWithFrame:CGRectZero];
    [background setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [background setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [self setBottom:background.bounds.size.height];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disappear)];
    [background addGestureRecognizer:tap];
    
    hudView    = background;
    [hudView addSubview:self];
    [window addSubview:hudView];
    
    self.frame = CGRectMake(0, ScreenHeight, ScreenWidth,  kCouponsSelectViewH);
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.frame = CGRectMake(0, ScreenHeight - kCouponsSelectViewH, ScreenWidth, kCouponsSelectViewH);
        [background setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.78]];
    }];
}


-(void)disappear
{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.frame = CGRectMake(0, ScreenHeight, ScreenWidth, kCouponsSelectViewH);
        [hudView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
    } completion:^(BOOL finished) {
        [hudView removeFromSuperview];
    }];
}

-(void)setCartCoupons:(CartCoupons *)cartCoupons
{
    CONDITION_CHECK_RETURN([cartCoupons isKindOfClass:[CartCoupons class]]);
    self.couponsList = cartCoupons.coupons;
    [self.headerView setShopName:cartCoupons.shopInfo.shopname];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CONDITION_CHECK_RETURN_VAULE(self.couponsList, 0);
    return [self.couponsList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ChooseCouponCell tableView:tableView rowHeightForObject:[self.couponsList safeObjectAtIndex:indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString static *identifierID = @"choosecouponcell";
    ChooseCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierID];
    if (cell == nil) {
        cell = [[ChooseCouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierID];
    }
    [cell setObject:[self.couponsList safeObjectAtIndex:indexPath.row]];
    return cell;
    
}
@end
