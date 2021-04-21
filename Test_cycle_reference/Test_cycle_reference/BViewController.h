//
//  BViewController.h
//  Test_cycle_reference
//
//  Created by 黄明族 on 2021/4/20.
//

/**
 * block中的循环引用
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

/// Tips:
///  1. ...和__VA_ARGS__
///     传入参数有多个，用...表示不确定参数个数，看看NSLog的定义：NSLog(NSString *format, ...)在宏里也可以用...来表示多个参数，而__VA_ARGS__就对应多个参数的部分。举个例子，你觉得NSLog太难看，想造一个自己的log打印函数，比如Zlog你就可以这么写：#define Zlog(...) NSLog(__VA_ARGS__)
///  2. ## 宏连接符
///     宏定义为#define XLink(n) x_ ## n，这宏的意思是把x和传入的n连接起来书写:即 x_n
/// 关于@weakify支持多参数的例子可以参考RAC的实现 see also：https://www.jianshu.com/p/4278cf51a780
