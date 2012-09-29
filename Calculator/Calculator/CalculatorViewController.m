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

float runningTotal, numberOnScreen;
NSString *operation, *nextOperation;
BOOL operatorButtonWasJustPressed;


- (IBAction)numberPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    NSString *currentDisplay = display.text;
    if ([currentDisplay isEqualToString:@"0"] || operatorButtonWasJustPressed){
        self.display.text = digit;
        operatorButtonWasJustPressed = NO;
    }
    else {
        self.display.text = [currentDisplay stringByAppendingString:digit];
        numberOnScreen = [display.text floatValue]; 

    }
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
    nextOperation = [sender currentTitle];
    operatorButtonWasJustPressed = YES;
    if ([operation isEqualToString:@""]){
        runningTotal = [display.text floatValue];
    }
    if ([operation isEqualToString:@"+"]){
        runningTotal += numberOnScreen;
    }
    if ([operation isEqualToString:@"-"]){
        runningTotal -= numberOnScreen;
    }
    if ([operation isEqualToString:@"x"]){
        runningTotal *= numberOnScreen;
    }
    if([operation isEqualToString:@"/"]){
        if (numberOnScreen == 0.0){
            display.text = @"Err";
            runningTotal = 0;
            numberOnScreen = 0;
        }
        else
            runningTotal /= numberOnScreen;
    }
    display.text = [NSString stringWithFormat:@"%f", runningTotal];
    
    // EQUAL button was pressed
    if ([nextOperation isEqualToString:@"="]){
//        numberOnScreen = 0;
//        runningTotal = 0;
//        operation = @"";
    }
    else {
        operation = nextOperation;
    }
    
}
- (IBAction)equalPressed:(UIButton *)sender {
    operatorButtonWasJustPressed = YES;
    display.text = [NSString stringWithFormat:@"%f", runningTotal];
    numberOnScreen = 0;
    runningTotal = 0;
    operation = @"";
    
}

- (IBAction)backSpacePressed:(UIButton *)sender {
    if (display.text.length > 1){
        display.text = [display.text substringToIndex:display.text.length - 1];
    }
    else {
        display.text = @"0";
    }
    numberOnScreen = [display.text floatValue];
}

- (IBAction)clearAllPressed:(UIButton *)sender {
    display.text = @"0";
    numberOnScreen = 0;
    runningTotal = 0;
    operation = @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    runningTotal = 0;
    numberOnScreen = 0;
    operation = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {

    
}

@end
