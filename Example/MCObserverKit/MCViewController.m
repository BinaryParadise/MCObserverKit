//
//  MCViewController.m
//  MCObserverKit
//
//  Created by mylcode on 01/15/2018.
//  Copyright (c) 2018 mylcode. All rights reserved.
//

#import "MCViewController.h"
#import <MCObserverKit/MCObserverKit.h>
#import "MCObserverViewModel.h"
#import <MCUIKit/UIView+MCFrameGeometry.h>

@interface MCViewController () <UITextFieldDelegate>
@property (strong, nonatomic) UITextField *textField1;
@property (strong, nonatomic) UITextField *textField2;
@property (nonatomic, strong) MCObserverViewModel *viewModel;

@end

@implementation MCViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
    MCBinding(self.textField1, text) = MCObserver(self.viewModel, inputText);
//    [MCObserver(self.textField1, text) valueChanged:^(id target, id value) {
//        MCLogDebug(@"%@", value);
//        strongify(self);
//        self.textField2.text = value;
//    }];
}

- (void)textDidChanged:(UITextField *)sender {
    _textField2.text = sender.text;
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
