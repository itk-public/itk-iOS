//
//  WTTableViewAdaptor.h
//  PR
//
//  Created by 黄小雪 on 18/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHTableViewCellItemProtocol.h"
#import "WTTableViewCell.h"

typedef NS_ENUM(NSInteger,CellType)
{
    CellType_THUNDR,
    CellType_BOLT,
};

FOUNDATION_EXTERN NSString * boltCellTypeKey;
FOUNDATION_EXTERN NSString * boltCellAppendDataKey;

@protocol WTTableViewCellConfig  <NSObject>
@optional
- (CellType)cellTypeForIndex:(NSInteger)dataIndex;
- (NSInteger)boltCellTypeForIndex:(NSInteger)dataIndex;
- (void)configCellMSignal:(UIView *)boltView forIndex:(NSInteger)dataIndex;
@end

@protocol WTTableViewAdaptorDelegate;
/*!
 @class
 @abstract      该类处理tableview适配工作
 @discussion    处理plain类型的tableview相关适配工作,使用的时候需要将tableview的datasource和delegate设置成本类的实例对象
 */
@interface WTTableViewAdaptor : NSObject<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>

@property (weak,nonatomic) UITableView *tableView;
@property (weak,nonatomic) id<WTTableViewAdaptorDelegate> delegate;

//cell 显示所需数据数组,其中每个数据模型都必须实现YHTableViewCellItemProtocol协议
@property (nonatomic, retain) NSMutableArray        * items;
@property (nonatomic, assign) BOOL                    haveMoreData;
@property (nonatomic, weak) id<WTTableViewCellConfig> cellConfiger;


/*!
 @method
 @abstract  生成一个新的cell
 @param     object : cell显示所需的数据模型
 @param     indexPath : cell 的indexpath
 @param     identifier : cell 的重用标识
 @return    返回WTTableViewCell类型的cell
 */
- (WTTableViewCell *)generateCellForObject:(id<YHTableViewCellItemProtocol>)object indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier;
@end

@protocol WTTableViewAdaptorDelegate <NSObject>
@optional
/*!
 @method
 @abstract  处理tableview cell选中事件
 @param     tableView : tableview
 @param     object : 选中的cell对用的数据模型
 @param     indexPath : 被选中的cell的indexpath
 @return    void
 */

-(void)tableView:(UITableView *)tableView  didSelectObject:(id<YHTableViewCellItemProtocol>)object
       rowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didSetObject:(id<YHTableViewCellItemProtocol>)object cell:(UITableViewCell *)cell;

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)requestMoreData;

- (void)tableViewDidScrolled:(UITableView *)tableView;

@end
