//
//  WTTableViewAdaptor.m
//  PR
//
//  Created by 黄小雪 on 18/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "WTTableViewAdaptor.h"

NSString * boltCellTypeKey = @"blotType";
NSString * boltCellAppendDataKey = @"boltAppend";

@implementation WTTableViewAdaptor
#pragma mark -thunder cell
-(CGFloat)thunderCellHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight      = 0;
    UITableView *tableView = self.tableView;
    id object              = [self objectForRowAtIndexPath:indexPath];
    Class cellClass        = [self cellClassForIndexPath:indexPath];
    rowHeight              = [cellClass tableView:tableView rowHeightForObject:object];
    return rowHeight;
}
-(NSString *)cellTypeAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellType  = nil;
    id<YHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    if (object) {
        cellType = [object cellType];
    }
    return cellType;
}
#pragma mark footer
-(UIView *)createFootView
{
    // foot
    UIView *footSpinnerView               = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    //显示下拉提示信息
    UILabel *displayTitle                 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    displayTitle.textColor                = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
    displayTitle.textAlignment            = NSTextAlignmentCenter;
    displayTitle.font                     = KFontNormal(15);
    displayTitle.backgroundColor          = [UIColor clearColor];
    [footSpinnerView insertSubview:displayTitle atIndex:1];

    // 显示Loading 图标
    CGSize size                           = [displayTitle sizeThatFits:displayTitle.bounds.size];
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame                    = CGRectMake((ScreenWidth - size.width) * 0.5 - 28,10, 20.0f, 20.0f);
    [footSpinnerView addSubview:activityView];
    [activityView startAnimating];
    
    return footSpinnerView;
}


#pragma mark --setter/getter
-(NSMutableArray *)items
{
    if(_items == nil){
        _items = [NSMutableArray array];
    }
    return _items;
}

-(NSInteger)numberOfRows
{
    return [self.items count];
}

-(NSInteger)numberOfSections
{
    return 1;
}
#pragma mark - facilities

-(Class)cellClassForObject:(id<YHTableViewCellItemProtocol>)object
{
    Class cellClass  = nil;
    if (object) {
        if ([object respondsToSelector:@selector(cellClass)]) {
            cellClass = [object cellClass];
        }
    }
    return cellClass;
}

- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath
{
    
    Class cellClass                        = nil;
    id<YHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    cellClass                              = [self cellClassForObject:object];
    return cellClass;
}

//获取indexpath位置上cell的数据模型
-(id)objectForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = nil;
    if ([self.items count] > indexPath.row) {
        object = [self.items safeObjectAtIndex:indexPath.row];
    }
    if ([object conformsToProtocol:@protocol(YHTableViewCellItemProtocol)] == NO) {
        NSAssert(false, @"你选择了使用CellType_THUNDR，就需要让数据实现 YHTableViewCellItemProtocol 协议");
    }
    return object;
}

-(NSString *)identifierForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;
    identifier           = [self cellTypeAtIndexPath:indexPath];
    return identifier;
}
- (UITableViewCell *)getThundeCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath *)indexPath
{
    id<YHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    NSString *identifier  = [self identifierForCellAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        //初始化cell
        cell = [self generateCellForObject:object indexPath:indexPath identifier:identifier];
    }else{
        //更新数据
        if ([cell isKindOfClass:[WTTableViewCell class]]) {
           [(WTTableViewCell *)cell setObject:(id)object];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:didSetObject:cell:)]) {
        [self.delegate tableView:tableView didSetObject:object cell:cell];
    }
    return cell;
}

-(WTTableViewCell *)generateCellForObject:(id<YHTableViewCellItemProtocol>)object indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier{
    WTTableViewCell *cell = nil;
    if (object) {
        Class cellClass = [self cellClassForObject:object];
        if (object.useNib == YES) {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
            cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        } else {
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setObject:(id)object];
    }
    return cell;
}


#pragma mark -UITableViewDataSoure
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfRows];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self numberOfSections];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getThundeCellForTableView:tableView indexPath:indexPath];
}

#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView == nil) {
        self.tableView = tableView;
    }
    return [self thunderCellHeightForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<YHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:didSelectObject:rowAtIndexPath:)]){
            [self.delegate tableView:tableView didSelectObject:object rowAtIndexPath:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.delegate tableView:self.tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.delegate tableView:self.tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.delegate tableView:self.tableView canEditRowAtIndexPath:indexPath];
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row + 1 == [self tableView:tableView numberOfRowsInSection:indexPath.section])
    {
        //加载到最后一行
        if (self.haveMoreData == NO || [self.delegate respondsToSelector:@selector(requestMoreData)] == NO)
        {
            [tableView.tableFooterView setHidden:YES];
            tableView.tableFooterView = nil;
            return;
        }
        else
        {
            [tableView.tableFooterView setHidden:NO];
            [self.delegate requestMoreData];
            if (nil == tableView.tableFooterView)
            {
                tableView.tableFooterView = [self createFootView];
            }
        }
    }
}


#pragma mark - scrollview delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(tableViewDidScrolled:)]) {
        [self.delegate tableViewDidScrolled:self.tableView];
    }
}

@end
