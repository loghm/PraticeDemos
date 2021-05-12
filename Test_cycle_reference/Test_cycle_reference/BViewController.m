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
        if (self) {
            NSLog(@"string:...%@, justBool:...%d", self.string, self->_justBool);
        }
    };
}
//!!!!: 在block内使用->访问成员变量，需要特别注意，是否存在类已经被释放，但是block仍然会走的情况，这时候如果使用->来访问成员变量，就会造成野指针，crash。或者在使用之前，先判断self是否存在,要么就干脆使用属性来访问。
/// 为什么self释放之后，在block中使用self.来访问，不会造成crash，因为self.的本质是getter方法，它是消息机制，向nil发送消息是不会crash的。而->是指向结构体成员的运算符。用处是使用一个指向结构体或对象的指针访问其内成员。如果对象或者结构体被释放了，访问其内成员就会有问题
/// see also: https://blog.csdn.net/qinqi376990311/article/details/79031617

- (void)dealloc {
    NSLog(@"%@ 释放了", NSStringFromClass([self class]));
}

@end
