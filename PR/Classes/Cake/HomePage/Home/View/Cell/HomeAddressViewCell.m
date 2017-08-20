//
//  HomeAddressViewCell.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "HomeAddressViewCell.h"
#import "OnePixelSepView.h"

@interface HomeAddressViewCell()
@property (strong,nonatomic) UIImageView *locationIcon;
@property (strong,nonatomic) UILabel *addressLabel;
@property (strong,nonatomic) UILabel *editPromptLabel;
@property (strong,nonatomic) UIImageView *arrowIcon;
@end

@implementation HomeAddressViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:kVCViewBGColor];
        _locationIcon = [[UIImageView alloc]init];
        [_locationIcon setImage:[UIImage imageNamed:@"icon_home-location"]];
        [self.contentView addSubview:_locationIcon];
        
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
        
        _arrowIcon = [[UIImageView alloc]init];
        [_arrowIcon setImage:[UIImage imageNamed:@"icon_right_arrow"]];
        [self.contentView addSubview:_arrowIcon];
        
        [self.contentView setPixelSepSet:PSRectEdgeBottom];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kLeftMargin = 15;
    CGFloat kLocationIconW = 14;
    CGFloat kLocationIconH = 14;
    self.locationIcon.frame = CGRectMake(kLeftMargin, (self.height - kLocationIconH)/2.0, kLocationIconW, kLocationIconH);
    
    CGFloat kArrowIconW = 8;
    CGFloat kArrowIconH = 13;
    self.arrowIcon.frame = CGRectMake(self.width - kLeftMargin - kArrowIconW,self.locationIcon.top, kArrowIconW, kArrowIconH);
    CGFloat kArrowIconLeftMarin = 12.0;
    CGFloat kEditPromptLabelW   = [self.editPromptLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.height)].width;
    self.editPromptLabel.frame  = CGRectMake(self.arrowIcon.left - kArrowIconLeftMarin - kEditPromptLabelW, 0, kEditPromptLabelW, self.height);
    self.addressLabel.frame = CGRectMake(self.locationIcon.right + kArrowIconLeftMarin, 0, self.editPromptLabel.left - self.locationIcon.right - 2*kArrowIconLeftMarin, self.height);
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 45;
}
@end
