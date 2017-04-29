//
//  WTTableViewCell.h
//  PR
//
//  Created by 黄小雪 on 18/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTTableViewCell : UITableViewCell
@property (strong,nonatomic) id object;
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object;
-(void)doTarget;
@end
