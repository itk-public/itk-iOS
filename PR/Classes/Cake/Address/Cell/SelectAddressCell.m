//
//  SelectAddressCell.m
//  PR
//
//  Created by 黄小雪 on 2017/5/16.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SelectAddressCell.h"
#import "SecretPhoneLabel.h"
#import "AddressModel.h"

#define kEditBtnW   50
#define kLeftMargin 15
#define kAddressLabelW (ScreenWidth - kLeftMargin - kEditBtnW)
@interface SelectAddressCell()
@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) UILabel *addressLabel;
@property (strong,nonatomic) SecretPhoneLabel *phoneLabel;
@property (strong,nonatomic) UIButton *editBtn;
@property (strong,nonatomic) AddressModel *addressModel;
@end

@implementation SelectAddressCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addNameLabel];
        [self addAddressLabel];
        [self addPhoneLabel];
        [self addEditBtn];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat kTopMargin = 10;
    [self.nameLabel sizeToFit];
    self.nameLabel.frame = CGRectMake(kLeftMargin, kTopMargin,self.nameLabel.width, self.nameLabel.height);
    [self.phoneLabel sizeToFit];
    self.phoneLabel.frame = CGRectMake(self.nameLabel.right + 70, self.nameLabel.top, self.phoneLabel.width, self.phoneLabel.height);
    
    NSDictionary *tempDict = [[self class]getAddressLabelH:self.addressModel];
    self.addressLabel.frame = CGRectMake(self.nameLabel.left, 0 ,kAddressLabelW, [[tempDict safeObjectForKey:@"tempHeight"] floatValue]);
    self.addressLabel.bottom = self.height - kTopMargin;
    self.editBtn.frame = CGRectMake(self.width - kEditBtnW, 0, kEditBtnW, self.height);
}


#pragma mark private add
-(void)addNameLabel
{
    _nameLabel = [[UILabel alloc]init];
    [_nameLabel setTextColor:UIColorFromRGB(0x4c4c4c)];
    [_nameLabel setFont:KFontNormal(15)];
    [_nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_nameLabel];
}

-(void)addPhoneLabel
{
    _phoneLabel = [[SecretPhoneLabel alloc]init];
    [_phoneLabel setTextColor:UIColorFromRGB(0x4c4c4c)];
    [_phoneLabel setFont:KFontNormal(15)];
    [_phoneLabel setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_phoneLabel];
}

-(void)addEditBtn
{
    _editBtn = [[UIButton alloc]init];
    [_editBtn setBackgroundColor:[UIColor redColor]];
    [_editBtn addTarget:self action:@selector(editBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.contentView addSubview:_editBtn];
}

-(void)addAddressLabel
{
    _addressLabel = [[UILabel alloc]init];
    [_addressLabel setTextAlignment:NSTextAlignmentLeft];
    _addressLabel.numberOfLines = 2;
    [_addressLabel setFont:KFontNormal(15)];
    [_addressLabel setTextColor:UIColorFromRGB(0x4c4c4c)];
    [self.contentView addSubview:_addressLabel];
}

+(NSDictionary *)getAddressLabelH:(AddressModel *)address
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:[address.address addressDesc]];
    NSMutableParagraphStyle *paragraphStype     = [[NSMutableParagraphStyle alloc]init];
    paragraphStype.lineSpacing      = 5;
    paragraphStype.alignment        = NSTextAlignmentLeft;
    [attributedString addAttributes:@{NSFontAttributeName:KFontNormal(15),NSParagraphStyleAttributeName:paragraphStype} range:NSMakeRange(0, attributedString.length)];
    CGRect tempRect
    =[attributedString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading context:nil];
    CGFloat titleH = tempRect.size.height;
    CGFloat tempW = tempRect.size.width;
    CGFloat tempW2 = kAddressLabelW;
    if (tempW > tempW2) {
        titleH = 2*tempRect.size.height + 5;
    }
    return @{@"tempHeight":@(titleH),@"attributedString":attributedString};
}

#pragma mark 编辑地址
-(void)editBtnOnClick
{
    PRLOG(@"点击编辑");
}

#pragma mark super method
+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CONDITION_CHECK_RETURN_VAULE([object isKindOfClass:[AddressModel class]], 0);
    NSDictionary *tempDict = [[self class]getAddressLabelH:(AddressModel *)object];
    return 46 + [[tempDict safeObjectForKey:@"tempHeight"] floatValue];
}

-(void)setObject:(id)object
{
    CONDITION_CHECK_RETURN([object isKindOfClass:[AddressModel class]]);
    _addressModel = object;
    self.nameLabel.text = _addressModel.name?:@"";
    self.phoneLabel.text = _addressModel.phone?:@"";
    NSDictionary *tempDict = [[self class]getAddressLabelH:_addressModel];
    self.addressLabel.attributedText = [tempDict safeObjectForKey:@"attributedString"];
}
@end
