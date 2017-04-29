//
//  OrderListSectionFooterView.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderListSectionFooterView.h"
#import "SubtotalView.h"
#import "ShopDiscountView.h"
#import "OrderListActionView.h"

@interface OrderListSectionFooterView()
@property (strong,nonatomic) SubtotalView *subtotalView;
@property (strong,nonatomic) ActionView *actionView;

@end
@implementation OrderListSectionFooterView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor grayColor]];
        _subtotalView = [SubtotalView defaultView];
        [self.contentView addSubview:_subtotalView];
        
        _actionView = [OrderListActionView defaultView];
        [self.contentView addSubview:_actionView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.actionView.bottom = self.height - 10;
    self.subtotalView.bottom = self.actionView.top;
}
+(CGFloat)getHeight
{
   return  46*2 + 10;
}
@end
