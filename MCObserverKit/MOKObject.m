//
//  MOKObject.m
//  libXFWeibo
//
//  Created by 小风 on 15/2/6.
//  Copyright (c) 2015年 maintoco. All rights reserved.
//

#import "MOKObject.h"
#import <objc/runtime.h>
#import "MCObserverKit.h"

#define LOG_LEVEL_DEF ddLogLevel

static void *robindingKeys = &robindingKeys;

@interface MOKObject ()

/// 值改变时调用的block
@property (nonatomic, copy) void (^block)(id target,id value);
/// 值改变时需要满足条件的block
@property (nonatomic, copy) BOOL (^condition)(id target,id value);

/**
 关联对象
 */
@property (nonatomic, strong) MOKObject *observeToObject;

/**
 值改变时调用函数的来源
 */
@property (nonatomic, weak) id changedTarget;
/**
 值改变时调用的函数
 */
@property (nonatomic, assign) SEL changedAction;

@end

@implementation MOKObject

- (instancetype)initWithTarget:(id)target keyPath:(NSString *)keypath mode:(MOKBindingMode)mode {
    if (self = [super init]) {
        self.target = target;
        self.keyPath = keypath;
        self.mode = mode;
    }
    return self;
}

- (instancetype)valueChanged:(void (^)(id, id))block {
    self.block = block;
    [self registerObserver];
    return self;
}

- (void)valueChanged:(void (^)(id, id))block condition:(BOOL (^)(id, id))condition {
    self.condition = condition;
    [self valueChanged:block];
}

- (instancetype)addTarget:(id)target action:(SEL)action {
    if (target) {
        self.changedTarget = target;
        self.changedAction = action;
        [self registerObserver];
    }
    return self;
}

- (void)registerObserver {
    NSMutableDictionary *bindingDict = objc_getAssociatedObject(self.target, robindingKeys);
    if (!bindingDict)         {
        bindingDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self.target, robindingKeys, bindingDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSString *uniqueKey = [NSString stringWithFormat:@"[%p.%@ > %p.%@]", self, self.keyPath, self, [self class]];
    if (![bindingDict.allKeys containsObject:uniqueKey]) {
        if ([MCObserverKit debugMode]) {
            NSLog(@"add [%@.%p.%@ > %p]", [self.target class], self.target, self.keyPath, self);
        }
        [self.target addObserver:self forKeyPath:self.keyPath options: NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:observerContext];
        [bindingDict setObject:self forKey:uniqueKey];
        self.isObserved = YES;
    }
}

+ (void)removeObserver:(id)object {
    objc_setAssociatedObject(object, robindingKeys, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setKeyPath:(NSString *)keyPath onObject:(MOKObject *)object {
    self.observeToObject = object;
    __weak typeof(object) object_weak = object;
    [self valueChanged:^(id target, id value) {
        id oldValue = [object_weak.target valueForKey:object_weak.keyPath];
        if (![oldValue isEqual:value]) {
            [object_weak.target setValue:value forKey:object_weak.keyPath];
        }
    }];
    //交由主观察对象去管理
    NSMutableDictionary *bindingDict = objc_getAssociatedObject(object.target, robindingKeys);
    if (bindingDict) {
        NSString *uniqueKey = [NSString stringWithFormat:@"[%p.%@ > %p.%@]", object, self.keyPath, object, [object class]];
        [bindingDict removeObjectForKey:uniqueKey];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == &observerContext) {
        id value = change[@"new"];
        if (self.block) {
            if (!self.condition || self.condition(self.target,value)) {
                self.block(self.target,value);
            }
        } else if(self.changedTarget && self.changedAction) {
            [self.changedTarget performSelectorOnMainThread:self.changedAction withObject:value waitUntilDone:NO];
        }
        return;
    }
}

- (void)dealloc {
    self.observeToObject = nil;
    if (self.isObserved) {
        self.block = nil;
        self.changedTarget = nil;
        self.changedAction = nil;
        self.isObserved = NO;
        @try {
            [self.target removeObserver:self forKeyPath:self.keyPath];
        } @catch (NSException *exception) {
            NSLog(@"%s+%d 移除失败：%@", __FUNCTION__, __LINE__, exception.reason);
        }
        if ([MCObserverKit debugMode]) {
            NSLog(@"remove [%@.%p.%@ > %p]", [self.target class], self.target, self.keyPath, self);
        }
    }
}

@end
