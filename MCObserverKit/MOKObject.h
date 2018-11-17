//
//  MOKObject.h
//
//  Created by 小风 on 15/2/6.
//  Copyright (c) 2015年 maintoco. All rights reserved.
//  键值观察响应式编程框架
//  Key-Value Observing Reactive (.abbr orc)

static void *observerContext = &observerContext;

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MOKBindingModeNone, //默认
    MOKBindingModeSingle = MOKBindingModeNone, //单向
    MOKBindingModeReversible //双向
} MOKBindingMode;

/**
 观察者
 */
@interface MOKObject : NSObject
/**
 观察目标
 */
@property (nonatomic, assign) id target;

/**
 要观察的属性
 */
@property (nonatomic, copy) NSString *keyPath;

/**
 是否已注册观察者
 */
@property (nonatomic, assign) BOOL isObserved;

/**
 观察模式
 */
@property (nonatomic, assign) MOKBindingMode mode;

/**
 初始化一个观察者对象
 */
- (instancetype)initWithTarget:(id)target keyPath:(NSString *)keypath mode:(MOKBindingMode)mode;
/**
 注册观察者
 */
- (void)registerObserver;

/**
 移除观察者,单例对象必须调用
 */
+ (void)removeObserver:(id)object;

/**
 设置值改变要做相应改变的对象
 */
- (void)setKeyPath:(NSString *)keyPath onObject:(MOKObject *)object;

/**
 订阅属性值改变时要执行的block
 */
- (instancetype)valueChanged:(void (^)(id target,id value))block;

/**
 订阅属性值改变时要执行的block和需要满足条件的block
 */
- (void)valueChanged:(void (^)(id target,id value))block condition:(BOOL (^)(id target,id value))condition;


/**
 添加目标属性值改变时的回调函数

 @param target 目标
 @param action 函数，示例
 - (void)valueChange:(id)value;
 */
- (instancetype)addTarget:(id)target action:(SEL)action;

@end
