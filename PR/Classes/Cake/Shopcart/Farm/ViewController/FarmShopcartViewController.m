//
//  ShopcartViewController.m
//  YHClouds
//
//  Created by 黄小雪 on 2017/4/26.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "FarmShopcartViewController.h"
#import "ShopcartTableViewProxy.h"
#import "ShopcartFormat.h"
#import "PRLoadingAnimation.h"
#import "PRMBWantedOffice.h"
#import "ShopCartTableFooterView.h"
#import "ShopCartTableHeaderView.h"
#import "FarmCartViewCell.h"

@interface FarmShopcartViewController ()<ShopcartFormatDelegate,AsynDataLoadInterface>

@property (strong,nonatomic) UITableView                  *shopcartTableView;
//tableView的代理
@property (strong,nonatomic) ShopcartTableViewProxy       *shopcartTableViewProxy;
//负责购物车逻辑处理
@property (strong,nonatomic) ShopcartFormat               *shopcartFormat;
@property (strong,nonatomic ) CartTableViewDataSource     *cartDataSoure;
@property (strong,nonatomic)  NSString                    *identifier;
@property (assign,nonatomic)  CGFloat                      tableViewOffY;
@property (strong,nonatomic) ShopCartTableFooterView      *footerView;
@property (strong,nonatomic) ShopCartTableHeaderView      *headerView;

@end

@implementation FarmShopcartViewController
@synthesize cartDataSoure = cartDataSoure;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
     [super viewDidLoad];
    self.navTitle = @"购物车";
    [self shopcartTableView];
   
    [self addRightBtn];
    // 设置允许摇一摇功能
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 并让自己成为第一响应者
    [self becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.shopcartTableView.height = self.view.height - [ShopCartTableFooterView height];
    self.footerView.frame         = CGRectMake(0, self.shopcartTableView.bottom, self.view.width, [ShopCartTableFooterView height]);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    if(self.shopcartTableView.scrollEnabled){
        [self setWaittingStatus:YES];
    }
    [self requestShopcartListData];
    self.headerView.height = [self.headerView height];
    [self.headerView update];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)requestShopcartListData{
    [self.shopcartFormat requestShopcartProductList];
}


#pragma mark 懒加载
-(UITableView *)shopcartTableView
{
    if(_shopcartTableView == nil){
        _shopcartTableView  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
       _shopcartTableView.separatorStyle     = UITableViewCellSeparatorStyleNone;
        _shopcartTableView.delegate             = self.shopcartTableViewProxy;
        _shopcartTableView.dataSource           = self.shopcartTableViewProxy;
        _shopcartTableView.showsVerticalScrollIndicator = NO;
        [_shopcartTableView setBackgroundColor:kVCViewBGColor];
        
        _headerView   = [[ShopCartTableHeaderView alloc]init];
        _headerView.frame         = CGRectMake(0, 0, 0, [self.headerView height]);
        [_shopcartTableView setTableHeaderView:_headerView];
        [self.view addSubview:_shopcartTableView];
        [_headerView update];
    }
    return _shopcartTableView;
}

-(ShopCartTableFooterView *)footerView
{
    __weak typeof(self)weakSelf = self;
    if (_footerView == nil) {
        _footerView = [[ShopCartTableFooterView alloc]init];
        _footerView.selectBtnBlock = ^(BOOL isSelected){
            [weakSelf.shopcartFormat selectAllSeller:isSelected];
        };
        _footerView.commitBtnBlock = ^{
            [weakSelf.shopcartFormat commitSelectdProducts];
        };
        [self.view addSubview:_footerView];
    }
    return _footerView;
}
-(ShopcartTableViewProxy *)shopcartTableViewProxy
{
    if (_shopcartTableViewProxy == nil) {
        _shopcartTableViewProxy = [[ShopcartTableViewProxy alloc]init];
        _shopcartTableViewProxy.mainCellName = NSStringFromClass([FarmCartViewCell class]);
        
        __weak typeof(self)weakSelf = self;
        _shopcartTableViewProxy.shopcartProxyProductSelectBlock = ^(BOOL isSelected,NSIndexPath *indexPath){
            [weakSelf.shopcartFormat selectProductAtIndexPath:indexPath isSelected:isSelected];
        };
        
        _shopcartTableViewProxy.shopcartProxySellerSelectBlock = ^(BOOL isSelected,NSInteger section){
            [weakSelf.shopcartFormat selectSellerAtSection:section isSelected:isSelected];
        };
        
        _shopcartTableViewProxy.shopcartProxyChangeCountBlock = ^(NSInteger count,NSIndexPath *indexPath){
            [weakSelf.shopcartFormat changeCountAtIndexPath:indexPath count:count];
        };
        
        _shopcartTableViewProxy.shopcartProxyDeleteBlock = ^(NSIndexPath *indexPath){
            [weakSelf.shopcartFormat deleteProductAtIndexPath:indexPath];
        };
        
        _shopcartTableViewProxy.shopcartProxySellerEditBlock = ^(ShopcartEditType editType,NSInteger section){
            [weakSelf.shopcartFormat editSellerAtSection:section editType:editType];
        };
        _shopcartTableViewProxy.shopcartProxyDeleteSellerProductBlock = ^(NSInteger section){
            [weakSelf.shopcartFormat deleteSellerProductAtSection:section];
        };
        
        _shopcartTableViewProxy.shopcartProxyProductBeginEditBlock = ^(UITextField *textfiled){
            [weakSelf keyBoardShow:textfiled];
        };
    }
    return _shopcartTableViewProxy;
}


-(ShopcartFormat *)shopcartFormat
{
    if (_shopcartFormat == nil) {
        _shopcartFormat = [[ShopcartFormat alloc]init];
        _shopcartFormat.delegate = self;
        __weak typeof(self)weakSelf = self;
        _shopcartFormat.reloadTableViewBlock = ^{
            [weakSelf.footerView updateWithCartTableViewDataSource:weakSelf.cartDataSoure];
            [weakSelf.shopcartTableView reloadData];
        };
    }
    return _shopcartFormat;
}


#pragma mark super方法

- (void)doInstanceInit
{
    self.configer = self;
}

- (id)initWithQuery:(NSDictionary *)query
{
    
    if (self = [super initWithQuery:query]) {
        [self doInstanceInit];
        self.identifier = [query safeObjectForKey:@"name" hintClass:[NSString class]];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self doInstanceInit];
    }
    return self;
}

-(void)back{
    [super back];
}

#pragma mark -  AsynDataLoadInterface
- (void)actualReqData:(DataRefreshOption)refeshOption
{
    if (refeshOption == DataRefreshOption_Enter ||
        refeshOption == DataRefreshOption_UserActive ||
        refeshOption == DataRefreshOption_AppToForeground) {
//        [self.cartDataSoure setUnEidt];
    }
    [self requestShopcartListData];
}

- (DataRefreshOption)refreshOption
{
    return  /*DataRefreshOption_Enter |*/
    DataRefreshOption_UserActive |
    DataRefreshOption_AppToForeground;
}

- (LoadingUIType)loadingRefreshUIType
{
    return LoadingUIType_Cover;
}

- (UIScrollView *)pullRefreshScrollView
{
    return self.shopcartTableView;
}

- (NSTimeInterval)intervalForBackView
{
    return 0;
}

- (NSTimeInterval)intervalForLoadingAfterDelay
{
    return 0;
}

- (BOOL)couldShowCoverPromptView
{
    if ([self.cartDataSoure.sellerList.sellerArray count]) {
        return NO;
    }
    return YES;
}

#pragma mark private method
-(void)rightBtnOnClicked:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    ShopcartEditType editType = sender.selected ?ShopcartEditTypeAll:ShopcartEditTypeNone;
    [self.shopcartFormat updateAllSellerEditType:editType];
    self.cartDataSoure.editType = editType;
    [self.footerView updateWithCartTableViewDataSource:self.cartDataSoure];
}

-(void)addRightBtn
{
    UIButton *rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 40, 40);
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -30)];
    [rightBtn addTarget:self action:@selector(rightBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateSelected];
    [rightBtn setTitleColor:UIColorFromRGB(0x4c4c4c) forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:KFontNormal(16)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}


-(void)keyBoardShow:(UITextField *)textFiled
{
    UIWindow *keyWindow  = [[UIApplication sharedApplication] keyWindow];
    CGFloat offY         = self.shopcartTableView.contentOffset.y;
    self.tableViewOffY   = offY;
    CGRect tfInTableView = [textFiled.superview convertRect:textFiled.frame toView:keyWindow];
    CGFloat  tfy         = ScreenHeight - 267;
    if (tfInTableView.origin.y + textFiled.height > tfy) {
        [self.shopcartTableView  setContentOffset:CGPointMake(0, offY + (tfInTableView.origin.y + textFiled.height - tfy)) animated:YES];
    }
}

-(void)keyBoardHide{
    [self.shopcartTableView  setContentOffset:CGPointMake(0, self.tableViewOffY) animated:YES];
}



#pragma mark ShopcartFormatDelegate
-(void)loadDataSuccessful:(ShopcartFormat *)shopcartFormat dataType:(ShopcartFormatDataType)dataType  data:(id)data extraInfo:(NSDictionary *)extraInfo
{
    [[PRLoadingAnimation sharedInstance] removeLoadingAnimation:self.view];
//    [self asynDataArrived];
//    if (dataType == ShopcartFormatDataTypeFreshen) { //刷新购物车
        self.cartDataSoure  = data;
        self.shopcartTableViewProxy.cartDataSoure = data;
        [self.shopcartTableView reloadData];
       [self.footerView updateWithCartTableViewDataSource:self.cartDataSoure];
//    }else if([data isKindOfClass:[OrderDetail class]]){
//        CKConfirmOrderViewController * confirmVC = [[CKConfirmOrderViewController alloc] init];
//        confirmVC.orderToCheck                   = data;
//        confirmVC.storeid                        = [extraInfo safeObjectForKey:kToCommitStoridKey]?:@"";
//        confirmVC.sellerid                       = [extraInfo safeObjectForKey:kToCommitSelleridKey]?:@"";
//        [[SceneMananger shareMananger] showViewController:confirmVC withStyle:U_SCENE_SHOW_PUSH];
//    }
}

-(void)loadDataFailed:(ShopcartFormat *)shopcartFormat dataType:(ShopcartFormatDataType)dataType error:(NSError*)error
{
//    if (dataType == ShopcartFormatDataTypeFreshen) { //刷新购物车
//        [[PRLoadingAnimation sharedInstance] removeLoadingAnimation:self.view];
//        [super reqDataError:error];
//    }else{
//        [YHShowToastUtil showNotice:[ErrorHandler errorDescForError:error] inView:self.view];
//        UIViewController *currentVC = [[SceneMananger shareMananger]currentViewController];
//        [ErrorHandler error:error viewController:currentVC requestNeedLogin:YES];
//    }
}
@end
