//
//  ExhibitImageTextView.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ExhibitImageTextView.h"
#import "OnePixelSepView.h"
#import "ActionHandler.h"
#import "UIImage+Category.h"

@interface ExhibitImageTextView()
@property(nonatomic,strong) DMExhibitItem * item;
@property(nonatomic,assign) CGFloat         fontAppendHeight;
@property(nonatomic,strong) UIColor       * showTagColor;

//用于埋点
@property (strong,nonatomic) NSString     * page_type;
@property (assign,nonatomic) NSInteger      postion;
@property (strong,nonatomic) NSString     * sellerid;
@property (strong,nonatomic) NSString     * shopid;
@property (strong,nonatomic) NSString     * pattern;
@property (assign,nonatomic) BOOL           isMainTheme;  //是否是主主题馆
@end

@implementation ExhibitImageTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImageURL)];
        [self addGestureRecognizer:tapGesture];
        
        _imageView = [[AutoImageView alloc] initWithFrame:self.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textColor = kColorTitleInfo;
        _subTitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _subTitleLabel.textColor = kColorSubTitleInfo;
        
        _tagView = [[UIButton alloc] initWithFrame:CGRectZero];
        _tagView.hidden = YES;
        _tagView.userInteractionEnabled = NO;
        _tagView.titleLabel.font = KFontNormal(10);
        [self addSubview:_titleLabel];
        [self addSubview:_subTitleLabel];
        [self addSubview:_tagView];
        _imageStyle = ExhibitImageExpandStyle;
        [self setClipsToBounds:YES];
    }
    return self;
}

- (void)updateWithExhibitItem:(DMExhibitItem *)item
{
    self.item = item;
//    [self.imageView setImgInfo:item.imgInfo withPlaceholderImage:[UIImage imageNamed:@"default_product_img_yh"]];
//    self.titleLabel.text = item.title;
//    self.subTitleLabel.text = item.subTitle;
//    
//    if (item.tagInfo && [item.tagInfo.tagContent length] > 0) {
//        self.tagView.hidden = NO;
//        [self.tagView setTitle:item.tagInfo.tagContent forState:UIControlStateNormal];
//        if (NO == [self.showTagColor isEqual:item.tagInfo.tagBgColor]) {
//            UIImage * colorImg = [[UIImage imageNamed:@"theme-tag-bg-green"] changeImageWithColor:item.tagInfo.tagBgColor];
//            UIImage * tagImag =[colorImg resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeTile];
//            [self.tagView setBackgroundImage:tagImag forState:UIControlStateNormal];
//        }
//    }else{
//        self.tagView.hidden = YES;
//    }
    
    [self setNeedsLayout];
}

- (void)setTitleFontSize:(CGFloat)titleFontSize
{
    _titleFontSize = titleFontSize;
    self.titleLabel.font = KFontNormal(titleFontSize);
    self.fontAppendHeight = 0;
}

- (void)setSubTitleFontSize:(CGFloat)subTitleFontSize
{
    _subTitleFontSize = subTitleFontSize;
    self.subTitleLabel.font = KFontNormal(subTitleFontSize);
    self.fontAppendHeight = 0;
}

- (void)setTitleBoldFontSize:(CGFloat)titleFontSize
{
    _titleFontSize = titleFontSize;
    self.titleLabel.font = KFontBold(titleFontSize);
    self.fontAppendHeight = 2;
}

- (void)setSubTitleBoldFontSize:(CGFloat)subTitleFontSize
{
    _subTitleFontSize = subTitleFontSize;
    self.subTitleLabel.font = KFontBold(subTitleFontSize);
    self.fontAppendHeight = 2;
}

-(void)setBIPostion:(NSInteger)postion cellType:(NSString *)cellType sellerid:(NSString *)sellerid
             shopid:(NSString *)shopid  patternType:(NSString*)patternType isMainTheme:(BOOL)isMainTheme
{
    self.postion  = postion;
    if (cellType && [cellType isEqualToString:@"cell.activity.theme"]) {
        self.page_type = @"activity";
    }else if (cellType &&[cellType isEqualToString:@"cell.seller.theme"]){
        self.page_type = @"seller";
    }else{
        self.page_type = @"home";
    }
    self.sellerid = sellerid;
    self.shopid   = shopid;
    self.pattern = patternType;
    self.isMainTheme = isMainTheme;
}

- (void)layoutSubviews
{
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = self.titleLeftCorner.x;
    titleFrame.size = [self.titleLabel sizeThatFits:CGSizeMake(self.width, self.height)];
    titleFrame.origin.y = self.titleLeftCorner.y;// + (self.titleFontSize - titleFrame.size.height) / 2;
    self.titleLabel.frame = titleFrame;
    
    titleFrame = self.subTitleLabel.frame;
    titleFrame.origin.x = self.titleLabel.left;
    titleFrame.size = [self.subTitleLabel sizeThatFits:CGSizeMake(self.width, self.height)];
    titleFrame.origin.y = self.titleLabel.bottom + self.subTitleTopPadding;
    self.subTitleLabel.frame = titleFrame;
    
    if (self.imageStyle == ExhibitImageExpandStyle) {
        self.imageView.frame = self.bounds;
    }else if (self.imageStyle == ExhibitImageRightStyle)
    {
        CGFloat theSide = self.height - 2 * 9;
        self.imageView.frame = CGRectMake(self.width - 9 - theSide, 9, theSide, theSide);
        CGFloat theInfoHeight = self.subTitleLabel.bottom - self.titleLabel.top;
        CGFloat fixYPos = (self.height - theInfoHeight) / 2;
        self.titleLabel.top = fixYPos;
        self.subTitleLabel.top = self.titleLabel.bottom + self.subTitleTopPadding;
        
    }else if (self.imageStyle == ExhibitImageBottomStyle)
    {
        CGFloat imgLength= 65 * DDDisplayScale;
        self.imageView.frame = CGRectMake(0, 0, imgLength, imgLength);
        self.imageView.centerX = CGRectGetMidX(self.bounds);
        self.imageView.bottom = self.height - 8 * DDDisplayScale;
    }
    
    if (self.tagView.hidden == NO) {
        CGSize tagSize = [self.tagView.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.tagView.frame = CGRectMake(self.titleLabel.right + 3, self.titleLabel.top - 7, tagSize.width + 10, tagSize.height + 5);
        self.tagView.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 3, 0);
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsLayout];
}

- (void)openImageURL
{
//    if (self.item) {
//        [[ActionHandler handlerWithAction:self.item.action] run];
//    }
}

@end
