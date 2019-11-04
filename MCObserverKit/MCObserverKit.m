//
//  MCObserverKit.m
//
//  Created by Rake Yang on 17/2/9.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import "MCObserverKit.h"
#import <objc/runtime.h>

@implementation MCObserverKit

+ (void)setDebugMode:(BOOL)debugMode {
    objc_setAssociatedObject(self, @selector(debugMode), @(debugMode), OBJC_ASSOCIATION_ASSIGN);
}

+ (BOOL)debugMode {
    return objc_getAssociatedObject(self, _cmd);
}

@end
