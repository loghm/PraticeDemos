//
//  AViewController.m
//  Test_cycle_reference
//
//  Created by 黄明族 on 2021/4/19.
//

#import "AViewController.h"
#import "LGWeakProxy.h"
#import "NSTimer+WeakTimer.h"

@interface AViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    NSLog(@"......started");
    [self useBlock];
//    [self useWeakProxy];
}

/** 通过 category 把 NSTimer 的 target 设置为 NSTimer 类，让 NSTimer 自身做为target, 把 selector 通过 block 传入给 NSTimer，在 NSTimer 的 category 里面触发 selector
 * 这样也可以达到 NSTimer 不直接持有 TimerViewController 的目的，实现更优雅 ( 如果是直接支持 iOS 10 以上的系统版本，那可以使用 iOS 10新增的系统级 block 方案 )。
 * timer为self强引用，但是timer并没有持有self，这样就可以解除循环引用，如果在block中需要使用self，需要使用 __weak typedef(self)weakSelf = self;
 */
- (void)useBlock {
    self.timer = [NSTimer lg_scheduledTimerWithTimeInterval:1 repeats:YES handleBlock:^(NSTimer * _Nonnull timer) {
        NSLog(@"block_timer...");
    }];
}

/** 使用消息转发，用一个weak的target来作为timer的target
 */
- (void)useWeakProxy {
    LGWeakProxy *proxy = [LGWeakProxy proxyWithTarget:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:proxy selector:@selector(task:) userInfo:nil repeats:YES];
}

- (void)task:(NSTimer *)timer {
    NSLog(@"userinfo:....%@", timer.userInfo);
}

- (void)dealloc {
    if (self.timer) {
        [self.timer invalidate];
        NSLog(@"timer dealloc.");
    }
}

@end
