//
//  DMExhibitItem.h
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"
#import "ImageInfo.h"
#import "Action.h"

@interface DMExhibitItem : YHDataModel
@property (readonly,nonatomic) NSString  *cid;
@property (readonly,nonatomic) NSString  *title;
@property (readonly,nonatomic) NSString  *subTitle;
@property (readonly,nonatomic) ImageInfo *imgInfo;
@property (readonly,nonatomic) Action    *action;
@end
