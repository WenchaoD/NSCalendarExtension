//
//  NSCalendarExtensionTests.m
//  NSCalendarExtensionTests
//
//  Created by dingwenchao on 9/16/16.
//  Copyright © 2016 dingwenchao. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSCalendar+NSCalendarExtension.h"
#import "NSDateComponents+NSCalendarExtension.h"
#import "NSString+NSCalendarExtension.h"

@interface NSCalendarExtensionTests : XCTestCase

@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSDateComponents *components;

@property (strong, nonatomic) NSArray<NSNumber *> *units1;
@property (strong, nonatomic) NSArray<NSNumber *> *units2;
@property (strong, nonatomic) NSArray<NSNumber *> *errorUnits;

@end

@implementation NSCalendarExtensionTests


- (void)setUp
{
    [super setUp];
    self.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    self.units1 = @[@(NSCalendarUnitEra),
                    @(NSCalendarUnitYear),
                    @(NSCalendarUnitMonth),
                    @(NSCalendarUnitDay),
                    @(NSCalendarUnitHour),
                    @(NSCalendarUnitMinute),
                    @(NSCalendarUnitSecond),
                    @(NSCalendarUnitNanosecond)];
    
    self.units2 = @[@(NSCalendarUnitEra),
                    @(NSCalendarUnitYearForWeekOfYear),
                    @(NSCalendarUnitWeekOfYear),
                    @(NSCalendarUnitWeekday),
                    @(NSCalendarUnitHour),
                    @(NSCalendarUnitMinute),
                    @(NSCalendarUnitSecond),
                    @(NSCalendarUnitNanosecond)];
    
    
    self.errorUnits = @[@(NSNotFound),
                        @(1),
                        @(12),
                        @(123),
                        @(1234),
                        @(12345),
                        @(123456),
                        @(1234567),
                        @(-1),
                        @(-12),
                        @(-123),
                        @(-1234),
                        @(-12345),
                        @(-123456),
                        @(-1234567),
                        @(0)];
    
    
    self.components = [[NSDateComponents alloc] init];
    self.components.era = 1;
    self.components.year = 2016;
    self.components.month = 10;
    self.components.day = 10;
}

- (void)tearDown
{
    [super tearDown];
    self.calendar = nil;
    self.units1 = nil;
    self.units2 = nil;
    self.errorUnits = nil;
    self.components = nil;
}

- (void)testComponentFromDate
{
    NSDate *today = [NSDate date];
    [self.units1 enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.calendar component:obj.unsignedIntegerValue fromDate:today]);
    }];
    [self.units2 enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.calendar component:obj.unsignedIntegerValue fromDate:today]);
    }];
    [self.errorUnits enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.calendar component:obj.unsignedIntegerValue fromDate:today]);
    }];
    
    
    NSInteger era = [self.calendar component:NSCalendarUnitEra fromDate:today];
    NSInteger year = [self.calendar component:NSCalendarUnitYear fromDate:today];
    NSInteger month = [self.calendar component:NSCalendarUnitMonth fromDate:today];
    NSInteger day = [self.calendar component:NSCalendarUnitDay fromDate:today];
    NSInteger hour = [self.calendar component:NSCalendarUnitHour fromDate:today];
    NSInteger minute = [self.calendar component:NSCalendarUnitMinute fromDate:today];
    NSInteger second = [self.calendar component:NSCalendarUnitSecond fromDate:today];
    NSInteger nanosecond = [self.calendar component:NSCalendarUnitNanosecond fromDate:today];
    NSInteger yearForWeekOfYear = [self.calendar component:NSCalendarUnitYearForWeekOfYear fromDate:today];
    NSInteger weekOfYear = [self.calendar component:NSCalendarUnitWeekOfYear fromDate:today];
    NSInteger weekday = [self.calendar component:NSCalendarUnitWeekday fromDate:today];
    
    
    XCTAssertEqual(era, [self.calendar components:NSCalendarUnitEra fromDate:today].era);
    XCTAssertEqual(year, [self.calendar components:NSCalendarUnitYear fromDate:today].year);
    XCTAssertEqual(month, [self.calendar components:NSCalendarUnitMonth fromDate:today].month);
    XCTAssertEqual(day, [self.calendar components:NSCalendarUnitDay fromDate:today].day);
    XCTAssertEqual(hour, [self.calendar components:NSCalendarUnitHour fromDate:today].hour);
    XCTAssertEqual(minute, [self.calendar components:NSCalendarUnitMinute fromDate:today].minute);
    XCTAssertEqual(second, [self.calendar components:NSCalendarUnitSecond fromDate:today].second);
    XCTAssertEqual(nanosecond, [self.calendar components:NSCalendarUnitNanosecond fromDate:today].nanosecond);
    XCTAssertEqual(yearForWeekOfYear, [self.calendar components:NSCalendarUnitYearForWeekOfYear fromDate:today].yearForWeekOfYear);
    XCTAssertEqual(weekOfYear, [self.calendar components:NSCalendarUnitWeekOfYear fromDate:today].weekOfYear);
    XCTAssertEqual(weekday, [self.calendar components:NSCalendarUnitWeekday fromDate:today].weekday);
}

- (void)testDateByAddingUnit
{
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *tomorrow = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:today options:0];
    NSLog(@"%@",tomorrow);
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = 1;
    NSDate *originalTomorrow = [calendar dateByAddingComponents:c toDate:today options:0];
    XCTAssertTrue([originalTomorrow compare:tomorrow] == NSOrderedSame);
    
    // Ensure not throw error on passing wrong unit
    XCTAssertNoThrow([calendar dateByAddingUnit:123 value:123 toDate:today options:0]);
}

- (void)testIsDateInWeekend
{
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:today];
    XCTAssertEqual([calendar isDateInWeekend:today], weekday==1||weekday==7);
}

- (void)testDayEqual
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:@"2016-09-09 13:00:00"];
    NSDate *date2 = [self.calendar dateByAddingUnit:NSCalendarUnitMinute value:1 toDate:date1 options:0];
    
    [self.units1 enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:obj.unsignedIntegerValue]);
    }];
    [self.units2 enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:obj.unsignedIntegerValue]);
    }];
    [self.errorUnits enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:obj.unsignedIntegerValue]);
    }];
    
    
    XCTAssertEqual([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:NSCalendarUnitSecond], NSOrderedAscending);
    XCTAssertEqual([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:NSCalendarUnitMinute], NSOrderedAscending);
    
    XCTAssertEqual([self.calendar compareDate:date2 toDate:date1 toUnitGranularity:NSCalendarUnitSecond], NSOrderedDescending);
    XCTAssertEqual([self.calendar compareDate:date2 toDate:date1 toUnitGranularity:NSCalendarUnitMinute], NSOrderedDescending);
    
    XCTAssertEqual([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:NSCalendarUnitHour], NSOrderedSame);
    XCTAssertEqual([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:NSCalendarUnitDay],  NSOrderedSame);
    XCTAssertEqual([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:NSCalendarUnitWeekday], NSOrderedSame);
    XCTAssertEqual([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:NSCalendarUnitWeekOfYear], NSOrderedSame);
    XCTAssertEqual([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:NSCalendarUnitMonth], NSOrderedSame);
    XCTAssertEqual([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:NSCalendarUnitYear], NSOrderedSame);
    XCTAssertEqual([self.calendar compareDate:date1 toDate:date2 toUnitGranularity:NSCalendarUnitEra], NSOrderedSame);
    
    
}

- (void)testDateInToday
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    NSDate *today = [NSDate date];
    NSDate *tomorrow = [self.calendar dateByAddingComponents:components toDate:today options:0];
    components.day = -1;
    NSDate *yesterday = [self.calendar dateByAddingComponents:components toDate:today options:0];
    
    XCTAssertTrue([self.calendar isDateInToday:today]);
    XCTAssertFalse([self.calendar isDateInToday:tomorrow]);
    XCTAssertFalse([self.calendar isDateInToday:yesterday]);
}

- (void)testDateInYesterday
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    NSDate *today = [NSDate date];
    NSDate *tomorrow = [self.calendar dateByAddingComponents:components toDate:today options:0];
    components.day = -1;
    NSDate *yesterday = [self.calendar dateByAddingComponents:components toDate:today options:0];
    
    XCTAssertTrue([self.calendar isDateInYesterday:yesterday]);
    XCTAssertFalse([self.calendar isDateInYesterday:today]);
    XCTAssertFalse([self.calendar isDateInYesterday:tomorrow]);
}

- (void)testDateInTomorrow
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    NSDate *today = [NSDate date];
    NSDate *tomorrow = [self.calendar dateByAddingComponents:components toDate:today options:0];
    components.day = -1;
    NSDate *yesterday = [self.calendar dateByAddingComponents:components toDate:today options:0];
    
    XCTAssertTrue([self.calendar isDateInTomorrow:tomorrow]);
    XCTAssertFalse([self.calendar isDateInTomorrow:today]);
    XCTAssertFalse([self.calendar isDateInTomorrow:yesterday]);
}

- (void)testDateCreation
{
    XCTAssertNoThrow([self.calendar dateWithEra:1123123123 year:123123123 month:123123 day:123123123 hour:11231230 minute:1333330 second:333123123 nanosecond:791823120]);
    XCTAssertNoThrow([self.calendar dateWithEra:-1123123123 year:-123123123 month:-123123 day:-123123123 hour:-11231230 minute:-1333330 second:-333123123 nanosecond:-791823120]);
    XCTAssertNoThrow([self.calendar dateWithEra:NSNotFound year:NSNotFound month:NSNotFound day:NSNotFound hour:NSNotFound minute:NSNotFound second:NSNotFound nanosecond:NSNotFound]);
    
    XCTAssertNoThrow([self.calendar dateWithEra:1123123123 yearForWeekOfYear:123123123 weekOfYear:123123 weekday:123123123 hour:11231230 minute:1333330 second:333123123 nanosecond:791823120]);
    XCTAssertNoThrow([self.calendar dateWithEra:-1123123123 yearForWeekOfYear:-123123123 weekOfYear:-123123 weekday:-123123123 hour:-11231230 minute:-1333330 second:-333123123 nanosecond:-791823120]);
    XCTAssertNoThrow([self.calendar dateWithEra:NSNotFound yearForWeekOfYear:NSNotFound weekOfYear:NSNotFound weekday:NSNotFound hour:NSNotFound minute:NSNotFound second:NSNotFound nanosecond:NSNotFound]);
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:@"2016-10-10 10:10:10"];
    NSDate *date2 = [self.calendar dateWithEra:1 year:2016 month:10 day:10 hour:10 minute:10 second:10 nanosecond:0];
    XCTAssertEqualObjects(date1, date2);
    NSDate *date3 = [formatter dateFromString:@"2016-10-10 10:10:11"];
    XCTAssertNotEqualObjects(date3, date2);
}

- (void)test_NSDateComponents_valueForComponent
{
    [self.units1 enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.components valueForComponent:obj.unsignedIntegerValue]);
    }];
    [self.units2 enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.components valueForComponent:obj.unsignedIntegerValue]);
    }];
    [self.errorUnits enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.components valueForComponent:obj.unsignedIntegerValue]);
    }];
    
    
    [self.errorUnits enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertEqual(NSNotFound, [self.components valueForComponent:obj.unsignedIntegerValue]);
    }];
    
    NSDateComponents *components1 = [[NSDateComponents alloc] init];
    components1.era = 100;
    components1.year = 2015;
    components1.month = 10;
    components1.day = 11;
    components1.hour = 12;
    components1.minute = 13;
    components1.second = 14;
    components1.nanosecond = 15;
    XCTAssertEqual([components1 valueForComponent:NSCalendarUnitEra], 100);
    XCTAssertEqual([components1 valueForComponent:NSCalendarUnitYear], 2015);
    XCTAssertEqual([components1 valueForComponent:NSCalendarUnitMonth], 10);
    XCTAssertEqual([components1 valueForComponent:NSCalendarUnitDay], 11);
    XCTAssertEqual([components1 valueForComponent:NSCalendarUnitHour], 12);
    XCTAssertEqual([components1 valueForComponent:NSCalendarUnitMinute], 13);
    XCTAssertEqual([components1 valueForComponent:NSCalendarUnitSecond], 14);
    XCTAssertEqual([components1 valueForComponent:NSCalendarUnitNanosecond], 15);

    
    NSDateComponents *components2 = [[NSDateComponents alloc] init];
    components2.era = 102;
    components2.yearForWeekOfYear = 2015;
    components2.weekOfYear = 10;
    components2.weekday = 11;
    components2.hour = 12;
    components2.minute = 13;
    components2.second = 14;
    components2.nanosecond = 15;
    XCTAssertEqual([components2 valueForComponent:NSCalendarUnitEra], 102);
    XCTAssertEqual([components2 valueForComponent:NSCalendarUnitYearForWeekOfYear], 2015);
    XCTAssertEqual([components2 valueForComponent:NSCalendarUnitWeekOfYear], 10);
    XCTAssertEqual([components2 valueForComponent:NSCalendarUnitWeekday], 11);
    XCTAssertEqual([components2 valueForComponent:NSCalendarUnitHour], 12);
    XCTAssertEqual([components2 valueForComponent:NSCalendarUnitMinute], 13);
    XCTAssertEqual([components2 valueForComponent:NSCalendarUnitSecond], 14);
    XCTAssertEqual([components2 valueForComponent:NSCalendarUnitNanosecond], 15);
    
    
    NSDateComponents *components3 = [[NSDateComponents alloc] init];
    components3.weekdayOrdinal = 1111;
    components3.weekOfMonth = 4444;
    XCTAssertEqual([components3 valueForComponent:NSCalendarUnitWeekdayOrdinal], 1111);
    XCTAssertEqual([components3 valueForComponent:NSCalendarUnitWeekOfMonth], 4444);
    

}

- (void)test_NSDateComponents_setValueForComponent
{
    [self.units1 enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.components setValue:123 forComponent:obj.unsignedIntegerValue]);
        XCTAssertNoThrow([self.components setValue:-123 forComponent:obj.unsignedIntegerValue]);
        XCTAssertNoThrow([self.components setValue:0 forComponent:obj.unsignedIntegerValue]);
    }];
    [self.units2 enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.components setValue:123 forComponent:obj.unsignedIntegerValue]);
        XCTAssertNoThrow([self.components setValue:-123 forComponent:obj.unsignedIntegerValue]);
        XCTAssertNoThrow([self.components setValue:0 forComponent:obj.unsignedIntegerValue]);
    }];
    [self.errorUnits enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertNoThrow([self.components setValue:123 forComponent:obj.unsignedIntegerValue]);
        XCTAssertNoThrow([self.components setValue:-123 forComponent:obj.unsignedIntegerValue]);
        XCTAssertNoThrow([self.components setValue:0 forComponent:obj.unsignedIntegerValue]);
    }];
    
    
    NSDateComponents *components1 = [[NSDateComponents alloc] init];
    [components1 setValue:123 forComponent:NSCalendarUnitEra];
    [components1 setValue:321 forComponent:NSCalendarUnitYear];
    [components1 setValue:10 forComponent:NSCalendarUnitMonth];
    [components1 setValue:11 forComponent:NSCalendarUnitDay];
    [components1 setValue:12 forComponent:NSCalendarUnitHour];
    [components1 setValue:13 forComponent:NSCalendarUnitMinute];
    [components1 setValue:14 forComponent:NSCalendarUnitSecond];
    [components1 setValue:15 forComponent:NSCalendarUnitNanosecond];
    XCTAssertEqual(components1.era, 123);
    XCTAssertEqual(components1.year, 321);
    XCTAssertEqual(components1.month, 10);
    XCTAssertEqual(components1.day, 11);
    XCTAssertEqual(components1.hour, 12);
    XCTAssertEqual(components1.minute, 13);
    XCTAssertEqual(components1.second, 14);
    XCTAssertEqual(components1.nanosecond, 15);
    
    
    NSDateComponents *components2 = [[NSDateComponents alloc] init];
    [components2 setValue:1234 forComponent:NSCalendarUnitEra];
    [components2 setValue:4321 forComponent:NSCalendarUnitYearForWeekOfYear];
    [components2 setValue:10 forComponent:NSCalendarUnitWeekOfYear];
    [components2 setValue:11 forComponent:NSCalendarUnitWeekday];
    [components2 setValue:12 forComponent:NSCalendarUnitHour];
    [components2 setValue:13 forComponent:NSCalendarUnitMinute];
    [components2 setValue:14 forComponent:NSCalendarUnitSecond];
    [components2 setValue:15 forComponent:NSCalendarUnitNanosecond];
    XCTAssertEqual(components2.era, 1234);
    XCTAssertEqual(components2.yearForWeekOfYear, 4321);
    XCTAssertEqual(components2.weekOfYear, 10);
    XCTAssertEqual(components2.weekday, 11);
    XCTAssertEqual(components2.hour, 12);
    XCTAssertEqual(components2.minute, 13);
    XCTAssertEqual(components2.second, 14);
    XCTAssertEqual(components2.nanosecond, 15);
    
    
    NSDateComponents *components3 = [[NSDateComponents alloc] init];
    [components3 setValue:2222 forComponent:NSCalendarUnitWeekdayOrdinal];
    [components3 setValue:6666 forComponent:NSCalendarUnitWeekOfMonth];
    XCTAssertEqual(components3.weekdayOrdinal, 2222);
    XCTAssertEqual(components3.weekOfMonth, 6666);

}

@end
