//
//  EditViewController.m
//  MortgageCalculator
//
//  Created by Sophia Ngo on 5/8/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController
- (void) tapped
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calculate_btn.layer.borderWidth = 0.5f;
    self.calculate_btn.layer.cornerRadius = 10;
    self.calculate_btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.update_btn.layer.borderWidth = 0.5f;
    self.update_btn.layer.cornerRadius = 10;
    self.update_btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.type_value.text = [_data[0] valueForKey:@"propertyType"];
    self.address_value.text = [_data[0] valueForKey:@"address"];
    self.city_value.text = [_data[0] valueForKey:@"city"];
    self.state_value.text = [_data[0] valueForKey:@"state"];
    self.zip_value.text = [_data[0] valueForKey:@"zipCode"];
    NSString *converted_amt = [[_data[0] valueForKey:@"loanAmount"] stringValue];
    NSString *converted_payment = [[_data[0] valueForKey:@"downPayment"] stringValue];
    NSString *converted_apr = [[_data[0] valueForKey:@"annualRate"] stringValue];
    NSString *converted_term = [[_data[0] valueForKey:@"payYear"] stringValue];
    self.amt_input.text = converted_amt;
    self.payment_input.text = converted_payment;
    self.apr_input.text = converted_apr;
    self.term_input.text = converted_term;
    self.result.text = [_data[0] valueForKey:@"mortgageAmount"];
    
    // scrollview
    self.scrollview.contentSize = CGSizeMake(320, 1200);
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    [_scrollview addGestureRecognizer:tapScroll];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)recalculate:(id)sender {
    int termInYears = [self.term_input.text intValue];
    int loanAmount = [self.amt_input.text intValue];
  
    double interestRate = [self.apr_input.text doubleValue] / 100.0;
    double monthlyRate = interestRate / 12.0;
    
    int termInMonths = termInYears * 12;
    
    // M = P[i(1+i)^n]/[(1+i)^n -1]
    double monthlyPayment = loanAmount * ((monthlyRate * pow(1 + monthlyRate, termInMonths)) / (pow(1 + monthlyRate, termInMonths) - 1));
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:monthlyPayment]];
    
    [self.result setText:numberAsString];
}

- (IBAction)update:(id)sender {
    
    [self recalculate:self];
    // Update Data
    int loanAmount = [self.amt_input.text intValue];
    int downPayment = [self.payment_input.text intValue];
    double annualRate = [self.apr_input.text doubleValue];
    int payYear = [self.term_input.text intValue];
    NSString* mortgageAmount = self.result.text;
    NSString* address = self.address_value.text;
    
    DBManager* dbManager = [DBManager getSharedInstance];
    BOOL success = [dbManager updateData:address :loanAmount :downPayment :annualRate :payYear :mortgageAmount];

    if (success == YES) {
        NSArray *newValue;
        newValue = [dbManager getDataByAddress:address];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Data updated successfully."
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Data updated failed."
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

}

@end
