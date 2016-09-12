//
//  NSDate+EXT.m
//  HHSummarize
//
//  Created by LXH on 16/9/12.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "NSDate+EXT.h"


#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0

static const unsigned components = (NSCalendarUnitYear|
                                    NSCalendarUnitMonth |
                                    NSCalendarUnitDay |
                                    NSCalendarUnitWeekOfMonth |
                                    NSCalendarUnitWeekOfYear|
                                    NSCalendarUnitHour |
                                    NSCalendarUnitMinute|
                                    NSCalendarUnitSecond |
                                    NSCalendarUnitWeekday |
                                    NSCalendarUnitWeekdayOrdinal);

#elif 

static const unsigned components = (NSYearCalendarUnit|
                                    NSMonthCalendarUnit|
                                    NSDayCalendarUnit |
                                    NSWeekCalendarUnit |
                                    NSHourCalendarUnit |
                                    NSMinuteCalendarUnit |
                                    NSSecondCalendarUnit |
                                    NSWeekdayCalendarUnit |
                                    NSWeekOfMonthCalendarUnit|
                                    NSWeekOfYearCalendarUnit|
                                    NSWeekdayOrdinalCalendarUnit);

#endif

@implementation NSDate (EXT)
#pragma mark -- shareCalendar
+ (NSCalendar *)calendar
{
    static NSCalendar *shareCalendar = nil;
    if (!shareCalendar) {
        shareCalendar = [NSCalendar autoupdatingCurrentCalendar];
    }
    return shareCalendar;
}
+ (NSDateComponents *)dateAgoComPonents:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComPonents = [calendar components:components
                                                  fromDate:date
                                                    toDate:[NSDate date]
                                                   options:NSCalendarWrapComponents];
    return dayComPonents;
}

+ (NSDateComponents *)dateComPonents:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComPonents = [calendar components:components fromDate:date];
    return dayComPonents;
}

- (NSDate *)dateAfterMonth:(NSUInteger)month {
    return [NSDate dateAfterDate:self month:month];
}
+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)dateAfterDay:(NSUInteger)day {
    return [NSDate dateAfterDate:self day:day];
}
+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}
#pragma mark -- 第一天 和最后一天
- (NSDate *)begindayOfMonth {
    return [NSDate begindayOfMonth:self];
}

+ (NSDate *)begindayOfMonth:(NSDate *)date {
    return [self dateAfterDate:date day:-[date day] + 1];
}

- (NSDate *)lastdayOfMonth {
    return [NSDate lastdayOfMonth:self];
}

+ (NSDate *)lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self begindayOfMonth:date];
    return [[lastDate dateAfterMonth:1] dateAfterDay:-1];
}
#pragma mark -- 年、月、日 时、分、秒
- (NSInteger)day {
    return [NSDate day:self];;
}
- (NSInteger)year {
    return [NSDate year:self];
}
- (NSInteger)month {
    return [NSDate month:self];
}
- (NSInteger)week {
    return [NSDate week:self];
}
- (NSInteger)minute {
    return [NSDate minute:self];
}
- (NSInteger)hour {
    return [NSDate hour:self];
}
- (NSInteger)second {
    return [NSDate second:self];
}

+ (NSUInteger)year:(NSDate *)date
{
    return [[NSDate dateComPonents:date] year];
}
+ (NSUInteger)month:(NSDate *)date
{
    return [[NSDate dateComPonents:date] month];
}
+ (NSUInteger)day:(NSDate *)date
{
    return [[NSDate dateComPonents:date] day];
}
+ (NSUInteger)hour:(NSDate *)date
{
    return [[NSDate dateComPonents:date] hour];
}
+ (NSUInteger)minute:(NSDate *)date
{
    return [[NSDate dateComPonents:date] minute];
}
+ (NSUInteger)second:(NSDate *)date
{
    return [[NSDate dateComPonents:date] second];
}
+ (NSUInteger)week:(NSDate *)date
{
    return [[NSDate dateComPonents:date] weekday];
}

#pragma mark -- 星期几

- (NSUInteger)weekOfYear {
    return [NSDate weekOfYear:self];
}

+ (NSUInteger)weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date year];
    
    NSDate *lastdate = [date lastdayOfMonth];
    
    for (i = 1;[[lastdate dateAfterDay:-7 * i] year] == year; i++) {
        
    }
    
    return i;
}

- (NSUInteger)weeksOfMonth {
    return [NSDate weeksOfMonth:self];
}

+ (NSUInteger)weeksOfMonth:(NSDate *)date {
    return [[date lastdayOfMonth] weekOfYear] - [[date begindayOfMonth] weekOfYear] + 1;
}

- (NSString *)weekday {
  return  [NSDate weekday:self];
}
+ (NSString *)weekday:(NSDate *)date
{
    switch ([date week]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }return @"";
}
#pragma mark -- 闰年
- (BOOL)isLeapYear {
    return [NSDate isLeapYear:self];
}
//能被4整除且又能不能被100整除 是闰年 能直接被400整除也是闰年
+ (BOOL)isLeapYear:(NSDate *)date {
    NSUInteger year = [date year];
    if ((year % 4 == 0&& year %100 != 0) || year%400 == 0) {
        return YES;
    }
    return NO;
}

- (NSUInteger)daysAgo {
    return [NSDate daysAgo:self];
}
+ (NSUInteger)daysAgo:(NSDate *)date {
    return [[NSDate dateAgoComPonents:date] day];
}

#pragma mark -- 每年的天数
+ (NSUInteger)daysInYear:(NSDate *)date {
    return [self isLeapYear:date]?366:365;
}
- (NSUInteger)daysInYear {
    return [NSDate daysInYear:self]?366:365;
}

#pragma mark -- 每月的天数
+ (NSUInteger)daysInMonth:(NSDate *)date {
    return [NSDate daysInMonth:date month:[date month]];
}
- (NSUInteger)daysInMonth {
    return [NSDate daysInMonth:self];
}

- (NSUInteger)daysInMonth:(NSUInteger)month
{
    return [NSDate daysInMonth:self month:month];
}

+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1:case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
            break;
        case 2:
            return [date isLeapYear]?29:28;
        default:
            return 30;
            break;
    }
}

- (NSString *)monthOfYear {
    switch([self month]) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";

}

#pragma mark -- 时间信息
- (NSString *)timeInfo;
{
    return [NSDate timeInfoWithDate:self];
}
+ (NSString *)timeInfoWithDateString:(NSString *)dateString{
    return [NSDate timeInfoWithDate:[NSDate dateFormDateString:dateString formate:[self ymdHmsFormat]]];
}
+ (NSString *)timeInfoWithDate:(NSDate *)date {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:currentDate];
    time = [currentDate timeIntervalSinceReferenceDate] - [date timeIntervalSinceReferenceDate];
//    int year = (int)([currentDate year] - [date year]);
//    int month = (int)([currentDate month] - [date month]);
//    int day = (int)([currentDate day] - [date day]);
//    
    NSTimeInterval rectTime = 0.0f;
    
    if (time < 60) {
        rectTime = rectTime <= 0.0?1.0:rectTime;
        return [NSString stringWithFormat:@"%0.f秒前",rectTime];
    }
    else if (time < 3600) {
        rectTime = time / 60;
        rectTime = rectTime <= 0.0?1.0:rectTime;
        return [NSString stringWithFormat:@"%0.f分钟前",rectTime];
    }
    else if (time < 3600 * 24)
    {
        rectTime = time / 3600;
        rectTime = rectTime <= 0.0?1.0:rectTime;
        return [NSString stringWithFormat:@"%0.f小时前",rectTime];
    }else if (time < 3600 * 24 * 2)
    {
        return @"昨天";
    }
    else if (time < 3600 *24 * 30)
    {
        rectTime = time / 3600 /24;
        rectTime = rectTime <= 0.0?1.0:rectTime;
        return [NSString stringWithFormat:@"%0.f天前",rectTime];
    }
    else if (time < 3600 * 24 * 30 *12) {
        rectTime = time / 3600 /30;
        rectTime = rectTime <= 0.0?1.0:rectTime;
        return [NSString stringWithFormat:@"%0.f个月前",rectTime];
    }else
    {
        rectTime = time / 3600 /30 /12;
        rectTime = rectTime <= 0.0?1.0:rectTime;
        return [NSString stringWithFormat:@"%0.f年前",rectTime];
    }
    return @"";
}

#pragma mark -- sameDay
- (BOOL)isSameDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned comp = (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay);
    
    NSDateComponents *components1 = [calendar components:comp fromDate:self];
    
     NSDateComponents *components2 = [calendar components:comp fromDate:date];
    
    return ([components1 year] == [components2 year] &&
            [components1 month] == [components2 month] &&
            [components1 day] == [components2 day]);
}
#pragma mark -- 是否是今天
- (BOOL)isToday {
    return [self isSameDay:[NSDate date]];
}
- (NSDate *)dateByAddDays:(NSUInteger)days
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = days;
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    return date;
}
#pragma mark -- 时间格式
- (NSString *)ymdFormat {
    return [NSDate ymdFormat];
}

- (NSString *)hmsFormat {
    return [NSDate hmsFormat];
}

- (NSString *)ymdHmsFormat {
    return [NSDate ymdHmsFormat];
}

+ (NSString *)ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self ymdFormat], [self hmsFormat]];
}

#pragma mark -- 时间戳、时间和date转换
- (NSString *)tiemStringWithFormate:(NSString *)formate
{
    return [NSDate timeStringFromDate:self formate:formate];
}
//NSDate转时间
+ (NSString *)timeStringFromDate:(NSDate *)date formate:(NSString *)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
//时间转成NSDate
+ (NSDate *)dateFormDateString:(NSString *)dateString formate:(NSString *)formate{
    NSDateFormatter *fotmatter = [[NSDateFormatter alloc] init];
    [fotmatter setDateFormat:formate];
    NSDate *date = [fotmatter dateFromString:dateString];
    return date;
}
- (double)timeInterval
{
    return [NSDate timeIntervalFromDate:self];
}
+ (double)timeIntervalFromDate:(NSDate *)date
{
    double time = [date timeIntervalSince1970];
    return time;
}
+ (NSDate *)datefromTimeInterval:(long)tiem
{
    return [NSDate dateWithTimeIntervalSince1970:tiem];
}
+ (NSString *)timefromTimeInterval:(long)tiem formatter:(NSString *)formatter
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:tiem];
    return [NSDate timeStringFromDate:date formate:formatter];
}
//!< 时间转时间戳
+ (double)timeIntervalFromDateString:(NSString *)dateString formatter:(NSString *)formatter
{
    NSDate *date = [self dateFormDateString:dateString formate:formatter];
    return [NSDate timeIntervalFromDate:date];
}
@end
