//
//  NSTimer+WeakTimer.m
//  Test_cycle_reference
//
//  Created by 黄明族 on 2021/4/19.
//

#import "NSTimer+WeakTimer.h"

@implementation NSTimer (WeakTimer)

+ (NSTimer *)lg_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats handleBlock:(void(^)(NSTimer *timer))handler {
    return [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(handleBlockInvoke:) userInfo:[handler copy] repeats:YES];
}

+ (void)handleBlockInvoke:(NSTimer *)timer {
    void(^block)(NSTimer *) = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
