//
//  GoodsDetailPicturesInfoCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/6.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "GoodsDetailPicturesInfoCell.h"
#import "AutoImageView.h"
#import "AppUIUtil.h"
#import "OnePixelSepView.h"

@implementation GoodsDetailPicturesInfoModel

@end

#define kPromptTitleHeightValue 40
#define kDefaultImageWidth      320
#define kDefaultImageHeight     230

@interface GoodsDetailPicturesInfoCell()

@end

@implementation GoodsDetailPicturesInfoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle              = UITableViewCellSelectionStyleNone;
        
        UILabel * titleLabel       = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, APPLICATIONWIDTH, kPromptTitleHeightValue)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font            = KFontNormal(15);
        titleLabel.textColor       = UIColorFromRGB(0x333333);
        titleLabel.textAlignment   = NSTextAlignmentCenter;
        titleLabel.text            = @"图文详情";
        [self.contentView addSubview:titleLabel];
        
        OnePixelSepView * line = [[OnePixelSepView alloc] initWithFrame:CGRectMake(0, 0, APPLICATIONWIDTH, OnePoint)];
        line.lineColor         = UIColorFromRGB(0xececec);
        [self.contentView addSubview:line];
    }
    return self;
}

-(void)setObject:(id)object
{
    if (YES) {
        NSArray *allSubViews = self.contentView.subviews;
        for (UIView *aView in allSubViews) {
            if ([aView isKindOfClass:[AutoImageView class]]) {
                [aView removeFromSuperview];
            }
        }
        if (object && [object isKindOfClass:[GoodsDetailPicturesInfoModel class]]) {
            GoodsDetailPicturesInfoModel *tModel = (GoodsDetailPicturesInfoModel *)object;
            CGFloat y = kPromptTitleHeightValue;
            CGFloat defaultScale = kDefaultImageWidth/ScreenWidth;
            for (NSString *imgURL in tModel.pictureDetailUrlArr) {
                id aImageInfo = [tModel.pictureDetailImgDic safeObjectForKey:imgURL];
                CGFloat imageDisplayHeight = kDefaultImageHeight/defaultScale;
                UIImage *img = nil;
                if ([aImageInfo isKindOfClass:[UIImage class]]) {
                    img = (UIImage *)aImageInfo;
                    CGFloat scale = img.size.width/ScreenWidth;
                    imageDisplayHeight = img.size.height/scale;
                }
                
                AutoImageView *detailImgView = [[AutoImageView alloc]initWithFrame:CGRectMake(0, y, ScreenWidth, imageDisplayHeight)];
                detailImgView.backgroundColor = [UIColor clearColor];
                detailImgView.defaultImage = img?img:[UIImage imageNamed:@"default_product_detail_b"];
                detailImgView.contentMode = UIViewContentModeScaleAspectFill;
                [self.contentView addSubview:detailImgView];
                y += imageDisplayHeight;
            }
        }
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CGFloat height = kPromptTitleHeightValue;
    
    if (object && [object isKindOfClass:[GoodsDetailPicturesInfoModel class]]) {
        GoodsDetailPicturesInfoModel *tModel = (GoodsDetailPicturesInfoModel *)object;
        
        for (NSString *  imgURL in tModel.pictureDetailUrlArr) {
            id aImageInfo = [tModel.pictureDetailImgDic objectForKey:imgURL];
            if ([aImageInfo isKindOfClass:[NSNull class]]) {
                CGFloat defaultScale = kDefaultImageWidth/ScreenWidth;
                height += (kDefaultImageHeight /defaultScale);
            }else if ([aImageInfo isKindOfClass:[UIImage class]])
            {
                UIImage * img = (UIImage *)aImageInfo;
                CGFloat scale = img.size.width/ScreenWidth;
                CGFloat imageDisplayHeight = img.size.height / scale;
                height += imageDisplayHeight;
            }
        }
    }
    
    return height;
}

@end
