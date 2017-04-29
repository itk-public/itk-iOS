//
//  SellerDescInfo.h
//  PR
//
//  Created by 黄小雪 on 15/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"
#import "ImageInfo.h"
#import "Action.h"

@interface ShopDescInfo : YHDataModel
//itkxxx-虹桥天街店
@property (readonly,nonatomic) NSString *title;
@property (readonly,nonatomic) ImageInfo *icon;
//itkxxx
@property (readonly,nonatomic) NSString *shopname;
@property (readonly,nonatomic) NSString *cid;
@property (readonly,nonatomic) NSString *cityname;
@property (readonly,nonatomic) Action   *action;
@end
