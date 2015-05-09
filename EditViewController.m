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
    
    [self.scrollview setScrollEnabled:YES];
    [self.scrollview setContentSize:CGSizeMake(320, 800)];
    NSLog(@"Data: %@",_data);
//    NSLog(@"Data: %@",_address_from_map);
    self.type_value.text = [_data[0] valueForKey:@"propertyType"];
    self.address_value.text = [_data[0] valueForKey:@"address"];
    self.city_value.text = [_data[0] valueForKey:@"city"];
    self.state_value.text = [_data[0] valueForKey:@"state"];
    self.zip_value.text = [_data[0] valueForKey:@"zipCode"];
    NSString *converted_amt = [[_data[0] valueForKey:@"loanAmount"] stringValue];
    NSString *converted_payment = [[_data[0] valueForKey:@"downPayment"] stringValue];
    NSString *converted_apr = [[_data[0] valueForKey:@"annualRate"] stringValue];
    NSString *converted_term = [[_data[0] valueForKey:@"payYear"] stringValue];
    //NSString *converted_result = [[_data[0] valueForKey:@"mortgageAmount"] stringValue];
    //NSLog(@"test: %@",test);
    //_amt_input.text = [_amt_input.text stringByAppendingString:test];
    self.amt_input.text = converted_amt;
    self.payment_input.text = converted_payment;
    self.apr_input.text = converted_apr;
    self.term_input.text = converted_term;
    self.result.text = [_data[0] valueForKey:@"mortgageAmount"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)recalculate:(id)sender {
    int termInYears = [self.term_input.text intValue];
    int loanAmount = [self.amt_input.text intValue];
    
//    if (![self validateInputs:@"calculate"])
//        return;
    
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
        NSLog(@"New value: %@",newValue );
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
