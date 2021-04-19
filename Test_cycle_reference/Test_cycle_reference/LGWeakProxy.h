//
//  LGWeakProxy.h
//  Test_cycle_reference
//
//  Created by 黄明族 on 2021/4/19.
//  仿写自YYWeakProxy

/** 消息转发流程
 * 1. dynamic method resolution 动态方法解析 调用以下两个方法，对其进行解析，动态增加方法
 *  对应：+(BOOL)resolveInstanceMethod:(SEL)sel; +(BOOL)resolveClassMethod:(SEL)sel
 * 2. fast forwarding 没有其他对象能处理此消息
 *  -(id)forwardingTargetForSelector:(SEL)aSelector;
 * 3. normal forwarding 运行期系统会把与消息有关的全部细节，都封装到 NSInvocation 对象中，再给接收者最后一次机会，令其设法解决当前还未处理的消息
 *  -(NSMethodSignature *)methodSignatureForSelector:(SEL)selector;
 *  -(void)forwardInvocation:(NSInvocation *)invocation;
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGWeakProxy : NSProxy

@property (nullable, nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
