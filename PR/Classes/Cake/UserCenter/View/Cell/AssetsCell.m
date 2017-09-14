//
//  AssetsCell.m
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "AssetsCell.h"
#import "OnePixelSepView.h"
#import "UserCenterModel.h"
#import "AccountBalanceViewController.h"
#import "SceneMananger.h"

@interface SingleAssetsModel : NSObject
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *value;
@end

@implementation SingleAssetsModel

@end
@interface SingleAssetsView :UIView

@property (strong,nonatomic) UILabel         *titleLabel;
@property (strong,nonatomic) UILabel         *subTitleLabel;
@property (strong,nonatomic) OnePixelSepView *rightLineView;

@end

@implementation SingleAssetsView
-(instancetype)init{
    if (self = [super init]) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:KFontNormal(16)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:UIColorFromRGB(0x323232)];
        [self addSubview:_titleLabel];
        
        
        _subTitleLabel = [[UILabel alloc]init];
        [_subTitleLabel setFont:KFontNormal(16)];
        [_subTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [_subTitleLabel setTextColor:UIColorFromRGB(0xff8e27)];
        [self addSubview:_subTitleLabel];
        
        [self setPixelSepSet:PSRectEdgeRight];
        _rightLineView = [self psRightSep];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    [self.subTitleLabel sizeToFit];
    self.titleLabel.frame    = CGRectMake(0, 8, self.width - OnePoint, self.titleLabel.height);
    self.subTitleLabel.frame = CGRectMake(0, 0,self.titleLabel.width, self.subTitleLabel.height);
    self.subTitleLabel.bottom = self.height - 9;
}

-(void)setTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    self.titleLabel.text    = title?:@"";
    self.subTitleLabel.text = subTitle?:@"";
}
@end

@interface AssetsCell()
@property (strong,nonatomic) SingleAssetsView *leftView;
@property (strong,nonatomic) SingleAssetsView *rightView;
@property (strong,nonatomic) AccountBalanceViewController *balanceVC;

@end
@implementation AssetsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _leftView = [[SingleAssetsView alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLeftView)];
        [_leftView addGestureRecognizer:tap];
        [self.contentView addSubview:_leftView];
        
        _rightView = [[SingleAssetsView alloc]init];
        [self.contentView addSubview:_rightView];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewW = self.width/2.0;
    self.leftView.frame = CGRectMake(0, 0, viewW, self.height);
    self.rightView.frame = CGRectMake(self.leftView.width, 0, viewW, self.height);
}


-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[AssetsInfo class]]);
    AssetsInfo *info = (AssetsInfo *)object;
    [self.leftView setTitle:@"账户余额" subTitle:info.balanceString];
    [self.rightView setTitle:@"优惠券" subTitle:info.couponString];
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 60;
}

-(void)tapLeftView
{
    if (self.balanceVC == nil) {
        self.balanceVC = [[AccountBalanceViewController alloc]init];
    }
    [[SceneMananger shareMananger]showViewController:self.balanceVC withStyle: U_SCENE_SHOW_PUSH];
}
@end
