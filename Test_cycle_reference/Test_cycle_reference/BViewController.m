//
//  BViewController.m
//  Test_cycle_reference
//
//  Created by 黄明族 on 2021/4/20.
//

#import "BViewController.h"

@interface BViewController () {
    BOOL _justBool;
}

@property (nonatomic, copy) NSString *string;

@property (nonatomic, copy) void(^block)(void);

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.string = @"aaaaa";
    _justBool = YES;
    
//    __weak typeof(self) weakSelf = self;
//    self.block = ^{
//        NSLog(@"%@", weakSelf.string);
//    };
    
    [self useWeakify];
}

/// 内部继续使用strongSelf强引用的意义在于，当引用这个block的对象被释放的时候，weakSelf为nil，执行会有问题。block内进行强引用，首先block 只持有外部的强引用，内部的强引用并不会被block持有。这样可以保证weakSelf在block执行期间，不被释放，从而导致我们向一个空的对象发送消息。
/// see also: https://www.jianshu.com/p/bc794fa07167
/**
 __weak typeof(self) weakSelf = self;
 self.block = ^{
     __strong typeof(weakSelf) strongSelf = weakSelf;
     NSLog(@"string:...%@, justBool:...%d", self.string, self->_justBool);
 };
 */
- (void)useWeakify {
    @weakify(self);
    self.block = ^{
        @strongify(self);
        NSLog(@"string:...%@, justBool:...%d", self.string, self->_justBool);
    };
}

- (void)dealloc {
    NSLog(@"%@ 释放了", NSStringFromClass([self class]));
}

@end
