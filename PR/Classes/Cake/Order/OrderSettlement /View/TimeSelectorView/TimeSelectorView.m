//
//  TimeSelectorViewController.m
//  YHClouds
//
//  Created by 黄小雪 on 2017/3/30.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "TimeSelectorView.h"
#import "DateViewCell.h"
#import "TimeViewCell.h"
#import "TimeSelectorDefine.h"
#import "NSString+YJSON.h"

#define kTimeViewH 6*kCellHeight

static UIView *hudView = nil;

@interface TimeSelectorView ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *leftTableView;
@property (strong,nonatomic) UITableView *rightTableView;

@property (strong,nonatomic) CKVMDeliveryTimeInfo  *deliveryInfo;
@property (strong,nonatomic) ODDeliveryTimeInfo    *seletedDateInfo;
@property (strong,nonatomic) ODDSoltTime           *seletedTime;
@property (strong,nonatomic) UILabel               *headerLabel;
@property (strong,nonatomic) UIView                *containerView;
@property (strong,nonatomic) UIView                *headerView;

@end

@implementation TimeSelectorView

-(instancetype)init
{
    if (self = [super init]) {
        self.containerView      = [[UIView alloc]init];
        [self.containerView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.containerView];
        
        self.headerLabel = [[UILabel alloc]init];
        [self.headerLabel setFont:KFontNormal(16)];
        [self.headerLabel setTextAlignment:NSTextAlignmentCenter];
        [self.headerLabel setTextColor:UIColorFromRGB(0x000000)];
        [self.headerLabel setBackgroundColor:UIColorFromRGB(0xf3f3f3)];
        [self.containerView addSubview:self.headerLabel];
        
        self.leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.leftTableView setShowsVerticalScrollIndicator:NO];
        self.leftTableView.delegate = self;
        self.leftTableView.dataSource = self;
        self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.leftTableView.rowHeight  = kCellHeight;
        [self.leftTableView setBackgroundColor:UIColorFromRGB(0xf3f3f3)];
        [self.containerView addSubview:self.leftTableView];
        
        
        self.rightTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.rightTableView.delegate = self;
        self.rightTableView.dataSource = self;
        [self.rightTableView setShowsVerticalScrollIndicator:NO];
        self.rightTableView.rowHeight  = kCellHeight;
        self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.containerView addSubview:self.rightTableView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kLeftTableViewW  = 110 * DDDisplayScale;
    CGFloat kHeaderViewH     = kCellHeight;
    CGFloat KTableViewH      = kTimeViewH - kHeaderViewH;
    self.containerView.frame = CGRectMake(0, self.height - kHeaderViewH - KTableViewH, self.width, kHeaderViewH + KTableViewH);
    self.leftTableView.frame = CGRectMake(0, kHeaderViewH, kLeftTableViewW, KTableViewH);
    self.rightTableView.frame = CGRectMake(self.leftTableView.right, kHeaderViewH, self.containerView.width - kLeftTableViewW, KTableViewH);
    self.headerLabel.frame    = CGRectMake(0, 0, self.containerView.width, kHeaderViewH);
}


-(void)setCKVMDeliveryTimeInfo:(CKVMDeliveryTimeInfo *)deliveryInfo
{
    self.deliveryInfo = deliveryInfo;
    self.headerLabel.text = [self headerLabelTitle:deliveryInfo];
    if (deliveryInfo.selectGroup) {
        self.seletedDateInfo = deliveryInfo.selectGroup;
    }else{
        self.seletedDateInfo = [deliveryInfo.delivertTimeInfo safeObjectAtIndex:0];
    }
    self.seletedDateInfo.selected = YES;
    
    if (deliveryInfo.selectTime) {
        self.seletedTime = deliveryInfo.selectTime;
    }else{
        self.seletedTime = [self.seletedDateInfo.soltTimes safeObjectAtIndex:0];
    }
    self.seletedTime.selected = YES;
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    
    NSInteger leftTabelViewRow = [deliveryInfo.delivertTimeInfo safeIndexOfObject:self.seletedDateInfo];
    if (leftTabelViewRow >= 0) {
        [self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:leftTabelViewRow
                                                                      inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    NSInteger rightTableViewRow = [self.seletedDateInfo.soltTimes safeIndexOfObject:self.seletedTime];
    if (rightTableViewRow >= 0) {
        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rightTableViewRow
                                                                       inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return [self.deliveryInfo.delivertTimeInfo count];
    }
    return [self.seletedDateInfo.soltTimes count] ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        NSString *ID = @"DateViewCell";
        DateViewCell *dateCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (dateCell == nil) {
            dateCell = [[DateViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        ODDeliveryTimeInfo *dateInfo = [self.deliveryInfo.delivertTimeInfo safeObjectAtIndex:indexPath.row];
        [dateCell setObject:dateInfo];
        return dateCell;
    }
    
    NSString *ID = @"TimeViewCell";
    TimeViewCell *timeCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (timeCell == nil) {
        timeCell = [[TimeViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ODDSoltTime *time = [self.seletedDateInfo.soltTimes safeObjectAtIndex:indexPath.row hintClass:[ODDSoltTime class]];
    [timeCell setObject:time];
    return timeCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        [self resetSeletedDateInfo:indexPath.row];
        [self.leftTableView reloadData];
        NSInteger groupIndex = [self selectGroupIndex];
        NSInteger timeIndex  = 0;
        if (indexPath.row == groupIndex) {
            timeIndex = [self seletedTimeIndex];
        }else{
            timeIndex = 0;
        }
        [self resetSeletedTime:timeIndex];
        [self.rightTableView reloadData];
        
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:timeIndex inSection:0];
        [self.rightTableView scrollToRowAtIndexPath:toIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

    }else{
        
        [self resetSeletedTime:indexPath.row];
        [self.rightTableView reloadData];
        self.deliveryInfo.selectTime = self.seletedTime;
        self.deliveryInfo.selectGroup = self.seletedDateInfo;
        [self disappear];
        if (self.returnBlock) {
            self.returnBlock();
        }
    }
}

-(void)resetSeletedTime:(NSInteger)index
{
    if (self.seletedTime) {
        self.seletedTime.selected = NO;
    }
    self.seletedTime = [self.seletedDateInfo.soltTimes safeObjectAtIndex:index];
    self.seletedTime.selected    = YES;
}

-(void)resetSeletedDateInfo:(NSInteger)index
{
    if (self.seletedDateInfo) {
        self.seletedDateInfo.selected = NO;
    }
    self.seletedDateInfo          = [self.deliveryInfo.delivertTimeInfo safeObjectAtIndex:index];
    self.seletedDateInfo.selected = YES;
}


-(NSInteger)selectGroupIndex
{
    if ([self.deliveryInfo.delivertTimeInfo containsObject:self.deliveryInfo.selectGroup]) {
        return [self.deliveryInfo.delivertTimeInfo indexOfObject:self.deliveryInfo.selectGroup];
    }
    return 0;
}

-(NSInteger)seletedTimeIndex
{
    if ([self.seletedDateInfo.soltTimes containsObject:self.deliveryInfo.selectTime]) {
        return [self.seletedDateInfo.soltTimes indexOfObject:self.deliveryInfo.selectTime];
    }
    return 0;
}
-(NSString *)headerLabelTitle:(CKVMDeliveryTimeInfo *)deliveryInfo
{
    NSString *prompt = nil;
    if (deliveryInfo.orderType == OrderDeliveryType) {
        prompt = @"配送时间";
    }else{
        prompt = @"自提时间";
    }
  return prompt;
}

-(void)disappear
{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.frame =  CGRectMake(0,ScreenHeight, ScreenWidth, kTimeViewH);
        [hudView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
    } completion:^(BOOL finished) {
        [hudView removeFromSuperview];
        if (weakSelf.disappearedBlock) {
            weakSelf.disappearedBlock();
        }
    }];
}

-(void)show{
    
    if (hudView.superview) {
        [hudView removeFromSuperview];
        hudView = nil;
    };
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    UIView *background  = [[UIView alloc] initWithFrame:CGRectZero];
    [background setFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)];
    [background setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [self setBottom:background.bounds.size.height];
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kTimeViewH)];
        [background addSubview:self.headerView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTimeSelectorView)];
    [self.headerView addGestureRecognizer:tap];
    
    
    hudView = background;
    [hudView addSubview:self];
    [window addSubview:hudView];
    
     self.frame = CGRectMake(0, ScreenHeight,ScreenWidth ,kTimeViewH);
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.frame =  CGRectMake(0, ScreenHeight - kTimeViewH, ScreenWidth, kTimeViewH);
        [background setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.78]];
    } completion:^(BOOL finished) {
    }];
}

-(void)tapTimeSelectorView
{
    self.seletedDateInfo.selected = NO;
    [self disappear];
}

@end

