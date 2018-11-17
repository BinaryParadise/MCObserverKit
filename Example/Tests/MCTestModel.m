//
//  MCTestModel.m
//  MCObserverKit_Tests
//
//  Created by lingjing on 2018/11/16.
//  Copyright © 2018年 mylcode. All rights reserved.
//

#import "MCTestModel.h"
#import <MCObserverKit/MCObserverKit.h>

@implementation MCTestModel

+ (void)load {
    [MOKObject removeObserver:self];
}

- (void)targetCallback:(id)value {
    self.text = @"target test";
}

@end
