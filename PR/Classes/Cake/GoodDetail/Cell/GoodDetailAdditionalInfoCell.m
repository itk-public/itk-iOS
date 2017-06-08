//
//  AdditionalInfoCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//  快递、销量、产地

#import "GoodDetailAdditionalInfoCell.h"

@implementation GoodDetailAdditionalInfo
@end

@interface GoodDetailAdditionalInfoCell()
@property (strong,nonatomic) UILabel *leftLabel;
@property (strong,nonatomic) UILabel *rightLabel;
@property (strong,nonatomic) UILabel *middleLabel;
@end
@implementation GoodDetailAdditionalInfoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        _leftLabel = [[UILabel alloc]init];
        [_leftLabel setTextAlignment:NSTextAlignmentLeft];
        [_leftLabel setFont:KFontNormal(14)];
        [_leftLabel setTextColor:UIColorFromRGB(0x959595)];
        [self.contentView addSubview:_leftLabel];
        
        _rightLabel = [[UILabel alloc]init];
        [_rightLabel setTextAlignment:NSTextAlignmentRight];
        [_rightLabel setFont:KFontNormal(14)];
        [_rightLabel setTextColor:UIColorFromRGB(0x959595)];
        [self.contentView addSubview:_rightLabel];
        
        _middleLabel = [[UILabel alloc]init];
        [_middleLabel setTextAlignment:NSTextAlignmentCenter];
        [_middleLabel setFont:KFontNormal(14)];
        [_middleLabel setTextColor:UIColorFromRGB(0x959595)];
        [self.contentView addSubview:_middleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    [self.leftLabel sizeToFit];
    self.leftLabel.frame = CGRectMake(kLeftMargin, 0, self.leftLabel.width, self.height);
    
    [self.rightLabel sizeToFit];
    self.rightLabel.frame = CGRectMake(self.width - kLeftMargin - self.rightLabel.width, 0, self.rightLabel.width, self.height);
    
    [self.middleLabel sizeToFit];
    self.middleLabel.frame = CGRectMake(0, 0, self.middleLabel.width, self.height);
    self.middleLabel.centerX = self.width/2.0;
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[GoodDetailAdditionalInfo class]]);
    GoodDetailAdditionalInfo *info = object;
    NSArray *strs = info.additionalInfo;
    NSInteger i = 0;
    for (NSString *str in strs) {
        if (i == 0) {
            self.leftLabel.text = str?:@"";
        }else if (i == 1){
            self.middleLabel.text = str?:@"";
        }else{
            self.rightLabel.text  = str?:@"";
        }
        i++;
    }
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[GoodDetailAdditionalInfo class]], 0);
    return 40;
}
@end
