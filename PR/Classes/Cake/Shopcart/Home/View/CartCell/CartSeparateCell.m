//
//  CartSeparateCellTableViewCell.m
//  YHClouds
//
//  Created by 黄小雪 on 16/9/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartSeparateCell.h"


@implementation CartSeparateCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID                 = @"CartSeparateCell";
    CartSeparateCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:kVCViewBGColor];
        
    }
    
    return self;
}
+(CGFloat)getHeight
{
    return 10;
}
@end
