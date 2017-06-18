//
//  ShopHomeCouponCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/10.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeCouponCell.h"
#import "CarouselView.h"
#import "ShopHomeCarouselView.h"

@implementation ShopHomeCouponCellModel

@end

@interface ShopHomeCouponCell()
@property (strong,nonatomic) ShopHomeCarouselView *carouselView;

@end
@implementation ShopHomeCouponCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _carouselView = [[ShopHomeCarouselView alloc]init];
        [self.contentView addSubview:_carouselView];
        [self.contentView setBackgroundColor:kVCViewBGColor];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.carouselView.frame = self.bounds;
}


-(void)setObject:(id)object
{
    if ([object isKindOfClass:[ShopHomeCouponCellModel class]] ) {
        self.hidden = NO;
        NSArray *list = [(ShopHomeCouponCellModel *)object coupons];
        [self.carouselView setUpDatalist:list];
        [self setNeedsLayout];
    }else{
        self.hidden = YES;
    }
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[ShopHomeCouponCellModel class]], 0);
    return 100;
}



@end
