//
//  WTBrowseViewController.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "BaseViewController.h"

/*!
 * WT 是版本代号，Wheat
 @method
 @abstract      WTBorwseViewController，用来装载网页，并做响应处理
 */


@interface WTBrowseViewController : BaseViewController<UIWebViewDelegate>
@property (copy,nonatomic) NSString *urlString;
@property (copy,nonatomic) NSString *defaultTitle;
@property (nonatomic, getter = isNavBarHiden) BOOL navBarHiden;

/*!
 @method
 @abstract      根据传入的url地址初始化
 @param         url : url地址
 @return        instancetype
 */

-(instancetype)initWithURL:(NSString *)url;
@end

@interface WTBrowseViewController(InheritInterface)

- (NSUInteger)eventDispatcherConfig;
- (UIWebView *)frontMostWebView; // 获取当前使用的webview
- (UIView *)showErrorUnderView;
- (void)loadURL:(NSString *)url;

@end
