//
//  SeparateCell.m
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "SeparateCell.h"

@implementation SeparateModel
-(instancetype)init
{
    if (self = [super init]) {
        self.cellClass = [SeparateCell class];
        self.cellIdentifier = @"cellIdentifier";
    }
    return self;
}
@end

@implementation SeparateCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:kColorErrorViewBG];
    }
    return self;
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 10;
}
@end
