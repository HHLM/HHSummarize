//
//  NSDate+EXT.h
//  HHSummarize
//
//  Created by LXH on 16/9/12.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (EXT)
/*
 * 获取年、月、日、小时、分钟、秒
 */
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSInteger)week;

+ (NSUInteger)year:(NSDate *)date;
+ (NSUInteger)month:(NSDate *)date;
+ (NSUInteger)day:(NSDate *)date;
+ (NSUInteger)hour:(NSDate *)date;
+ (NSUInteger)minute:(NSDate *)date;
+ (NSUInteger)second:(NSDate *)date;
+ (NSUInteger)week:(NSDate *)date;

/**
 获取星期几
 */
- (NSString *)weekday;
+ (NSString *)weekday:(NSDate *)date;

/**
 *  闰年
 */
- (BOOL)isLeapYear;
+ (BOOL)isLeapYear:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)daysInYear;
+ (NSUInteger)daysInYear:(NSDate *)date;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)daysInMonth;
+ (NSUInteger)daysInMonth:(NSDate *)date;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)daysInMonth:(NSUInteger)month;
+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)begindayOfMonth;
+ (NSDate *)begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)lastdayOfMonth;
+ (NSDate *)lastdayOfMonth:(NSDate *)date;

/**
 * 距离该日期前几天
 */
- (NSUInteger)daysAgo;
+ (NSUInteger)daysAgo:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)weekOfYear;
+ (NSUInteger)weekOfYear:(NSDate *)date;

/**
 * 获取该日期是该年的月份
 */
- (NSString *)monthOfYear;


/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)timeInfo;
+ (NSString *)timeInfoWithDate:(NSDate *)date;
+ (NSString *)timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)ymdFormat;
- (NSString *)hmsFormat;
- (NSString *)ymdHmsFormat;
+ (NSString *)ymdFormat;
+ (NSString *)hmsFormat;
+ (NSString *)ymdHmsFormat;

/**
 时间和Date转换
 */
- (NSString *)tiemStringWithFormate:(NSString *)formate;
+ (NSString *)timeStringFromDate:(NSDate *)date formate:(NSString *)formate;
+ (NSDate *)dateFormDateString:(NSString *)dateString formate:(NSString *)formate;

/**
 时间戳、时间、Date
 */
- (double)timeInterval;
+ (double)timeIntervalFromDate:(NSDate *)date;
+ (NSDate *)datefromTimeInterval:(long)tiem;
+ (NSString *)timefromTimeInterval:(long)tiem formatter:(NSString *)formatter;
+ (double)timeIntervalFromDateString:(NSString *)dateString formatter:(NSString *)formatter;

/**
 *  是否是同一天 YES是相同 NO 不同
 */
- (BOOL)isSameDay:(NSDate *)date;

//是否是今天
- (BOOL)isToday;

//当前日期添加天数
- (NSDate *)dateByAddDays:(NSUInteger)days;
@end
