//
//  ODDeliveryTimeInfo.h
//  PR
//
//  Created by 黄小雪 on 2017/9/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

#define KDataRate  1000

/**
 *  时间段信息
 */
typedef NS_ENUM(NSInteger,ODDSoltTimeType)
{
    ODDSoltTimeType_Immediate,
    ODDSoltTimeType_Except,
};

@interface ODDSoltTime : YHDataModel
@property (nonatomic,readonly) ODDSoltTimeType type;
@property (nonatomic,readonly) NSString        * typeStr;
@property (nonatomic,readonly) NSString        * fromTime;
@property (nonatomic,readonly) NSString        * toTime;
@property (readonly,nonatomic) NSString        *immediatedescription;

//3.1.0 是否选中
@property (assign,nonatomic) BOOL  selected;



- (NSString *)orderCommintpromptTitle;  //订单结算中显示调用
- (NSString *)orderDetailPromptTitle;   //订单详情中显示调用
- (ODDSoltTimeType)type;
@end


@interface ODDeliveryTimeInfo : YHDataModel
// 当天0点的时间戳
@property (nonatomic,readonly) NSTimeInterval    dateTimeStamp;
@property (nonatomic,readonly) NSString          * dateDesc;
@property (nonatomic,readonly) NSArray<ODDSoltTime *> * soltTimes;


//3.1.0 是否选中
@property (assign,nonatomic) BOOL  selected;
//时间选取器中使用
-(NSString *)timeSeletorDateDesc;


/**
 *  月-日
 */
- (NSString *)monthDayDesc;
/**
 *  年-月-日
 */
-(NSString *)yearsMonthDayDesc;
+ (NSArray *)dealExceptionTimeDict:(NSDictionary *)dict;
+ (NSArray *)dealAppointmentsTime:(NSArray*)timeArr;

-(BOOL)userdateIsToday;


@end
