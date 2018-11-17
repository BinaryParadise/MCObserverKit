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
 要绑定目标对象
 */
@property (nonatomic, assign) id target;

@end

@implementation MOKBinding

- (instancetype)initWithTarget:(id)target {
    if(self = [super init]) {
        _target = target;
    }
    return self;
}

- (void)setObject:(MOKObject *)observer forKeyedSubscript:(NSString *)keyPath {
    MOKObject *leftObject = [[MOKObject alloc] initWithTarget:self.target keyPath:keyPath mode:MOKBindingModeNone];
    [leftObject setKeyPath:keyPath onObject:observer];
    if (observer.mode == MOKBindingModeReversible) {
        [observer setKeyPath:keyPath onObject:leftObject];
    }
}

@end
