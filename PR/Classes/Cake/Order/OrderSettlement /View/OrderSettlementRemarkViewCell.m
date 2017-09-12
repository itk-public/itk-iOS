//
//  OrderSettlementRemarkViewCell.m
//  PR
//
//  Created by 黄小雪 on 2017/8/21.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderSettlementRemarkViewCell.h"

@implementation OrderSettlementRemarkViewCellModel

@end


@interface OrderSettlementRemarkViewCell()
@property (strong,nonatomic) UILabel     *promptLabel;
@property (strong,nonatomic) UITextField *contentTf;
@property (strong,nonatomic) UIView      *containerView;
@end

@implementation OrderSettlementRemarkViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:UIColorFromRGB(0xf3f4f5)];
        
        _containerView = [[UIView alloc]init];
        [_containerView setBackgroundColor:[UIColor whiteColor]];
        _containerView.layer.borderColor = [UIColor whiteColor].CGColor;
        _containerView.layer.borderWidth = OnePoint;
        _containerView.layer.cornerRadius = 4.0;
        [self.contentView addSubview:_containerView];
        
        _promptLabel = [[UILabel alloc]init];
        [_promptLabel setText:@"备注"];
        [_promptLabel setTextAlignment:NSTextAlignmentLeft];
        [_promptLabel setFont:KFontNormal(14)];
        [_promptLabel setTextColor:UIColorFromRGB(0x000000)];
        [self.containerView addSubview:_promptLabel];
        
        _contentTf = [[UITextField alloc]init];
        [_contentTf setPlaceholder:@"请输入备注(最多30个字符)"];
        [_contentTf setTextColor:UIColorFromRGB(0x000000)];
        [_contentTf setFont:KFontNormal(14)];
        [_contentTf setTextAlignment:NSTextAlignmentLeft];
        [self.containerView addSubview:_contentTf];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kContainerViewLeftMargin = 5;
    self.containerView.frame = CGRectMake(kContainerViewLeftMargin, 0, self.width - 2*kContainerViewLeftMargin, self.height);
    
    CGFloat kPromptLabelLeftMargin   = 10;
    [self.promptLabel sizeToFit];
    self.promptLabel.frame = CGRectMake(kPromptLabelLeftMargin,0,self.promptLabel.width , self.height);
    
    CGFloat kContentTfLeftMargin     = 78;
    self.contentTf.frame             = CGRectMake(kContentTfLeftMargin, 0, self.containerView.width - kContentTfLeftMargin - 15, self.height);
}
@end
