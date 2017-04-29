//
//  DMExhibitItem.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "DMExhibitItem.h"
#import "UtilCodeTool.h"

@implementation DMExhibitItem

FUNCTION_NSCODINGIMP_WITHCLAZZ([DMExhibitItem class])

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _cid= [dic safeObjectForKey:@"id" hintClass:[NSString class]];
        _title = [dic safeObjectForKey:@"title" hintClass:[NSString class]];
        if (nil == _title) {
            _title = [dic safeObjectForKey:@"content" hintClass:[NSString class]];
        }
        if (nil == _title) {
            _title = [dic safeObjectForKey:@"name" hintClass:[NSString class]];
        }
        
        _subTitle = [dic safeObjectForKey:@"subtitle" hintClass:[NSString class]];
        if (nil == _subTitle) {
            _subTitle = [dic safeObjectForKey:@"subname" hintClass:[NSString class]];
        }
        
        NSString * actionStr = [dic safeObjectForKey:@"action" hintClass:[NSString class]];
        if (actionStr) {
            _action = [Action actionWithString:actionStr];
        }
        
        NSString * imgURL = [dic safeObjectForKey:@"imgurl" hintClass:[NSString class]];
        if (nil == imgURL) {
            imgURL = [dic safeObjectForKey:@"icon" hintClass:[NSString class]];
        }
        if (imgURL) {
            _imgInfo = [ImageInfo imageInfoWithImageURL:imgURL action:self.action];
        }
    }
    return self;
}

@end
