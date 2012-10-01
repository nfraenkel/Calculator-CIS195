//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Nathan Fraenkel on 9/27/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@property NSString *operation, *operation2, *nextOperation;

@end

@implementation CalculatorViewController

@synthesize display, operatorDisplay;
@synthesize operation, operation2, nextOperation;

float runningTotal, numberOnScreen, extraNumber;
BOOL operatorButtonWasJustPressed, equalButtonWasPressed;

// action carried out when: any number is pressed
- (IBAction)numberPressed:(UIButton *)sender {
    // corner case
    if ([nextOperation isEqualToString:@"="]){
        nextOperation = @"";
        operation = @"";
        operatorDisplay.text = @"";
    }
    NSString *digit = [sender currentTitle];
    NSString *currentDisplay = display.text;
    if ([currentDisplay isEqualToString:@"0"] || operatorButtonWasJustPressed){
        self.display.text = digit;
        operatorButtonWasJustPressed = NO;
    }
    else {
        self.display.text = [currentDisplay stringByAppendingString:digit];
    }
    if (![digit isEqualToString:@"."])
        numberOnScreen = [self.display.text floatValue];
}

// action carried out when: "." is pressed
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

// action carried out when: "+" "-" "x" "/" or "=" is pressed
- (IBAction)operatorPressed:(UIButton *)sender {
    nextOperation = [sender currentTitle];
    operatorDisplay.text = nextOperation;
    // CHECK FOR case where we need to do order of operations
    if (!operatorButtonWasJustPressed){
        if (([operation isEqualToString:@"+"] || [operation isEqualToString:@"-"]) && ([nextOperation isEqualToString:@"x"] || [nextOperation isEqualToString:@"/"])){
            operation2 = operation;
            extraNumber = numberOnScreen;
            
            // set display
            display.text = [NSString stringWithFormat:@"%f", numberOnScreen];
        }
        // CARRY OUT order of operations
        else if (([operation2 isEqualToString:@"+"] || [operation2 isEqualToString:@"-"]) && ([operation isEqualToString:@"x"] || [operation isEqualToString:@"/"])){
            float intermediate;
            if ([operation isEqualToString:@"x"])
                intermediate = extraNumber * numberOnScreen;
            else if ([operation isEqualToString:@"/"])
                intermediate = extraNumber / numberOnScreen;
            else
                NSLog(@"ERROR: this should never occur");
            if ([operation2 isEqualToString:@"+"])
                runningTotal += intermediate;
            else if ([operation2 isEqualToString:@"-"])
                runningTotal -= intermediate;
            else
                NSLog(@"ERROR: this, too, should never occur");
            
            // set display
            display.text = [NSString stringWithFormat:@"%f", runningTotal];
        }
        else {
            // otherwise: just 
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
                if ([[NSString stringWithFormat:@"%f", numberOnScreen] isEqualToString:@"0.000000"]){
                    display.text = @"Err";
                    [self clearEverything];
                    return;
                }
                else
                    runningTotal /= numberOnScreen;
            }
            
            // set display
            display.text = [NSString stringWithFormat:@"%f", runningTotal];
        }
    }
    
    // flag that we just pushed an operator
    operatorButtonWasJustPressed = YES;
    
    // set actual operator that will get carried out in next run to be what user just pressed 
    if (![nextOperation isEqualToString:@"="])
        operation = nextOperation;
    
}

// action carried out when: "C" is pressed
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
    operatorDisplay.text = @"";
    [self clearEverything];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    operatorDisplay.text = @"";
    [self clearEverything];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// HELPER METHOD: self explanatory 
-(void)clearEverything {
    runningTotal = 0;
    numberOnScreen = 0;
    extraNumber = 0;
    operation = @"";
    operation2 = @"";
}


@end
