//
//  NSTimer+WeakTimer.h
//  Test_cycle_reference
//
//  Created by 黄明族 on 2021/4/19.
//

/**
 * 通过 category 把 NSTimer 的 target 设置为 NSTimer 类，让 NSTimer 自身做为target, 把 selector 通过 block 传入给 NSTimer，在 NSTimer 的 category 里面触发 selector
 * 这样也可以达到 NSTimer 不直接持有 TimerViewController 的目的，实现更优雅 ( 如果是直接支持 iOS 10 以上的系统版本，那可以使用 iOS 10新增的系统级 block 方案 )。
 * see also: http://nelson.logdown.com/posts/2017/04/05/how-to-fix-nstimer-retain-cycle https://www.jianshu.com/p/11fae16ab622
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (WeakTimer)

+ (NSTimer *)lg_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats handleBlock:(void(^)(NSTimer *timer))handler;

@end

NS_ASSUME_NONNULL_END
