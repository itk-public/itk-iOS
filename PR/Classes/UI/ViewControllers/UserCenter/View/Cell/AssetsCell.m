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
        [_titleLabel setFont:KFontNormal(12)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:kColorNormal];
        [self addSubview:_titleLabel];
        
        
        _subTitleLabel = [[UILabel alloc]init];
        [_subTitleLabel setFont:KFontNormal(12)];
        [_subTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [_subTitleLabel setTextColor:kColorTheme];
        [self addSubview:_subTitleLabel];
        
        [self setPixelSepSet:PSRectEdgeRight];
        _rightLineView = [self psRightSep];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame    = CGRectMake(0, 0, self.width - OnePoint, self.height/2.0);
    self.subTitleLabel.frame = CGRectMake(0, self.titleLabel.bottom,self.titleLabel.width, self.titleLabel.height);
}

-(void)setTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    self.titleLabel.text    = title?:@"";
    self.subTitleLabel.text = subTitle?:@"";
}
@end

@interface AssetsCell()
@property (strong,nonatomic) NSMutableArray *contentArray;

@end
@implementation AssetsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _contentArray = [NSMutableArray array];
        SingleAssetsModel *model1 = [[SingleAssetsModel alloc]init];
        model1.title = @"账号余额";
        model1.value = @"￥134.99";
        [_contentArray addObject:model1];
        
        SingleAssetsModel *model2 = [[SingleAssetsModel alloc]init];
        model2.title = @"优惠券";
        model2.value = @"5张";
        [_contentArray addObject:model2];
        
        for (SingleAssetsModel *info in _contentArray) {
            SingleAssetsView *view = [[SingleAssetsView alloc]init];
            [view setTitle:info.title subTitle:info.value];
            [self.contentView addSubview:view];
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger i = 0;
    for (SingleAssetsView *view in self.contentView.subviews) {
        CGFloat viewW = self.width/[self.contentView.subviews count];
        CGFloat viewX = viewW * i ;
        view.frame = CGRectMake(viewX, 0, viewW, self.height);
        i ++;
    }
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 50;
}
@end
