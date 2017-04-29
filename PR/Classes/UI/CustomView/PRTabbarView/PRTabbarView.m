//
//  YHTabbarView.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "PRTabbarView.h"

#define WIDTH_TABBAR (APPLICATIONWIDTH/4)

#define WIDTH_IMAGE         25.0f

#define LITTE_SQUARE_WIDTH  10.5f

#define HEIGHT_LABEL        10.0f

@interface PRTabbarView()
@property (nonatomic, strong) UIImageView    * firstImgView;
@property (nonatomic, strong) UIImageView    * secondImgView;
@property (nonatomic, strong) UIImageView    * thirdImgView;
@property (nonatomic, strong) UIImageView    * forthImgView;

@property (nonatomic, strong) UILabel        * firstLabel;
@property (nonatomic, strong) UILabel        * secondLabel;
@property (nonatomic, strong) UILabel        * thirdLabel;
@property (nonatomic, strong) UILabel        * forthLabel;

@property (nonatomic, strong) NSArray        * selectedImgArr;

@property (nonatomic, strong) NSArray        * unSelectedImgArr;

@property (nonatomic, strong) NSMutableArray * tabbarIconArr;
@property (nonatomic, strong) NSMutableArray * tabbarTextArr;

@property (nonatomic, assign) BOOL           isSecondAnimationCancel;

@property (nonatomic, assign) NSInteger      currentIndex;

@end
@implementation PRTabbarView

-(instancetype)initWithSelectedImgDic:(NSDictionary *)imgDic{
    if (self = [super init]) {
        self.tabbarIconArr = [NSMutableArray array];
        self.tabbarTextArr = [NSMutableArray array];
        self.currentIndex  = 0;
        if (imgDic.count) {
            self.backgroundColor = [UIColor clearColor];
            self.userInteractionEnabled = NO;
            self.frame = CGRectMake(0, 0, WIDTH_TABBAR, 48);
            self.selectedImgArr         = [imgDic objectForKey:@"selected"];
            self.unSelectedImgArr       = [imgDic objectForKey:@"unSelected"];
            
            _firstImgView                 = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_TABBAR - WIDTH_IMAGE)/2,7, WIDTH_IMAGE, WIDTH_IMAGE)];
            _firstImgView.image           = [UIImage imageNamed:self.selectedImgArr[0]];
            _firstImgView.backgroundColor = [UIColor clearColor];
            _firstImgView.contentMode     = UIViewContentModeScaleAspectFill;
            _firstImgView.opaque          = YES;
            [self addSubview:_firstImgView];
            [self.tabbarIconArr addObject:_firstImgView];
            
            _firstLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, _firstImgView.bottom + 5, WIDTH_TABBAR, HEIGHT_LABEL)];
            _firstLabel.backgroundColor = [UIColor clearColor];
            _firstLabel.textColor       = kColorReferenceTawnyColor;
            _firstLabel.font            = KFontNormal(10);
            _firstLabel.textAlignment   = NSTextAlignmentCenter;
            _firstLabel.text            = @"首页";
            [self addSubview:_firstLabel];
            [self.tabbarTextArr addObject:_firstLabel];
            
            _secondImgView                 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_TABBAR + (WIDTH_TABBAR - WIDTH_IMAGE)/2, 7, WIDTH_IMAGE, WIDTH_IMAGE)];
            _secondImgView.image           = [UIImage imageNamed:self.unSelectedImgArr[1]];
            _secondImgView.backgroundColor = [UIColor clearColor];
            _secondImgView.contentMode     = UIViewContentModeScaleAspectFill;
            _secondImgView.opaque          = YES;
            [self addSubview:_secondImgView];
            [self.tabbarIconArr addObject:_secondImgView];
            
            _secondLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_TABBAR, _secondImgView.bottom + 5, WIDTH_TABBAR, HEIGHT_LABEL)];
            _secondLabel.backgroundColor = [UIColor clearColor];
            _secondLabel.textColor       = kColorTabTextColor;
            _secondLabel.font            = KFontNormal(10);
            _secondLabel.textAlignment   = NSTextAlignmentCenter;
            _secondLabel.text            = @"分类";
            [self addSubview:_secondLabel];
            [self.tabbarTextArr addObject:_secondLabel];
            
            _thirdImgView                 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_TABBAR * 2 + (WIDTH_TABBAR - WIDTH_IMAGE)/2, 7, WIDTH_IMAGE, WIDTH_IMAGE)];
            _thirdImgView.image           = [UIImage imageNamed:self.unSelectedImgArr[2]];
            _thirdImgView.backgroundColor = [UIColor clearColor];
            _thirdImgView.contentMode     = UIViewContentModeScaleAspectFill;
            _thirdImgView.opaque          = YES;
            [self addSubview:_thirdImgView];
            [self.tabbarIconArr addObject:_thirdImgView];
            
            _thirdLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_TABBAR * 2, _thirdImgView.bottom + 5, WIDTH_TABBAR, HEIGHT_LABEL)];
            _thirdLabel.backgroundColor = [UIColor clearColor];
            _thirdLabel.textColor       = kColorTabTextColor;
            _thirdLabel.font            = KFontNormal(10);
            _thirdLabel.textAlignment   = NSTextAlignmentCenter;
            _thirdLabel.text            = @"购物车";
            [self addSubview:_thirdLabel];
            [self.tabbarTextArr addObject:_thirdLabel];
            
            _forthImgView                 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_TABBAR * 3 + (WIDTH_TABBAR - WIDTH_IMAGE)/2, 7, WIDTH_IMAGE, WIDTH_IMAGE)];
            _forthImgView.image           = [UIImage imageNamed:self.unSelectedImgArr[3]];
            _forthImgView.backgroundColor = [UIColor clearColor];
            _forthImgView.contentMode     = UIViewContentModeScaleAspectFill;
            _forthImgView.opaque          = YES;
            [self addSubview:_forthImgView];
            [self.tabbarIconArr addObject:_forthImgView];
            
            _forthLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_TABBAR * 3, _forthImgView.bottom + 5, WIDTH_TABBAR, HEIGHT_LABEL)];
            _forthLabel.backgroundColor = [UIColor clearColor];
            _forthLabel.textColor       = kColorTabTextColor;
            _forthLabel.font            = KFontNormal(10);
            _forthLabel.textAlignment   = NSTextAlignmentCenter;
            _forthLabel.text            = @"会员中心";
            [self addSubview:_forthLabel];
            [self.tabbarTextArr addObject:_forthLabel];
        }
    }
    
    return self;
}

-(void)setSelectedIndex:(NSInteger)index{
    if (index == self.currentIndex) return;
    for (NSInteger i = 0; i < [self.tabbarIconArr count]; i ++) {
        [self.tabbarIconArr[i] setImage:[UIImage imageNamed: index == i ? self.selectedImgArr[i] : self.unSelectedImgArr[i]]];
        [self.tabbarTextArr[i] setTextColor: index == i ? kColorReferenceTawnyColor : kColorTabTextColor];
    }
    self.currentIndex = index;
}


-(NSInteger)curSeletedIndex{
    return self.currentIndex;
}

//修改tabbar的显示名字
- (void)alterTabBarName:(NSString *)name
                  index:(NSInteger)index
{
    if (index >= 0 && index < self.tabbarTextArr.count ) {
        
        UILabel *label = [self.tabbarTextArr objectAtIndex:index];
        label.text = name;
    }
}
@end
