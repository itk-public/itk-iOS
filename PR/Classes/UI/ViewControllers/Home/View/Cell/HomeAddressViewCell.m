//
//  HomeAddressViewCell.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "HomeAddressViewCell.h"

@interface HomeAddressViewCell()
@property (strong,nonatomic) UILabel *locationIconLabel;
@property (strong,nonatomic) UILabel *addressLabel;
@property (strong,nonatomic) UILabel *editPromptLabel;
@property (strong,nonatomic) UILabel *arrowIconLabel;
@end

@implementation HomeAddressViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _locationIconLabel = [[UILabel alloc]init];
        [_locationIconLabel setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:_locationIconLabel];
        
        _addressLabel = [[UILabel alloc]init];
        [_addressLabel setText:@"金泽镇朝阳村5组888号"];
        [_addressLabel setTextAlignment:NSTextAlignmentLeft];
        [_addressLabel setTextColor:kColorGray];
        [_addressLabel setFont:KFontNormal(14)];
        [self.contentView addSubview:_addressLabel];
        
        _editPromptLabel = [[UILabel alloc]init];
        [_editPromptLabel setTextColor:UIColorFromRGB(0x149dd6)];
        [_editPromptLabel setFont:KFontNormal(12)];
        [_editPromptLabel setText:@"修改"];
        [_editPromptLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_editPromptLabel];
        
        _arrowIconLabel = [[UILabel alloc]init];
        [_arrowIconLabel setTextColor:kColorGray];
        [self.contentView addSubview:_arrowIconLabel];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    CGFloat kLocationIconW = 10;
    CGFloat kLocationIconH = 14;
    self.locationIconLabel.frame = CGRectMake(kLeftMargin, (self.height - kLocationIconH)/2.0, kLocationIconW, kLocationIconH);
    
    CGFloat kArrowIconW = 8;
    CGFloat kArrowIconH = 13;
    self.arrowIconLabel.frame = CGRectMake(self.width - kLeftMargin - kArrowIconW,self.locationIconLabel.top, kArrowIconW, kArrowIconH);
    CGFloat kArrowIconLeftMarin = 12.0;
    CGFloat kEditPromptLabelW   = [self.editPromptLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.height)].width;
    self.editPromptLabel.frame  = CGRectMake(self.arrowIconLabel.left - kArrowIconLeftMarin - kEditPromptLabelW, 0, kEditPromptLabelW, self.height);
    self.addressLabel.frame = CGRectMake(self.locationIconLabel.right + kArrowIconLeftMarin, 0, self.editPromptLabel.left - self.locationIconLabel.right - 2*kArrowIconLeftMarin, self.height);
}
@end
