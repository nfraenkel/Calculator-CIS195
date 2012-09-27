//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Nathan Fraenkel on 9/27/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

@synthesize display;

float total, other;
NSString* operation;


- (IBAction)numberPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    NSString *currentDisplay = display.text;
    if ([currentDisplay isEqualToString:@"0"])
        self.display.text = digit;
    else
        self.display.text = [currentDisplay stringByAppendingString:digit];
}
- (IBAction)dotPressed:(UIButton *)sender {
    NSString *currentDisplay = display.text;
    BOOL hasPeriodAlready = FALSE;
    // iterate through current display to see if a '.' is already there.
    for (int i = 0; i < currentDisplay.length; i++){
        char c = [currentDisplay characterAtIndex:i];
        if (c == '.'){
            hasPeriodAlready = TRUE;
            break;
        }
    }
    if (!hasPeriodAlready)
        display.text = [currentDisplay stringByAppendingString:@"."];
}
- (IBAction)operatorPressed:(UIButton *)sender {
    operation = [sender currentTitle];
    
    
}
- (IBAction)equalPressed:(UIButton *)sender {
    
}

- (IBAction)clearPressed:(UIButton *)sender {
    display.text = @"0";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
