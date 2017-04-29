//
//  ImageInfo.m
//  PR
//
//  Created by 黄小雪 on 21/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ImageInfo.h"
#import "Action.h"
#import "UtilCodeTool.h"

@implementation ImageInfo
FUNCTION_NSCODINGIMP_WITHCLAZZ([ImageInfo class]);

+(id)imageInfoWithDic:(NSDictionary*)dic
{
    if (!dic) {
        return nil;
    }
    ImageInfo * img = [[ImageInfo alloc] initWithDic:dic];
    return img;
}

-(id)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self && [dic isKindOfClass:[NSDictionary class]])
    {
        _imgUrl = [[[dic safeObjectForKey:@"url"] description] copy];
        
        NSDictionary * sizeDict = [dic safeObjectForKey:@"size"];
        if (sizeDict && [[sizeDict allKeys] count] > 0)
        {
            _width = [[sizeDict safeObjectForKey:@"w"] doubleValue];
            _height = [[sizeDict safeObjectForKey:@"h"] doubleValue];
        }
        NSDictionary * actionDict = [dic safeObjectForKey:@"action"];
        if (actionDict)
        {
            _imageAction = [Action actionWithDic:actionDict];
        }
    }
    return self;
}

+ (instancetype)imageInfoWithImageURL:(NSString *)imgURL action:(Action *)action
{
    ImageInfo * img = [[ImageInfo alloc] initWithImageURL:imgURL];
    img->_imageAction = action;
    return img;
    
}

- (instancetype)initWithImageURL:(NSString *)imgURL
{
    self = [super init];
    if (self)
    {
        _imgUrl = imgURL;
    }
    return self;
}
@end
