//
//  ObserveRegister.m
//  XMPPPressureTest
//
//  Created by odyang on 17/2/9.
//  Copyright © 2017年 maintoco. All rights reserved.
//

#import "MOKBinding.h"

@interface MOKBinding ()

/**
 要绑定到的对象
 */
@property (nonatomic, assign) id target;

// A value to use when `nil` is sent on the bound signal.
/**
 当改变的值为nil时使用的值
 */
@property (nonatomic, assign) id nilValue;

@end

@implementation MOKBinding

- (instancetype)initWithTarget:(id)target nilValue:(id)nilValue {
    if (target == nil) {
        return nil;
    }
    self = [super init];
    _target = target;
    _nilValue = nilValue;
    return self;
}

- (void)setObject:(MOKObject *)observer forKeyedSubscript:(NSString *)keyPath {
    MOKObject *leftObject = [[MOKObject alloc] initWithTarget:self.target keyPath:keyPath];
    [leftObject setKeyPath:keyPath onObject:observer nilValue:self.nilValue];
}

@end
