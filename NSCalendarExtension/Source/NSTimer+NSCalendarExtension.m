//
//  NSTimer+NSCalendarExtension.m
//  NSCalendarExtension
//
//  Created by dingwenchao on 19/11/2016.
//  Copyright © 2016 dingwenchao. All rights reserved.
//

#import "NSTimer+NSCalendarExtension.h"
#import "NSCalendarExtensionControlCenter.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#if NSTIMER_BACKWARD_SUPPORT

NS_ASSUME_NONNULL_BEGIN

/** 
 + (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;
 */
NSTimer *__ns_timerWithTimeInterval_repeats_block(id self, SEL _cmd, NSTimeInterval interval, BOOL repeats,void (^block)(id)) {
    __NSTimerBlockTarget *target = [[__NSTimerBlockTarget alloc] initWithBlock:block];
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:target selector:@selector(fire:) userInfo:nil repeats:repeats];
    return timer;
}

/**
 + (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;
 */
NSTimer *__ns_scheduledTimerWithTimeInterval_repeats_block(id self, SEL _cmd, NSTimeInterval interval, BOOL repeats, void (^block)(id)) {
    __NSTimerBlockTarget *target = [[__NSTimerBlockTarget alloc] initWithBlock:block];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:target selector:@selector(fire:) userInfo:nil repeats:repeats];
    return timer;
}

NS_ASSUME_NONNULL_END

@implementation NSTimer (NSCalendarExtension)

+ (void)load
{
    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    if (systemVersion < 10.0 && systemVersion >= 7.0) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self __ns_forceInjecting];
        });
    }
}

+ (void)__ns_forceInjecting
{
    __ns_inject_function(object_getClass(self), NSSelectorFromString(@"timerWithTimeInterval:repeats:block:"), __ns_timerWithTimeInterval_repeats_block);
    __ns_inject_function(object_getClass(self), NSSelectorFromString(@"scheduledTimerWithTimeInterval:repeats:block:"), __ns_scheduledTimerWithTimeInterval_repeats_block);
}

@end


@implementation __NSTimerBlockTarget

- (void)fire:(id)arg1
{
    if (_block) {
        _block(arg1);
    }
}

- (instancetype)initWithBlock:(void(^)(id))block
{
    self = [super init];
    if (self) {
        _block = block;
    }
    return self;
}

@end

#endif



