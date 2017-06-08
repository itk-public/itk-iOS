//
//  EvaluteViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "GoodDetailEvaluteViewCell.h"
#import "OnePixelSepView.h"
#import "SoyScoreView.h"
#import "GoodDetailModel.h"

@interface GoodDetailEvaluteViewCell()
@property (nonatomic, strong ) SoyScoreView * reviewStarShowView;
@property (nonatomic, strong ) UILabel      * evaluationUserName;
@property (nonatomic, strong ) UILabel      * evalustionStartDate;
@property (nonatomic, strong ) UILabel      * reviewScriptContent;
@end

@implementation GoodDetailEvaluteViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor  = [UIColor whiteColor];
        self.selectionStyle               = UITableViewCellSelectionStyleNone;
        UIView *lineViewTwo                = [[UIView alloc]initWithFrame:CGRectMake(0, 37*DDDisplayScale, APPLICATIONWIDTH, OnePoint)];
        lineViewTwo.backgroundColor        = UIColorFromRGB(0xdddddd);
        [self addSubview:lineViewTwo];
        _evaluationUserName                = [[UILabel alloc]initWithFrame:CGRectMake(15*DDDisplayScale, 11*DDDisplayScale, 110, 16.5)];
        _evaluationUserName.font           = KFontNormal(16);
        _evaluationUserName.textAlignment  = NSTextAlignmentLeft;
        [self addSubview:_evaluationUserName];
        _evalustionStartDate               = [[UILabel alloc]initWithFrame:CGRectMake(_evaluationUserName.right+5*DDDisplayScale, 11*DDDisplayScale, APPLICATIONWIDTH-162, 16.5)];
        _evalustionStartDate.font          = KFontNormal(12);
        _evalustionStartDate.textColor     = UIColorFromRGB(0x999999);
        _evalustionStartDate.textAlignment = NSTextAlignmentRight;
        UIImageView *jumpImage = [[UIImageView alloc]initWithFrame:CGRectMake(_evalustionStartDate.right+7, 14*DDDisplayScale, 7, 11)];
        jumpImage.image = [UIImage imageNamed:@"icon_arrow_right"];
        [self addSubview:jumpImage];
        [self addSubview:_evalustionStartDate];
        _reviewStarShowView                = [[SoyScoreView alloc]initWithFrame:CGRectMake(_evaluationUserName.frame.origin.x, lineViewTwo.bottom+10, 130, 16) setStarWidth:14 margin:5];
        [self addSubview:_reviewStarShowView];
        _reviewScriptContent               = [[UILabel alloc]init];
        _reviewScriptContent.font          = KFontNormal(13);
        _reviewScriptContent.textColor     = UIColorFromRGB(0x111111);
        _reviewScriptContent.numberOfLines = 0;
        _reviewScriptContent.textAlignment = 0;
        _reviewScriptContent.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_reviewScriptContent];
        
    }
    return self;
}

- (void)setObject:(NSObject *)object
{
    if (object && [object isKindOfClass:[GoodDetailModel class]]) {
        GoodDetailModel *tModel       = (GoodDetailModel *)object;
        if (tModel.evaluateTotalNum) {
            NSMutableAttributedString * attrStr  = [[NSMutableAttributedString alloc] init];
            [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"商品评价" attributes:ATTR_DICTIONARY(UIColorFromRGB(0x111111), KFontNormal(16))]];
            [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%zd)",tModel.evaluateTotalNum] attributes:ATTR_DICTIONARY(UIColorFromRGB(0x111111), KFontNormal(13))]];
            _evaluationUserName .attributedText  = attrStr;
        }else{
            _evaluationUserName.text             = @"商品评价";
        }
        if (tModel.favorableRate) {
            NSMutableAttributedString * attrStr  = [[NSMutableAttributedString alloc] init];
            [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"好评率" attributes:ATTR_DICTIONARY(UIColorFromRGB(0x666666), KFontNormal(13))]];
            [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:tModel.favorableRate attributes:ATTR_DICTIONARY(UIColorFromRGB(0xff3300), KFontNormal(13))]];
            _evalustionStartDate .attributedText = attrStr;
            
        }else{
            _evalustionStartDate.text = @"";
        }
        [_reviewStarShowView setScore:tModel.evaluate.score];
        _reviewScriptContent.text            = tModel.evaluate.content?:@"";
        NSMutableParagraphStyle *paragraph   = [[NSMutableParagraphStyle alloc]init];
        paragraph.alignment = NSLineBreakByCharWrapping;
        NSDictionary *attributes             = @{NSFontAttributeName:KFontBold(13),NSParagraphStyleAttributeName:paragraph};
        CGSize maximumLabelSize              = CGSizeMake(APPLICATIONWIDTH, CGFLOAT_MAX);
        CGSize expectSize                    = [tModel.evaluate.content boundingRectWithSize:maximumLabelSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        _reviewScriptContent.frame           = CGRectMake(_evaluationUserName.frame.origin.x, _reviewStarShowView.bottom+8 , APPLICATIONWIDTH-30, expectSize.height);
        
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[GoodDetailModel class]], 0);
    CGFloat height = 90*DDDisplayScale;
    if (object && [object isKindOfClass:[GoodDetailModel class]]) {
        GoodDetailModel *tModel      = (GoodDetailModel *)object;
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.alignment = NSLineBreakByCharWrapping;
        NSDictionary *attributes           = @{NSFontAttributeName:KFontBold(13),NSParagraphStyleAttributeName:paragraph};
        CGSize maximumLabelSize            = CGSizeMake(APPLICATIONWIDTH, CGFLOAT_MAX);
        CGSize expectSize                  = [tModel.evaluate.content boundingRectWithSize:maximumLabelSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        height += expectSize.height;
        return height;
    }
    return height;
}
@end
