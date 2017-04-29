//
//  HPTopBannerCell.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "HPTopBannerCell.h"
#import "FPCycleScrollView.h"
#import "DynamicUIModel.h"
#import "DMExhibitItem.h"

#define CELLHEIGHT          (200 * DDDisplayScale)

@interface HPTopBannerCell()<SDCycleScrollViewDelegate>
@property (strong,nonatomic) FPCycleScrollView *bannerView;

@end
@implementation HPTopBannerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor magentaColor]];
        self.bannerView                        = [[FPCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, APPLICATIONWIDTH, CELLHEIGHT)];
        self.bannerView.delegate               = self;
        self.bannerView.pageControlStyle       = SDCycleScrollViewPageContolStyleAnimated;
        self.bannerView.autoScrollTimeInterval = 4.5;
        self.bannerView.dotColor               = [UIColor whiteColor];
        self.bannerView.placeholderImage       = [UIImage imageNamed:@"default_product_detail_b"];
        self.bannerView.dotPosition = SDCycleScrollviewDotPositionRight;
        [self.contentView addSubview:self.bannerView];
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
    CONDITION_CHECK_RETURN([object isKindOfClass:[DynamicCardItem class]]);
    NSArray *array = ((DynamicCardItem *)object).data;
    NSMutableArray * imgArr = [NSMutableArray array];
    for (DMExhibitItem * item in array) {
        [imgArr addObject:[item.imgInfo imgUrl]?:@""];
    }
    self.bannerView.imageURLStringsGroup = [NSArray arrayWithObjects:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1489588845&di=64735fa10c51f9329efec22e367bd4bc&src=http://pic13.nipic.com/20110419/2457331_142656838000_2.png",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489598931857&di=36b45a6aeb1a005c84121b5f0aed58f8&imgtype=0&src=http%3A%2F%2Fpic1a.nipic.com%2F2008-10-22%2F20081022154043923_2.jpg",@"http://image.yonghuivip.com/image/1487742263071376ebcf38363e22c74f5b6134979167e32ed4bf8?imageView2/0/w/750/h/340/format/webp/q/100", nil];
    self.bannerView.dotPosition = SDCycleScrollviewDotPositionRight;
    
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 210;
}
@end
