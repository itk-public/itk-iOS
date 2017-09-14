//
//  ConsumptionDetailCell.m
//  PR
//
//  Created by 黄小雪 on 2017/9/12.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ConsumptionDetailCell.h"
#import "OnePixelSepView.h"
#import "ConsumptionDetailModel.h"

@interface  ConsumptionDetailCell()

@property (strong,nonatomic) UILabel *promptLabel;
@property (strong,nonatomic) UILabel *dateLabel;
@property (strong,nonatomic) UILabel *moneyLabel;

@end

@implementation ConsumptionDetailCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _promptLabel = [[UILabel alloc]init];
        [_promptLabel setTextColor:UIColorFromRGB(0x030303)];
        [_promptLabel setTextAlignment:NSTextAlignmentLeft];
        [_promptLabel setFont:KFontBold(16)];
        [self.contentView addSubview:_promptLabel];
        
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setTextColor:UIColorFromRGB(0x959595)];
        [_dateLabel setTextAlignment:NSTextAlignmentLeft];
        [_dateLabel setFont:KFontNormal(12)];
        [self.contentView addSubview:_dateLabel];
        
        _moneyLabel = [[UILabel alloc]init];
        [_moneyLabel setTextColor:UIColorFromRGB(0x030303)];
        [_moneyLabel setTextAlignment:NSTextAlignmentLeft];
        [_moneyLabel setFont:KFontBold(20)];
        [self.contentView addSubview:_moneyLabel];
        
        [self.contentView setPixelSepSet:PSRectEdgeBottom];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    CGFloat kTopMargin  = 8;
    [self.promptLabel sizeToFit];
    self.promptLabel.frame = CGRectMake(kLeftMargin, kTopMargin,self.promptLabel.width , self.promptLabel.height);
    
    [self.dateLabel sizeToFit];
    self.dateLabel.frame = CGRectMake(kLeftMargin, self.height - self.dateLabel.height - 10, self.dateLabel.width, self.dateLabel.height);
    
    [self.moneyLabel sizeToFit];
    self.moneyLabel.frame = CGRectMake(self.width - self.moneyLabel.width - kLeftMargin, (self.height - self.moneyLabel.height)/2.0, self.moneyLabel.width, self.moneyLabel.height);
}

-(void)setObject:(id)object
{
    if ([object isKindOfClass:[ConsumptionDetailModel class]]) {
        ConsumptionDetailModel *detailModel = object;
        if (detailModel.type == ConsumptionDetailModelTypeConsumption) {
            self.moneyLabel.textColor = UIColorFromRGB(0x030303);
            self.promptLabel.text = @"消费";
        }else{
            self.moneyLabel.textColor = kColorTheme;
            self.promptLabel.text = @"退款";
        }
        self.moneyLabel.text = detailModel.moneyStr;
        self.dateLabel.text = detailModel.dateStr?:@"";
        
    }
}
+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 59;
}
@end
