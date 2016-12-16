//
//  NSTimer+NSCalendarExtension.h
//  NSCalendarExtension
//
//  Created by dingwenchao on 19/11/2016.
//  Copyright © 2016 dingwenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSTIMER_BACKWARD_SUPPORT (__IPHONE_OS_VERSION_MIN_REQUIRED < 100000 && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000)

#if NSTIMER_BACKWARD_SUPPORT

@interface NSTimer (NSCalendarExtension)

/**
 + (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;
 
 + (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;
  
 */

@end


// @see https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/Foundation.framework/_NSTimerBlockTarget.h
@interface __NSTimerBlockTarget : NSObject {
    void(^_block)(id);
}
- (instancetype)initWithBlock:(void(^)(id))block;
- (void)fire:(id)arg1;

@end

#endif
