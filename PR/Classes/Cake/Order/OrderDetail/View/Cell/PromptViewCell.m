//
//  PromptViewCell.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PromptViewCell.h"
#import "OnePixelSepView.h"

@implementation PromptModel


@end


@interface PromptViewCell ()
@property (strong,nonatomic) UILabel *promptLabel;
@property (strong,nonatomic) UILabel *valueLabel;
@property (strong,nonatomic) OnePixelSepView *lineView;
@end

@implementation PromptViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _promptLabel = [[UILabel alloc]init];
        [_promptLabel setFont:KFontNormal(14)];
        [_promptLabel setTextColor:kColorNormal];
        [_promptLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_promptLabel];
        
        _valueLabel = [[UILabel alloc]init];
        [_valueLabel setFont:KFontNormal(13)];
        [_valueLabel setTextColor:kColorGray];
        [_valueLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_valueLabel];
        
        [self setPixelSepSet:PSRectEdgeTop];
        _lineView = [self psTopSep];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    CGFloat kPromptLabelW = [self.promptLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.height)].width;
    self.promptLabel.frame = CGRectMake(kLeftMargin, 0, kPromptLabelW, self.height);
    self.valueLabel.frame  = CGRectMake(0, 0, self.width - self.valueLabel.right - 2*kLeftMargin, self.height);
    self.valueLabel.right = self.width - kLeftMargin;
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[PromptModel class]], 0);
     PromptModel *model = object;
    return [model.cellHeight floatValue];
}

-(void)setObject:(id)object
{
    [super setObject:object];
    CONDITION_CHECK_RETURN([object isKindOfClass:[PromptModel class]]);
    [self setUI];
    
}

-(void)setUI
{
    PromptModel *model = self.object;
    self.promptLabel.text = model.promptString?:@"";
    self.valueLabel.text  = model.valueString?:@"";
    self.valueLabel.textColor = model.valueColor?:self.valueLabel.textColor;
    self.lineView.hidden      = model.hideLineView;
}
@end
