//
//  MCObserverKit.h
//
//  Created by mylcode on 17/2/9.
//  Copyright © 2017年 MC-Studio. All rights reserved.
//

/**
 对象KVO快速注册关联,单利模式请手动移除观察者
 */
#import <MCFoundation/MCFoundation.h>
#import "MOKBinding.h"

#define MCBinding(TARGET, ...) \
macro_if_eq(1, macro_argcount(__VA_ARGS__))(_OKit_(TARGET, __VA_ARGS__, nil))(_OKit_(TARGET, __VA_ARGS__))

#define _OKit_(TARGET, KEYPATH, NILVALUE) \
[[MOKBinding alloc] initWithTarget:(TARGET) nilValue:(NILVALUE)][@keypath(TARGET, KEYPATH)]

#define MCObserver(TARGET, KEYPATH) \
[[MOKObject alloc] initWithTarget:TARGET keyPath:@keypath(TARGET, KEYPATH)]
