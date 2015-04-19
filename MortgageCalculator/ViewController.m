//
//  ViewController.m
//  MortgageCalculator
//
//  Created by Sophia Ngo on 4/16/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import "ViewController.h"
#include "math.h"

@interface ViewController ()
- (void)showActionSheet:(id)sender; //Declare method to show action sheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (IBAction)calculate:(id)sender;
- (IBAction)addNew:(id)sender;

@end

@implementation ViewController

- (void)showActionSheet:(id)sender
{
    NSLog(@"property button clicked");
    NSString *actionSheetTitle = @"Choose property type";
    NSString *houseType = @"House";
    NSString *apartmentType = @"Apartment";
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle
                                                             delegate:self
                                                    cancelButtonTitle: nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:houseType,apartmentType, nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *cur_btn_clicked = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([cur_btn_clicked isEqualToString:@"House"]){
        NSLog(@"house type chosen");
        _input_property_type.text=@"House";
    }
    if ([cur_btn_clicked isEqualToString:@"Apartment"]){
        NSLog(@"apartment type chosen");
        _input_property_type.text=@"Apartment";
    }
    
}

- (IBAction)calculate:(id)sender {
    if([_input_loan_amt.text isEqualToString:@""]){
        NSLog(@"no input for loan amount"); // input alert box here
    }
    if([_input_down_payment.text isEqualToString:@""]){
        NSLog(@"no input for down payment");
    }
    if([_input_apr.text isEqualToString:@""]){
        NSLog(@"no input for apr");
    }
    if([_input_term.text isEqualToString:@""]){
        NSLog(@"no input for term");
    }
    else {
        NSLog(@"in else loop");
        int loan_amt = ([_input_loan_amt.text integerValue] - [_input_down_payment.text integerValue]);
        int down_payment = ([_input_down_payment.text integerValue]);
        float apr = ([_input_apr.text floatValue]/1200);
        int term = ([_input_term.text integerValue]*12);
        float result = (loan_amt * apr)/(1 - pow(1 + apr , -term ));
        _result_payment.text = [[NSString alloc]initWithFormat:@"%2.f",result];
//        NSLog([[NSString alloc]initWithFormat:@"%2.f",result]);
        
    }
}

- (IBAction)addNew:(id)sender {
    _input_property_type.text = @"";
    _input_street_add.text = @"";
    _input_city.text = @"";
    _input_state.text = @"";
    _input_zipcode.text = @"";
    _input_loan_amt.text = @"";
    _input_down_payment.text = @"";
    _input_apr.text = @"";
    _input_term.text = @"";
    _result_payment.text = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_chooseTypeBtn addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [_calculate_btn addTarget:self action:@selector(calculate:) forControlEvents:UIControlEventTouchUpInside];
    [_add_new_btn addTarget:self action:@selector(addNew:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
