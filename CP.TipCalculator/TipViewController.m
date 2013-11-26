//
//  TipViewController.m
//  CP.TipCalculator
//
//  Created by Jonathan Xu on 11/25/13.
//  Copyright (c) 2013 Jonathan Xu. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UITextField *splitTextField;
@property (weak, nonatomic) IBOutlet UILabel *perPersonLabel;

- (IBAction)onTap:(id)sender;
- (void)updateValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator - JX";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    // get bill amount
    float billAmount = [self.billTextField.text floatValue];
    
    // calculate tip and total based on selected tip %
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = billAmount + tipAmount;
    
    float splitValue = [self.splitTextField.text floatValue];
    if (splitValue < 1.0) {
        self.splitTextField.text = @"1";
        splitValue = 1.0;
    }
    float splitPerPerson = ceil(totalAmount / splitValue);
    
    // render results
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    self.perPersonLabel.text = [NSString stringWithFormat:@"$%0.2f", splitPerPerson];
}

@end
