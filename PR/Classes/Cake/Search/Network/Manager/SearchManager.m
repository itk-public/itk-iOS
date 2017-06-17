//
//  SearchManager.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SearchManager.h"
#import "SearchAPIInteract.h"

@interface SearchManager()
@property (strong,nonatomic) SearchAPIInteract *searchAPI;
@end

@implementation SearchManager
-(void)searchSku
{
    if (self.searchAPI == nil) {
        self.searchAPI = [[SearchAPIInteract alloc]init];
    }
    [self.searchAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:error:)]) {
            [self.delegate loadDataFailed:self error:error];
        }
    }];
}
@end
