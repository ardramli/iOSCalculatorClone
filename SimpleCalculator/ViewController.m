//
//  ViewController.m
//  SimpleCalculator
//
//  Created by ardMac on 17/03/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelResult;

@property (strong,nonatomic) IBOutletCollection(UIButton) NSArray *calculatorButtons; //iboutlet untuk semua button terus

//calculation variables
@property (strong, nonatomic) NSString *currentOperator; // store the +,-,x,÷
@property (assign,nonatomic) double savedValue; // saved value
@property (assign,nonatomic) BOOL operatorPressed;
@property (strong,nonatomic) NSNumberFormatter *formatter;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.calculatorButtons objectAtIndex:0];
    
    //read every button in "calculatorButtons"
    for (UIButton *button in self.calculatorButtons) {
        
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [[button layer] setBorderWidth:2.0f];
        [[button layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    }
    self.formatter =[[NSNumberFormatter alloc]init];
    self.formatter.numberStyle = NSNumberFormatterDecimalStyle;
    self.formatter.maximumFractionDigits = 20;
    

}

-(void)buttonPressed:(UIButton *)sender{
    
    //read the button from it's title
    NSString *buttonText = sender.titleLabel.text;
    
    NSArray *numberString= @[@"0", @"1", @"2",@"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    
    NSArray *operatorStrings = @[@"+", @"-", @"X", @"÷"];
    
    //number pressed
    if ([numberString containsObject:buttonText]) {
        if (self.operatorPressed) {
            self.labelResult.text = buttonText;
            self.operatorPressed = NO;

            //[self calculate];
            //calculate
            //update text
            return;
        }
    
    
        if ([self.labelResult.text isEqualToString:@"0"] ) {
            self.labelResult.text =buttonText;
        } else {
        self.labelResult.text =[NSString stringWithFormat:@"%@%@",self.labelResult.text,buttonText];
    }
    }
// "." pressed
    else if ( [buttonText isEqualToString:@"."]){
        if([self.labelResult.text rangeOfString:@"."].location < self.labelResult.text.length){
            return;
        }
        self.labelResult.text = [NSString stringWithFormat:@"%@%@",self.labelResult.text,buttonText];
    }
    //AC pressed
    else if ([buttonText isEqualToString:@"AC"]){
        
        self.labelResult.text = @"0";
        self.operatorPressed = NO;
        self.savedValue = 0.0;
        self.currentOperator = @"";
        
    }
    //operator pressed
    else if ([operatorStrings containsObject:buttonText]) {
        [self calculate];
        self.savedValue = [self.labelResult.text doubleValue];
        self.currentOperator = buttonText;
        self.operatorPressed =YES;
        //do operation
        //store previous value
        //store the current operator
    }
    // = pressed
    else if ([buttonText isEqualToString:@"="]){
        [self calculate];
        self.currentOperator = @"";
        //calculate update
    }
    // % pressed
    else if ([buttonText isEqualToString:@"%"]){
        double percentageValue = [self.labelResult.text doubleValue]/100;
        self.labelResult.text = [self.formatter stringFromNumber:[NSNumber numberWithDouble:percentageValue]];
        //get percantage value
        
    }
    // +/- pressed
    else {
       // self.savedValue = -self.savedValue;
        double minValue = -[self.labelResult.text doubleValue];
        
        self.labelResult.text = [self.formatter stringFromNumber:[NSNumber numberWithDouble:minValue]];
        //convert to its negative value if postive value
        //display
    }
    
    
    
    //literal defining
//    NSArray *numbers = @[];
//    NSNumber *number = [NSNumber numberWithInt:1];
    
}

-(void)calculate {
    double result;
    double currentValue = [self.labelResult.text doubleValue];
    
    if ([self.currentOperator isEqualToString:@"+"]) {
        result = self.savedValue + currentValue;
        
    }else if ([self.currentOperator isEqualToString:@"-"]){
        result = self.savedValue - currentValue;
    }
    else if ([self.currentOperator isEqualToString:@"X"]){
        result = self.savedValue * currentValue;
    }
    else if ([self.currentOperator isEqualToString:@"÷"]){
        result = self.savedValue / currentValue;
    }
    else {return;}
    
    
    self.labelResult.text = [self.formatter stringFromNumber:[NSNumber numberWithDouble:result]];
    
    
//    if (result != 0){
//        self.labelResult.text =@"0";
//    }
    
}








@end
