//
//  HeadPortraitCell.m
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//  个人中心的头像cell

#import "HeadPortraitCell.h"
#import "UserCenterModel.h"
#import "UserManager.h"
#import "PRMBWantedOffice.h"

@interface HeadPortraitCell()

@property (strong,nonatomic) UILabel         *healPortraitLabel;
@property (strong,nonatomic) UILabel         *nickNameLabel;
@property (strong,nonatomic) UILabel         *phoneNumLabel;
@property (strong,nonatomic) UserInfo        *model;

@end
@implementation HeadPortraitCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _healPortraitLabel                     = [[UILabel alloc]init];
        [_healPortraitLabel setBackgroundColor:[UIColor orangeColor]];
        _healPortraitLabel.layer.borderColor   = [UIColor clearColor].CGColor;
        _healPortraitLabel.layer.borderWidth   = OnePoint;
        _healPortraitLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_healPortraitLabel];
        
        _nickNameLabel  = [[UILabel alloc]init];
        [_nickNameLabel setTextColor:kColorGray];
        [_nickNameLabel setFont:KFontNormal(14)];
        [_nickNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_nickNameLabel];
        
        _phoneNumLabel = [[UILabel alloc]init];
        [_phoneNumLabel setTextColor:kColorGray];
        [_phoneNumLabel setFont:KFontNormal(14)];
        [_phoneNumLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_phoneNumLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        [self.contentView addGestureRecognizer:tap];
        
        [self.contentView setBackgroundColor:kColorYHBrown];
    }
    return self;
}

-(void)setObject:(id)object
{
    if ([[UserManager shareMananger] isUserLogin] &&
        [object isKindOfClass:[UserInfo class]]) {
        self.model                = object;
        self.nickNameLabel.text   = self.model.nickName?:@"";
        self.nickNameLabel.hidden = !self.model.nickName;
        self.phoneNumLabel.text   = self.model.phoneNum?:@"";
        self.phoneNumLabel.hidden = !self.model.phoneNum;
    }else{
        self.nickNameLabel.hidden = YES;
        self.phoneNumLabel.hidden = NO;
        [self.phoneNumLabel setText:@"登录/注册"];
    }
    
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 190;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat healPortraitLabelW  = 45;
    self.healPortraitLabel.frame = CGRectMake(0, 0, healPortraitLabelW, healPortraitLabelW);
    self.healPortraitLabel.centerX = self.width/2.0;
    self.healPortraitLabel.centerY = self.height/2.0;
    self.healPortraitLabel.layer.cornerRadius  = healPortraitLabelW/2.0;
    
    CGFloat nickNameLabelH       = [self.nickNameLabel sizeThatFits:CGSizeMake(self.width, MAXFLOAT)].height;
    CGFloat leftMargin           = 15;
    CGFloat nickNameLabelTop     = 10;
    self.nickNameLabel.frame     = CGRectMake(leftMargin, self.healPortraitLabel.bottom + nickNameLabelTop, self.width - 2*leftMargin, nickNameLabelH);
    
     CGFloat phoneNumLabelH       = [self.phoneNumLabel sizeThatFits:CGSizeMake(self.width, MAXFLOAT)].height;
    self.phoneNumLabel.frame      = CGRectMake(leftMargin, self.nickNameLabel.bottom + nickNameLabelTop, self.width - 2*leftMargin, phoneNumLabelH);
    if (self.nickNameLabel.hidden) {
        self.phoneNumLabel.top   = self.healPortraitLabel.bottom + nickNameLabelTop;
    }
}

-(void)tapView:(UITapGestureRecognizer *)tap
{
     [PRMBWantedOffice nativeArrestWarrant:APPURL_VIEW_IDENTIFIER_MEMBER_LOGIN param:nil];
}
@end
