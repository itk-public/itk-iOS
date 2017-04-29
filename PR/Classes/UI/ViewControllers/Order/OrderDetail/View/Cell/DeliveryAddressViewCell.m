//
//  DeliveryAddressViewCell.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "DeliveryAddressViewCell.h"
#define kRightMargin 15
#define kIconLabelW  45
@interface DeliveryAddressViewCell()
@property (strong,nonatomic) UILabel *iconLabel;
@property (strong,nonatomic) UILabel *receiverInfoLabel;
@property (strong,nonatomic) UILabel *addressLabel;
@end

@implementation DeliveryAddressViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_iconLabel];
        
        _receiverInfoLabel = [[UILabel alloc]init];
        [_receiverInfoLabel setText:@"收货人:王杰  13636336508"];
        [_receiverInfoLabel setTextColor:kColorGray];
        [_receiverInfoLabel setFont:KFontNormal(14)];
        [_receiverInfoLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_receiverInfoLabel];
        
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.numberOfLines = 2;
        [_addressLabel setTextAlignment:NSTextAlignmentLeft];
        [_addressLabel setTextColor:kColorGray];
        [_addressLabel setFont:KFontNormal(14)];
        [_addressLabel setText:@"收货地址:上海市普陀区真北路958号天地科技广场1号楼211shi科技广场1号楼211shi收货地址:上海市普陀区真北路958号天地科技广场1号楼211shi"];
        [self.contentView addSubview:_addressLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconLabel.frame = CGRectMake(0, 0, kIconLabelW, self.height);
    self.receiverInfoLabel.frame = CGRectMake(self.iconLabel.right, 10, self.width - kRightMargin - kIconLabelW, 21);
    self.addressLabel.frame      = CGRectMake(self.iconLabel.right, 0, self.receiverInfoLabel.width, [[self class]addressLabelHWithAddressString:self.addressLabel.text]);
    self.addressLabel.bottom     = self.height - 10;
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    if ([[self class]addressLabelHWithAddressString:nil] > 21) {
       return  80;
    }
    return 60;
}

+(CGFloat)addressLabelHWithAddressString:(NSString *)addressString
{
    addressString = @"收货地址:科技广场1号楼211shi收货地址:上海市普陀区真北路958号天地科技广场1号楼211shi科技广场1号楼211shi收货地址:上海市普陀区真北路958号天地科技广场1号楼211shi科技广场1号楼211shi收货地址:上海市普陀区真北路958号天地科技广场1号楼211shi";
    CONDITION_CHECK_RETURN_VAULE(addressString && [addressString length], 0);
    DeliveryAddressViewCell *cell = [[DeliveryAddressViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.addressLabel.text = addressString;
    UILabel *testLabel = [[UILabel alloc]init];
    testLabel.numberOfLines = 2;
    CGFloat height =  [cell.addressLabel sizeThatFits:CGSizeMake(ScreenWidth - kRightMargin - kIconLabelW, MAXFLOAT)].height;
    cell = nil;
    return height;
    
}
@end
