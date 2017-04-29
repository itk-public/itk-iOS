//
//  OrderDetailActionViewCell.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderDetailActionViewCell.h"
#import "ActionView.h"

@interface OrderDetailActionViewCell()
@property (strong,nonatomic) ActionView *actionView;

@end
@implementation OrderDetailActionViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _actionView = [ActionView defaultView];
        [self.contentView addSubview:_actionView];
    }
    return self;
}
@end
