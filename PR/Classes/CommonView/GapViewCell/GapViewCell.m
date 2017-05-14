//
//  GapViewCell.m
//  PR
//
//  Created by 黄小雪 on 14/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "GapViewCell.h"

@implementation GapViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor grayColor]];
    }
    return self;
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 10;
}
@end
