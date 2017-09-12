//
//  ODDeliveryTimeInfo.m
//  PR
//
//  Created by 黄小雪 on 2017/9/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ODDeliveryTimeInfo.h"
#import "TimeStampMananger.h"

#define KMinInOneHour 60

@interface ODModelDate : NSObject
@property(nonatomic, assign) NSInteger  hour;
@property(nonatomic, assign) NSInteger  min;

+ (ODModelDate *)dateWithHour:(NSInteger)hour min:(NSInteger)min;

- (ODModelDate *)appendWithIntervel:(NSInteger)min;

- (NSString *)toDescrption;

- (NSComparisonResult)compare:(ODModelDate *)modelDate;
@end


@implementation ODModelDate
+ (ODModelDate *)dateWithHour:(NSInteger)hour min:(NSInteger)min
{
    ODModelDate * modelDate = [ODModelDate new];
    modelDate.hour = hour;
    modelDate.min = min;
    return modelDate;
}

- (ODModelDate *)appendWithIntervel:(NSInteger)min
{
    NSInteger  calcMin = self.min + min;
    NSInteger  calcHour = self.hour;
    while (calcMin >= KMinInOneHour) {
        calcMin -= KMinInOneHour;
        calcHour ++;
    }
    ODModelDate * calcModel = [ODModelDate new];
    calcModel.hour = calcHour;
    calcModel.min = calcMin;
    return calcModel;
}

- (NSString *)toDescrption
{
    return  [NSString stringWithFormat:@"%02ld:%02ld",(long)self.hour,(long)self.min];
}

- (NSComparisonResult)compare:(ODModelDate *)modelDate
{
    NSInteger toMins = self.hour * KMinInOneHour + self.min;
    NSInteger comparedMins = modelDate.hour * KMinInOneHour + modelDate.min;
    
    if (toMins > comparedMins) {
        return NSOrderedDescending;
    }else if (toMins == comparedMins)
    {
        return NSOrderedSame;
    }
    return NSOrderedAscending;
}


@end

@interface ODDSoltTime()
@end

@implementation ODDSoltTime
- (ODDSoltTimeType)type
{
    return [self.typeStr isEqualToString:@"immediate"] ? ODDSoltTimeType_Immediate : ODDSoltTimeType_Except;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _typeStr              = [dic safeObjectForKey:@"slottype" hintClass:[NSString class]];
        _fromTime             = [dic safeObjectForKey:@"from" hintClass:[NSString class]];
        _toTime               = [dic safeObjectForKey:@"to" hintClass:[NSString class]];
        _immediatedescription = [dic safeObjectForKey:@"immediatedescription" hintClass:[NSString class]];
    }
    return self;
}

-(NSString *)orderDetailPromptTitle;
{
    if (self.fromTime == nil || self.toTime == nil) {
        if (self.type == ODDSoltTimeType_Immediate) {
            return self.immediatedescription?:@"";
        }
    }else{
        return [NSString stringWithFormat:@"%@-%@",self.fromTime,self.toTime];
    }
    
    return [NSString stringWithFormat:@"%@-%@",self.fromTime,self.toTime];
    
}
- (NSString *)orderCommintpromptTitle
{
    if (self.type == ODDSoltTimeType_Immediate) {
        return self.immediatedescription?:@"";
    }else{
        return [NSString stringWithFormat:@"%@-%@",self.fromTime,self.toTime];
    }
    
    return [NSString stringWithFormat:@"%@-%@",self.fromTime,self.toTime];
}

@end


@implementation ODDeliveryTimeInfo
- (NSString *)dateDesc
{
    NSString * prefixStr = nil;
    NSString * midStr = nil;
    NSString * shufixStr = nil;
    
    
    NSDate * theDate = [NSDate dateWithTimeIntervalSince1970:self.dateTimeStamp];
    if ([self isToday:theDate]) {
        prefixStr = @"今天";
    }else if ([self isTomorrow:theDate]){
        prefixStr = @"明天";
    }else{
        prefixStr = @"";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    midStr = [dateFormatter stringFromDate:theDate];
    
    
    NSArray * weeklyDes = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSInteger unitFlags = NSWeekdayCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:theDate];
    shufixStr = [NSString stringWithFormat:@"周%@",[weeklyDes safeObjectAtIndex:comps.weekday - 1]];
    
    return [NSString stringWithFormat:@"%@%@ | %@",prefixStr,midStr,shufixStr];
}

-(NSString *)timeSeletorDateDesc
{
    NSString * midStr = nil;
    NSString * shufixStr = nil;
    
    
    NSDate * theDate = [NSDate dateWithTimeIntervalSince1970:self.dateTimeStamp];
    if ([self isToday:theDate]) {
        shufixStr = @"今天";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    midStr = [dateFormatter stringFromDate:theDate];
    
    
    NSArray * weeklyDes = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSInteger unitFlags = NSWeekdayCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:theDate];
    if (shufixStr == nil) {
        shufixStr = [NSString stringWithFormat:@"周%@",[weeklyDes safeObjectAtIndex:comps.weekday - 1]];
    }
    return [NSString stringWithFormat:@"%@ %@",midStr,shufixStr];
}


#pragma mark - priviate method
- (BOOL)isToday:(NSDate *)checkDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString * checkDateStr = [dateFormatter stringFromDate:checkDate];
    NSDate * now = [NSDate dateWithTimeIntervalSince1970:[[TimeStampMananger shareManager] timeStamp]];
    NSString * todayDateStr = [dateFormatter stringFromDate:now];
    
    if ([todayDateStr isEqualToString:checkDateStr]) {
        return YES;
    }else {
        return NO;
    }
}


-(BOOL)userdateIsToday
{
    NSDate * theDate = [NSDate dateWithTimeIntervalSince1970:self.dateTimeStamp];
    return [self isToday:theDate];
}


-(NSString *)monthDayDesc;
{
    NSDate * theDate = [NSDate dateWithTimeIntervalSince1970:self.dateTimeStamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    return  [dateFormatter stringFromDate:theDate];
}


-(NSString *)yearsMonthDayDesc
{
    NSDate * theDate = [NSDate dateWithTimeIntervalSince1970:self.dateTimeStamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return  [dateFormatter stringFromDate:theDate];
}

- (BOOL)isTomorrow:(NSDate *)checkDate
{
#define kSecondCountInOneDay 24 * 60 * 60
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString * checkDateStr = [dateFormatter stringFromDate:checkDate];
    NSDate * now = [NSDate dateWithTimeIntervalSince1970:[[TimeStampMananger shareManager] timeStamp]];
    NSDate * tomorrow = [now dateByAddingTimeInterval:kSecondCountInOneDay];
    NSString * tomorrowDateStr = [dateFormatter stringFromDate:tomorrow];
    
    if ([checkDateStr isEqualToString:tomorrowDateStr]) {
        return YES;
    }else {
        return NO;
    }
    
}


#pragma mark - init
+ (NSArray *)dealExceptionTimeDict:(NSDictionary *)dict
{
    CONDITION_CHECK_RETURN_VAULE(dict != nil, nil);
    ODDeliveryTimeInfo * info = [ODDeliveryTimeInfo modelFromDictionary:dict];
    if (info) {
        return @[info];
    }
    return nil;
}

+ (NSArray *)dealAppointmentsTime:(NSArray*)timeArr
{
#define KTimeRate 60
#define KHourRate 25
    NSString *immediatedescription = nil;
    NSMutableArray * deliveryTimeInfos = [NSMutableArray array];
    
    for (NSInteger n = 0; n < [timeArr count]; n ++) {
        
        NSDictionary *dict           = [timeArr objectAtIndex:n];
        NSArray *time                = [dict safeObjectForKey:@"times" hintClass:[NSArray class]];
        NSDictionary *timeDict       = [[NSDictionary alloc]initWithDictionary:[time firstObject]];
        
        NSInteger fromhour           = [[timeDict safeObjectForKey:@"fromHour" hintClass:[NSNumber class]]integerValue];
        NSInteger fromminute         = [[timeDict safeObjectForKey:@"fromMinute" hintClass:[NSNumber class]]integerValue];
        
        NSInteger interval           = [[timeDict safeObjectForKey:@"interval" hintClass:[NSNumber class]]integerValue];
        NSInteger isimmediatesupport = [[timeDict safeObjectForKey:@"isimmediatesupport" hintClass:[NSNumber class]]integerValue];
        
        NSInteger tohour             = [[timeDict safeObjectForKey:@"toHour" hintClass:[NSNumber class]]integerValue];
        NSInteger tominute           = [[timeDict safeObjectForKey:@"toMinute" hintClass:[NSNumber class]]integerValue];
        
        immediatedescription         = [timeDict safeObjectForKey:@"immediatedescription" hstringClass:[NSString class]]?:@"";
        
        if (10 < fromminute && fromminute <= 40) {
            fromminute = 30;
        }else if (10 >= fromminute){
            fromminute = 0;
        }else if (40 < fromminute){
            fromminute = 0;
            fromhour += 1;
        }
        
        
        
        NSArray *dates  = [dict safeObjectForKey:@"dates" hintClass:[NSArray class]];
        
        for (int m = 0; m < [dates count] ; m ++) {
            NSMutableArray *soltTimeArr = [[NSMutableArray alloc]init];
            
            if (isimmediatesupport == 1) {
                NSString *slottype =  @"immediate";
                NSDictionary *dict    = @{@"from":@"",
                                          @"to":@"",
                                          @"slottype":slottype,
                                          @"immediatedescription":immediatedescription};
                [soltTimeArr addObject:dict];
            }
            
            
            ODModelDate * rangeHead = [ODModelDate dateWithHour:fromhour min:fromminute]; // 区间的起点
            ODModelDate * rangeTail   = nil; // 区间的结尾
            ODModelDate * theEndTime  = [ODModelDate dateWithHour:tohour min:tominute]; // toTime，不能超越
            
            //            YHLogInfo(@"%@=====dd99d9=======%@",rangeHead)
            // 循环增加
            while (TRUE) {
                BOOL thisDayCompleted = NO;
                NSString *slottype  = @"expectTime";
                rangeTail = [rangeHead appendWithIntervel:interval]; // 通过增量计算区间结尾
                NSComparisonResult compare = [rangeTail compare:theEndTime]; // 判断是否到达了toTime,不能大于toTime.否则修正为toTime
                if (compare == NSOrderedDescending) {
                    rangeTail = theEndTime;
                    thisDayCompleted = YES;
                }else if (compare == NSOrderedSame)
                {
                    thisDayCompleted = YES;
                }else if ([rangeTail compare:theEndTime] == NSOrderedSame){
                    thisDayCompleted = YES;
                }
                if(!([rangeTail compare:rangeHead] == NSOrderedSame)){
                    NSDictionary *dict = @{@"from":[rangeHead toDescrption],
                                           @"to":[rangeTail toDescrption],
                                           @"slottype":slottype,
                                           @"immediatedescription":immediatedescription};
                    // 记录到输出数组
                    [soltTimeArr addObject:dict];
                    
                }
                if (thisDayCompleted) {
                    break;
                }
                // 计算下一个区间
                rangeHead = rangeTail;
            }
            
            
            NSDictionary *dict           = @{@"timeslots":soltTimeArr,@"date":[dates objectAtIndex:m]};
            ODDeliveryTimeInfo *delivery = [[ODDeliveryTimeInfo alloc] initWithDictionary:dict];
            [deliveryTimeInfos addObject:delivery];
        }
    }
    return deliveryTimeInfos;
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _dateTimeStamp = [[dic safeObjectForKey:@"date" hintClass:[NSNumber class]] longLongValue]/KDataRate;
        
        NSArray * soltInfos = [dic safeObjectForKey:@"timeslots" hintClass:[NSArray class]];
        if (soltInfos == nil) {
            NSDictionary * singleTime = [dic safeObjectForKey:@"timeslot" hintClass:[NSDictionary class]];
            if (nil != singleTime) {
                soltInfos = [NSArray arrayWithObject:singleTime];
            }
        }
        NSMutableArray * soltObjs = [NSMutableArray arrayWithCapacity:[soltInfos count]];
        for (NSDictionary * aInfo in soltInfos) {
            ODDSoltTime * aSoltObj = [ODDSoltTime modelFromDictionary:aInfo];
            [soltObjs addObject:aSoltObj];
        }
        _soltTimes = soltObjs;
    }
    return self;
}


@end
