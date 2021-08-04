//
//  MCStandardViewController.m
//  MCObserverKit_Example
//
//  Created by Rake Yang on 2021/8/2.
//  Copyright © 2021 mylcode. All rights reserved.
//

#import "MCStandardViewController.h"
#import "MCObserverViewModel.h"
#import <MCObserverKit/MCObserverKit.h>
#import <MCUIKit/UIView+MCFrameGeometry.h>

@interface MCStandardViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField1;
@property (strong, nonatomic) UITextField *textField2;
@property (nonatomic, strong) MCObserverViewModel *viewModel;

@end

@implementation MCStandardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _viewModel = [MCObserverViewModel new];
    
    self.textField1 = [[UITextField alloc] initWithFrame:CGRectMake(8, 168, self.view.mcWidth-16, 50)];
    self.textField1.delegate = self;
    self.textField1.borderStyle = UITextBorderStyleRoundedRect;
    self.textField1.tintColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textField1];
    
    self.textField2 = [[UITextField alloc] initWithFrame:CGRectMake(8, self.textField1.mcBottom + 30, self.view.mcWidth-16, 50)];
    self.textField2.delegate = self;
    self.textField2.borderStyle = UITextBorderStyleRoundedRect;
    self.textField2.tintColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textField2];

    [self.textField1 addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
#warning ios 11 and later will not crash
    [self.viewModel addObserver:self forKeyPath:@"inputText" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)textDidChanged:(UITextField *)sender {
    self.viewModel.inputText = sender.text;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"observeValueForKeyPath:change");
    id value = change[NSKeyValueChangeNewKey];
    self.textField2.text = value;
}

- (IBAction)showInputText:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:self.viewModel.inputText preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)dealloc {
    self.textField1 = nil;
    self.textField2 = nil;
    NSLog(@"%s", __FUNCTION__);
}
@end
