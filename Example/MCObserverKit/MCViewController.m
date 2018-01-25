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

@interface MCViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (nonatomic, strong) MCObserverViewModel *viewModel;

@end

@implementation MCViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    MCLogDebug(@"%@", self);
    _viewModel = [MCObserverViewModel new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //[self.textField1 addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    //UITextFiled貌似内存没有被释放
    //MCBinding(self.textField1, text) = MCObserver(self.viewModel, inputText);
    [MCObserver(self.viewModel, inputText) valueChanged:^(id target, id value) {
        MCLogDebug(@"%@", value);
    }];
}

- (IBAction)textDidChanged:(UITextField *)sender {
    //_textField2.text = sender.text;
}

- (IBAction)showInputText:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:self.viewModel.inputText preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)dealloc {
    MCLogWarn(@"");
}

@end
