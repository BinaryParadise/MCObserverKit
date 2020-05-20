//
//  MCSingletonViewController.m
//  MCObserverKit_Example
//
//  Created by Rake Yang on 2020/5/20.
//  Copyright © 2020 mylcode. All rights reserved.
//

#import "MCSingletonViewController.h"
#import "MCObserverViewModel.h"
#import <MCObserverKit/MCObserverKit.h>
static MCObserverViewModel *vm;

@interface MCSingletonViewController ()

@end

@implementation MCSingletonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!vm) {
        vm = [MCObserverViewModel new];
    }
    [MCObserver(vm, inputText) valueChanged:^(id target, id value) {
        NSLog(@"%@", value);
    }];
    
    vm.inputText = @"静态对象";
}

- (void)dealloc {
    [MOKObject removeObserver:vm];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
