//
//  CartSeparateCellTableViewCell.m
//  YHClouds
//
//  Created by 黄小雪 on 16/9/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartSeparateCell.h"


@implementation CartSeparateCell


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
