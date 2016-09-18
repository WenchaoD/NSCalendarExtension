//
//  NSDateComponents+NSCalendarExtension.h
//  NSCalendarExtension
//
//  Created by dingwenchao on 9/15/16.
//  Copyright © 2016 dingwenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __NSCALENDAR_ALLOWS_COMPILE_INJECTING

@interface NSDateComponents (NSCalendarExtension)

/**
 
 - (void)setValue:(NSInteger)value forComponent:(NSCalendarUnit)unit;
 
 - (NSInteger)valueForComponent:(NSCalendarUnit)unit;
 
 */


@end

#endif
