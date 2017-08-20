//
//  SearchManager.h
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchManager;

@protocol SearchManagerDelegate <NSObject>
@required
-(void)loadDataSuccessful:(SearchManager *)manager  data:(id)data  isCache:(BOOL)isCache;

-(void)loadDataFailed:(SearchManager *)manager error:(NSError*)error;
@end

@interface SearchManager : NSObject
@property (weak,nonatomic) id<SearchManagerDelegate> delegate;
-(void)searchSku;

-(void)farmSearch;
@end
