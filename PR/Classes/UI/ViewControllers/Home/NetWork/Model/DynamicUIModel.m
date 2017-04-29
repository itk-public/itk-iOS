//
//  DynamicUIModel.m
//  PR
//
//  Created by 黄小雪 on 12/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "DynamicUIModel.h"
#import "DMExhibitItem.h"
#import "UtilCodeTool.h"
#import "DynamicDataTransformTool.h"
#import "ProductInfo.h"

@implementation DynamicCardItem
FUNCTION_NSCODINGIMP_WITHCLAZZ([DynamicCardItem class])
-(instancetype)initWithType:(DynamicCardType)type withData:(id)data
{
    if (self = [super init]) {
        _type = type;
        _data = data;
    }
    return self;
}


+(id)cardForType:(DynamicCardType)type withData:(id)data
{
#warning 还有逻辑判断
    return [[DynamicCardItem alloc]initWithType:type withData:data];
}
@end

@interface DynamicFloorItem : YHDataModel

@property (strong,nonatomic) NSMutableDictionary *items;

@end

@implementation DynamicFloorItem
static NSString * prefixKey = @"keyPrefix";

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        
        for ( NSInteger cardType = DynamicCardType_MIN; cardType < DYnamicCardType_MAX; cardType ++) {
            [self parseCardForType:cardType inDic:dic];
        }
    }
    return self;
}

-(void)parseCardForType:(DynamicCardType)cardType inDic:(NSDictionary *)dict
{
    switch (cardType) {
        case DynamicCardType_HotBanner:
        {
            NSArray *bannerArr = [dict safeObjectForKey:@"banner" hintClass:[NSArray class]];
            [self parseDataArray:bannerArr withItemClass:[DMExhibitItem class] forType:cardType];
            break;
        }
        case DynamicCardType_HotIcon:
        {
            NSArray *dataArray = [dict safeObjectForKey:@"jewel" hintClass:[NSArray class]];
            [self parseDataArray:dataArray withItemClass:[DMExhibitItem class] forType:cardType];
            break;
        }
        case DynamicCardType_CellGap:
        {
            NSDictionary *tDic = [dict safeObjectForKey:@"partingline" hintClass:[NSDictionary class]];
            if (tDic) {
                [self parseDataDict:tDic withItemClass:[DMExhibitItem class] forType:cardType];
            }
            break;
        }
        case DynamicCardType_Channels:
        {
            break;
        }
        case DYnamicCardType_SellerInfo:
        {
            NSDictionary *tDict = [dict safeObjectForKey:@"shop" hintClass:[NSDictionary class]];
            if (tDict) {
                [self parseDataDict:tDict withItemClass:[DMExhibitItem class] forType:cardType];
            }
            break;
        }
        case DYnamicCardType_SellerProducts:
        {
            NSArray *array = [dict safeObjectForKey:@"shopproducts" hintClass:[NSArray class]];
            if (array) {
                [self parseDataArray:array withItemClass:[ProductInfo class] forType:cardType];
            }
            break;
        }
        case DYnamicCardType_SellerCoupon:
        {
            NSDictionary *tDict = [dict safeObjectForKey:@"shopcoupon" hintClass:[NSDictionary class]];
            if (tDict) {
                [self parseDataDict:tDict withItemClass:[DMExhibitItem class] forType:cardType];
            }
            break;
        }
        case DYnamicCardType_ThressProducts:
        {
            NSArray *array = [dict safeObjectForKey:@"skupos3c" hintClass:[NSArray class]];
            if (array) {
                [self parseDataArray:array withItemClass:[ProductInfo class] forType:cardType];
            }
            break;
        }
        case DYnamicCardType_SellerActivity:
        {
            NSDictionary *tDict = [dict safeObjectForKey:@"shopinfo" hintClass:[NSDictionary class]];
            if (tDict) {
                [self parseDataDict:tDict withItemClass:[DMExhibitItem class] forType:cardType];
            }
            break;
        }
        default:
        break;
    }
}


-(void)parseDataArray:(NSArray *)dataArray
        withItemClass:(Class)itemClass
              forType:(DynamicCardType)cardType
{
#if DEBUG
    if (nil == class_getClassMethod(itemClass, @selector(modelFromDictionary:))) {
        NSAssert(false, @"传递了一个不支持 modelFromDictionary的class,请使用YHDataModel的之类");
    }
#endif
    if (dataArray) {
        NSMutableArray *objs = [NSMutableArray arrayWithCapacity:[dataArray count]];
        for (NSDictionary *dict in dataArray) {
            YHDataModel *aObj = [itemClass modelFromDictionary:dict];
            [objs addObject:aObj];
        }
        [self assignObj:objs toType:cardType];
    }else{
        [self assignObj:nil toType:cardType];
    }
}

-(void)assignObj:(id)obj toType:(DynamicCardType)cardType
{
    NSString *key = [NSString stringWithFormat:@"%@_%ld",prefixKey,(long)cardType];
    if (obj == nil) {
        [self.items removeObjectForKey:key];
    }else{
        //封装成carditem
        DynamicCardItem *cardItem = [DynamicCardItem cardForType:cardType withData:obj];
        if (nil == self.items) {
            self.items = [[NSMutableDictionary alloc]init];
        }
        if (cardItem) {
            [self.items safeSetObject:cardItem forKey:key];
        }else{
            [self.items removeObjectForKey:key];
        }
    }
}

-(void)parseDataDict:(NSDictionary *)dataDict
       withItemClass:(Class)itemClass
             forType:(DynamicCardType)cardType
{
#if DEBUG
    if (nil == class_getClassMethod(itemClass, @selector(modelFromDictionary:))) {
        NSAssert(false, @"传递了一个不支持 modelFromDictionary 的class，请使用 YHDataModel的之类");
    }
#endif
    if (dataDict) {
        YHDataModel *aObj = [itemClass modelFromDictionary:dataDict];
        [self assignObj:aObj toType:cardType];
    }else{
        [self assignObj:nil toType:cardType];
    }
}

#pragma mark -OUT
-(NSEnumerator *)defaultKeyIterator
{
    NSMutableArray *defaultSoryKeys = [NSMutableArray array];
    for (NSInteger cardType = DynamicCardType_MIN; cardType < DYnamicCardType_MAX; cardType ++) {
        NSString *key = [NSString stringWithFormat:@"%@_%ld",prefixKey,(long)cardType];
        [defaultSoryKeys addObject:key];
    }
    return [defaultSoryKeys objectEnumerator];
}

-(NSArray *)sortedCardItems
{
    NSMutableArray *sortedItems = [NSMutableArray arrayWithCapacity:[[self.items allKeys] count]];
    NSEnumerator *enumerator    = [self defaultKeyIterator];
    NSString *key  = nil;
    while (key = [enumerator nextObject]) {
        [sortedItems safeAddObject:[self.items safeObjectForKey:key]];
    }
    return sortedItems;
}
@end

@interface DynamicUIModel()

@property (strong,nonatomic) NSArray *sortedCards;

@end
@implementation DynamicUIModel
FUNCTION_NSCODINGIMP_WITHCLAZZ([DynamicUIModel class])

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
         dic = [DynamicDataTransformTool transformDynamicData:dic];
        NSArray *allFloors = [dic safeObjectForKey:@"floors" hintClass:[NSArray class]];
        NSMutableArray *allFloorObjs = [NSMutableArray arrayWithCapacity:[allFloors count]];
        for (NSDictionary *aFloorDic in allFloors) {
            DynamicFloorItem *aFloorObj = [DynamicFloorItem modelFromDictionary:aFloorDic];
            [allFloorObjs addObject:aFloorObj];
        }
        [self captureFloorCards:allFloorObjs];
    }
    return self;
}

- (void)captureFloorCards:(NSArray *)floors
{
    if (self.sortedCards) {
        self.sortedCards = nil;
    }
    NSMutableArray *theSortedItems = [NSMutableArray array];
    for (DynamicFloorItem *item in floors) {
        NSArray *theSortedCardInFloor = [item sortedCardItems];
        if ([theSortedCardInFloor count]) {
            [theSortedItems addObjectsFromArray:theSortedCardInFloor];
        }
    }
    self.sortedCards = theSortedItems;
}

-(NSArray *)dynamicCards
{
    return self.sortedCards;
}
@end
