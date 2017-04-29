//
//  AgreementProtocolView.m
//  PR
//
//  Created by 黄小雪 on 12/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "AgreementProtocolView.h"
#import "PRShowToastUtil.h"

@interface TestBtn:UIButton

@end

@implementation TestBtn
-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self setBackgroundColor:kColorTheme];
    }else{
        [self setBackgroundColor:kColorGray];
    }
}
@end


@interface AgreementProtocolView()

@property (strong,nonatomic) UIButton *protocolBtn;
@property (strong,nonatomic) TestBtn  *seletedBtn;
@property (strong,nonatomic) UILabel  *promptLab;

@end
@implementation AgreementProtocolView
-(instancetype)init{
    if (self = [super init]) {
        _seletedBtn = [TestBtn buttonWithType:UIButtonTypeSystem];
        [_seletedBtn addTarget:self action:@selector(seletedBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _seletedBtn.selected = YES;
        [self addSubview:_seletedBtn];
        
        _promptLab = [[UILabel alloc]init];
        [_promptLab setText:@"同意"];
        [_promptLab setTextColor:kColorNormal];
        [_promptLab setFont:KFontNormal(12)];
        [self addSubview:_promptLab];
       
        _protocolBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_protocolBtn setTitle:@"《xxxxxx服务协议》" forState: UIControlStateNormal];
        [_protocolBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
        _protocolBtn.titleLabel.font = KFontNormal(12);
        [_protocolBtn addTarget:self action:@selector(protocolBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_protocolBtn];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat seletedBtnW = 40;
    self.seletedBtn.frame = CGRectMake(0, 0, seletedBtnW, self.height);
    
    CGFloat promptLabW  = [self.promptLab sizeThatFits:CGSizeMake(MAXFLOAT, self.height)].width;
    self.promptLab.frame = CGRectMake(self.seletedBtn.right, 0, promptLabW, self.height);
    
    CGFloat protocolBtnW = [self.protocolBtn.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.height)].width;
    self.protocolBtn.frame = CGRectMake(self.promptLab.right, 0, protocolBtnW, self.height);
    
}

#pragma mark 按钮事件
-(void)seletedBtnOnClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

-(void)protocolBtnOnClicked
{
    PRLOG(@"点击查看xxxxxxx协议");
}

-(BOOL)isSeletedProtocol
{
    if (self.seletedBtn.selected == NO) {
        [PRShowToastUtil showNotice:@"请同意xxxx服务协议"];
    }
    return self.seletedBtn.selected;
}

@end
