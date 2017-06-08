//
//  GoodDetailMainImageCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "GoodDetailMainImageCell.h"
#import "FPCycleScrollView.h"

#define CELLHEIGHT          (280 * DDDisplayScale)

@implementation GoodDetailMainImageModel

@end

@interface GoodDetailMainImageCell()
@property (strong,nonatomic) FPCycleScrollView *bannerView;
@end

@implementation GoodDetailMainImageCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bannerView                        = [[FPCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, APPLICATIONWIDTH, CELLHEIGHT)];
        self.bannerView.pageControlStyle       = SDCycleScrollViewPageContolStyleAnimated;
        self.bannerView.autoScrollTimeInterval = 4.5;
        self.bannerView.dotColor               = [UIColor whiteColor];
        self.bannerView.placeholderImage       = [UIImage imageNamed:@"default_product_detail_b"];
        self.bannerView.dotPosition = SDCycleScrollviewDotPositionRight;
        [self.contentView addSubview:self.bannerView];
        
//        self.bannerView.embedViewType    = SDEmbedViewGoodsDetail;
//        self.bannerView.infiniteLoop     = YES;
//        self.bannerView.autoScroll       = NO;
//        self.bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//        self.bannerView.dotColor         = [UIColor redColor];
//        self.bannerView.placeholderImage = [UIImage imageNamed:@"default_product_detail_b"];
//        self.bannerView.backgroundColor  = [UIColor whiteColor];
//        [self.bannerView setDotImageName:@"icon_pageUnSeleted" currentDotImageName:@"icon_pageSeleted"];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bannerView.frame = self.contentView.bounds;
}


-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[GoodDetailMainImageModel class]]);
    GoodDetailMainImageModel *model = object;
    self.bannerView.imageURLStringsGroup = model.mainImages;
    self.bannerView.dotPosition = SDCycleScrollviewDotPositionRight;
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[GoodDetailMainImageModel class]], 0);
    return CELLHEIGHT;
}
@end
