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
    self.bannerView.imageURLStringsGroup = imgArr;
    self.bannerView.dotPosition = SDCycleScrollviewDotPositionRight;
    
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 200;
}
@end
