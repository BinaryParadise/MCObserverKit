//
//  MOKObject.m
//  libXFWeibo
//
//  Created by 小风 on 15/2/6.
//  Copyright (c) 2015年 maintoco. All rights reserved.
//

#import "MOKObject.h"
#import <objc/runtime.h>
#import "MCLogger.h"

static void *robindingKeys = &robindingKeys;

@interface MOKObject ()

/// 值改变时调用的block
@property (nonatomic, copy) void (^block)(id target,id value);

@property (nonatomic, copy) BOOL (^condition)(id target,id value);

@property (nonatomic, copy) BOOL (^completion)(id target,id value);

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

- (instancetype)initWithTarget:(id)target keyPath:(NSString *)keypath {
    if (!target) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.target = target;
        self.keyPath = keypath;
    }
    return self;
}

- (instancetype)valueChanged:(void (^)(id, id))block {
    self.block = block;
    [self registerObserve];
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
        [self registerObserve];
    }
    return self;
}

- (instancetype)completion:(void (^)(id, id))completion {
    _completion = [completion copy];
    return self;
}

- (void)registerObserve {
    NSMutableDictionary *bindingDict = objc_getAssociatedObject(self.target, robindingKeys);
    if (!bindingDict)         {
        bindingDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self.target, robindingKeys, bindingDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSString *uniqueKey = [NSString stringWithFormat:@"<keyPath=%@,observer=%@>", self.keyPath, self];
    if (![bindingDict.allKeys containsObject:uniqueKey]) {
        MCLogInfo(@"添加观察者：[target=<%@: %p>, keyPath=%@, observer=%@]", [self.target class], self.target, self.keyPath, self);
        [self.target addObserver:self forKeyPath:self.keyPath options: NSKeyValueObservingOptionNew context:observerContext];
        [bindingDict setObject:self forKey:uniqueKey];
        self.isObserved = YES;
    }
}

+ (void)removeObserver:(id)object {
    objc_setAssociatedObject(object, robindingKeys, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setKeyPath:(NSString *)keyPath onObject:(MOKObject *)object nilValue:(id)nilValue {
    self.observeToObject = object;
    weakify(object)
    [self valueChanged:^(id target, id value) {
        id oldValue = [object_weak.target valueForKey:object_weak.keyPath];
        if (![oldValue isEqual:value]) {
            [object_weak.target setValue:value?value:nilValue forKey:object_weak.keyPath];
        }
    }];
    //交由主观察对象去管理
    NSMutableDictionary *bindingDict = objc_getAssociatedObject(object.target, robindingKeys);
    if (bindingDict) {
        if (bindingDict.count == 0) {
            objc_setAssociatedObject(object.target, robindingKeys, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else {
            NSString *uniqueKey = [NSString stringWithFormat:@"<keyPath=%@,observe=%p>",object.keyPath,object];
            MCLogInfo(@"%@交由<%p>管理",uniqueKey,self.target);
            [bindingDict removeObjectForKey:uniqueKey];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context != &observerContext) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    id value = change[@"new"];
    if (self.block) {
        if (!self.condition || self.condition(self.target,value)) {
            self.block(self.target,value);
        }
    }else if(self.changedTarget && self.changedAction) {
        [self.changedTarget performSelectorOnMainThread:self.changedAction withObject:value waitUntilDone:NO];
    }
    if (_completion) {
        _completion(self.target,value);
    }
}

- (void)dealloc {
    @try {
        self.observeToObject = nil;
        if (self.isObserved) {
            [self.target removeObserver:self forKeyPath:self.keyPath];
            MCLogInfo(@"注销观察者：[target=<%@: %p>, keyPath=%@, observer=%@]", [self.target class], self.target, self.keyPath, self);
        }
    }
    @catch (NSException *exception) {
        MCLogError(@"移除失败：%@",exception.reason);
    }
    @finally {
        self.keyPath = nil;
        self.target = nil;
        self.block = nil;
        self.changedTarget = nil;
        self.changedAction = nil;
        self.isObserved = NO;
    }
}

@end
