//
//  MCViewController.m
//  MCObserverKit
//
//  Created by mylcode on 01/15/2018.
//  Copyright (c) 2018 mylcode. All rights reserved.
//

#import "MCViewController.h"
#import <MCObserverKit/MCObserverKit.h>

@interface MCViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;

@end

@implementation MCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.textField1 addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    MCBinding(self.textField1, text) = MCObserver(self.textField2, text);
}

- (IBAction)textDidChanged:(UITextField *)sender {
    //_textField2.text = sender.text;
}

@end
