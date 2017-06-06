//
//  CategoryMananger.h
//  PR
//
//  Created by 黄小雪 on 2017/6/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CategoryMananger;

typedef NS_ENUM(NSInteger,CategoryManangerType)
{
    CategoryManangerTypeShopCategory = 0,
    CategoryManangerTypeCategorySku,
    
};

@protocol CategoryManangerDelegate <NSObject>
@required
-(void)loadDataSuccessful:(CategoryMananger *)cartShopApi dataType:(CategoryManangerType)dataType  data:(id)data  isCache:(BOOL)isCache;

-(void)loadDataFailed:(CategoryMananger *)cartShopApi dataType:(CategoryManangerType)dataType error:(NSError*)error;
@end

@interface CategoryMananger : NSObject
@property (weak,nonatomic) id<CategoryManangerDelegate> delegate;
-(void)shopCategoryWithShopId:(NSString *)shopId;
-(void)categorySkuWithCategoryId:(NSString *)categoryId;
@end
