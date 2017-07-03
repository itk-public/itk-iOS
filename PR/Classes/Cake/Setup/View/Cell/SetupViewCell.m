//
//  SetupViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/22.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SetupViewCell.h"
#import "OnePixelSepView.h"
#import "SetupViewCell.h"
#import "SetupDefine.h"

@interface SetupViewCell()
@property (strong,nonatomic) UILabel *leftLabel;
@property (strong,nonatomic) UILabel *subTitleLabel;
@property (strong,nonatomic) UIImageView *arrow;
@property (assign,nonatomic) SetupViewTnteractiveType  interactiveType;

@end
@implementation SetupViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _leftLabel = [[UILabel alloc]init];
        [_leftLabel setTextAlignment:NSTextAlignmentLeft];
        [_leftLabel setFont:KFontNormal(16)];
        [_leftLabel setTextColor:UIColorFromRGB(0x030303)];
        [self.contentView addSubview:_leftLabel];
        
        _subTitleLabel = [[UILabel alloc]init];
        [_subTitleLabel setFont:KFontNormal(14)];
        [_subTitleLabel setTextAlignment:NSTextAlignmentRight];
        [_subTitleLabel setTextColor:UIColorFromRGB(0x959595)];
        [self.contentView addSubview:_subTitleLabel];
        
        _arrow = [[UIImageView alloc]init];
        [_arrow setImage:[UIImage imageNamed:@"icon_arrow_right"]];
        [self.contentView addSubview:_arrow];
        
        [self.contentView setPixelSepSet:PSRectEdgeBottom];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    [self.leftLabel sizeToFit];
    CGFloat kLeftLabelW = self.leftLabel.width;
    self.leftLabel.frame = CGRectMake(kLeftMargin, 0, kLeftLabelW, self.height);
    
    CGFloat kArrowW = 6;
    CGFloat kArrowH = 11;
    self.arrow.frame = CGRectMake(self.width - kArrowW - kLeftMargin, (self.height - kArrowH)/2.0, kArrowW, kArrowH);

    [self.subTitleLabel sizeToFit];
    self.subTitleLabel.frame = CGRectMake(self.arrow.left - 10 - self.subTitleLabel.width, 0, self.subTitleLabel.width, self.height);

}

-(void)setObject:(NSObject *)object
{
    NSDictionary *dict = (NSDictionary *)object;
    self.leftLabel.text = [dict safeObjectForKey:kLeftString]?:@"";
    self.subTitleLabel.text = [dict safeObjectForKey:kSubTitleString]?:@"";
    self.interactiveType = [[dict safeObjectForKey:kTnteractiveType]integerValue];
    [self setNeedsLayout];
}

@end
