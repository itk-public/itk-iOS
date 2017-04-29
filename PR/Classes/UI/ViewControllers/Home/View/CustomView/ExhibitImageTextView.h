//
//  ExhibitImageTextView.h
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoImageView.h"
#import "DMExhibitItem.h"

typedef NS_ENUM(NSInteger,ExhibitImageStyle)
{
    ExhibitImageRightStyle,
    ExhibitImageBottomStyle,
    ExhibitImageExpandStyle,
};

@interface ExhibitImageTextView: UIView
@property(nonatomic,strong)AutoImageView * imageView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * subTitleLabel;
@property(nonatomic,assign)CGFloat titleFontSize;
@property(nonatomic,assign)CGFloat subTitleFontSize;
@property(nonatomic,assign)CGPoint titleLeftCorner;
@property(nonatomic,assign)CGFloat subTitleTopPadding;
@property(nonatomic,assign)ExhibitImageStyle imageStyle;
@property(nonatomic,strong)NSDictionary * biData;
@property(nonatomic,strong)UIButton * tagView;

- (void)updateWithExhibitItem:(DMExhibitItem *)item;

- (void)setTitleFontSize:(CGFloat)titleFontSize;
- (void)setSubTitleFontSize:(CGFloat)subTitleFontSize;

- (void)setTitleBoldFontSize:(CGFloat)titleFontSize;
- (void)setSubTitleBoldFontSize:(CGFloat)subTitleFontSize;
//用于埋点
-(void)setBIPostion:(NSInteger)postion cellType:(NSString *)cellType sellerid:(NSString *)sellerid
shopid:(NSString *)shopid  patternType:(NSString*)patternType isMainTheme:(BOOL)isMainTheme;
@end