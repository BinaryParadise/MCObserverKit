//
//  ObserveRegister.h
//  XMPPPressureTest
//
//  Created by odyang on 17/2/9.
//  Copyright © 2017年 maintoco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOKObject.h"

/**
 绑定对象
 */
@interface MOKBinding : NSObject

- (id)initWithTarget:(id)target;

/// 绑定订阅属性改变事件 keyPath 值改变时改变对应的属性
- (void)setObject:(MOKObject *)observer forKeyedSubscript:(NSString *)keyPath;

@end
