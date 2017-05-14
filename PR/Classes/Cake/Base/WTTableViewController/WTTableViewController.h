//
//  WTTableViewController.h
//  PR
//
//  Created by 黄小雪 on 18/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "AsynDataLoadViewController.h"
#import "WTTableViewAdaptor.h"

#import "BaseViewController.h"

@interface WTTableViewController : BaseViewController<WTTableViewAdaptorDelegate,WTTableViewCellConfig>

@property (nonatomic, strong) UITableView        * tableView;
@property (nonatomic, strong) WTTableViewAdaptor * tableViewAdaptor;
//构造数据
- (void)constructData;
@end
