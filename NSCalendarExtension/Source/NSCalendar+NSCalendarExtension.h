//
//  NSCalendar+NSCalendarExtension.h
//  NSCalendarExtension
//
//  Created by dingwenchao on 9/14/16.
//  Copyright © 2016 dingwenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __NSCALENDAR_ALLOWS_COMPILE_INJECTING

@interface NSCalendar (NSCalendarExtension)

/**
 
 + (nullable NSCalendar *)calendarWithIdentifier:(NSString *)calendarIdentifier;
 
 - (nullable NSDate *)dateWithEra:(NSInteger)eraValue year:(NSInteger)yearValue month:(NSInteger)monthValue day:(NSInteger)dayValue hour:(NSInteger)hourValue minute:(NSInteger)minuteValue second:(NSInteger)secondValue nanosecond:(NSInteger)nanosecondValue;
 
 - (nullable NSDate *)dateWithEra:(NSInteger)eraValue yearForWeekOfYear:(NSInteger)yearValue weekOfYear:(NSInteger)weekValue weekday:(NSInteger)weekdayValue hour:(NSInteger)hourValue minute:(NSInteger)minuteValue second:(NSInteger)secondValue nanosecond:(NSInteger)nanosecondValue;
 
 - (nullable NSDate *)dateBySettingUnit:(NSCalendarUnit)unit value:(NSInteger)v ofDate:(NSDate *)date options:(NSCalendarOptions)opts;

 - (nullable NSDate *)dateBySettingHour:(NSInteger)h minute:(NSInteger)m second:(NSInteger)s ofDate:(NSDate *)date options:(NSCalendarOptions)opts;
 
 - (NSDate *)dateByAddingUnit:(NSCalendarUnit)unit value:(NSInteger)value toDate:(NSDate *)date options:(NSCalendarOptions)options;
 
 - (NSInteger)component:(NSCalendarUnit)component fromDate:(NSDate *)date;
 
 - (BOOL)isDate:(NSDate *)date1 inSameDayAsDate:(NSDate *)date2;
 
 - (BOOL)isDateInToday:(NSDate *)date;
 
 - (BOOL)isDateInYesterday:(NSDate *)date;
 
 - (BOOL)isDateInTomorrow:(NSDate *)date;
 
 - (BOOL)isDateInWeekend:(NSDate *)date;
 
 - (NSComparisonResult)compareDate:(NSDate *)date toDate:(NSDate *)date toUnitGranularity:(NSCalendarUnit)unit;
 
 - (BOOL)isDate:(NSDate *)date1 equalToDate:(NSDate *)date2 toUnitGranularity:(NSCalendarUnit)unit;
 
*/

@end

#endif
