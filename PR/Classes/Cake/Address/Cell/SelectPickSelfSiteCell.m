//
//  SelectPickSelfSiteCell.m
//  PR
//
//  Created by 黄小雪 on 2017/5/30.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SelectPickSelfSiteCell.h"
#import "OnePixelSepView.h"
#import "PickSelfSiteModel.h"

@interface SelectPickSelfSiteCell()
@property (strong,nonatomic) UILabel *siteName;
@property (strong,nonatomic) UILabel *siteAddress;
@property (strong,nonatomic) PickSelfSiteModel *siteModel;

@end

@implementation SelectPickSelfSiteCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        _siteName = [[UILabel alloc]init];
        [_siteName setFont:KFontBold(15)];
        [_siteName setTextColor:UIColorFromRGB(0x030303)];
        [_siteName setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_siteName];
        
        _siteAddress = [[UILabel alloc]init];
        [_siteAddress setFont:KFontNormal(12)];
        [_siteAddress setTextColor:UIColorFromRGB(0x959595)];
        [_siteAddress setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_siteAddress];
        
        [self.contentView setPixelSepSet:PSRectEdgeBottom];
        
    }
    return self;
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[PickSelfSiteModel class]]);
    self.siteModel = object;
    self.siteName.text = self.siteModel.pickSelfSiteName?:@"";
    self.siteAddress.text = self.siteModel.pickSelfSiteAddress?:@"";
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kLeftMargin = 15;
    [self.siteName sizeToFit];
    self.siteName.frame = CGRectMake(kLeftMargin, 10,self.width - 2*kLeftMargin , self.siteName.height);
    [self.siteAddress sizeToFit];
    self.siteAddress.frame = CGRectMake(kLeftMargin, self.siteName.bottom + 8, self.siteName.width, self.siteAddress.height);
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 65;
}
@end
