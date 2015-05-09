//
//  EditViewController.h
//  MortgageCalculator
//
//  Created by Sophia Ngo on 5/8/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *property_label;
@property (weak, nonatomic) IBOutlet UILabel *type_label;
@property (weak, nonatomic) IBOutlet UILabel *type_value;
@property (weak, nonatomic) IBOutlet UILabel *address_label;
@property (weak, nonatomic) IBOutlet UILabel *address_value;
@property (weak, nonatomic) IBOutlet UILabel *city_label;
@property (weak, nonatomic) IBOutlet UILabel *city_value;
@property (weak, nonatomic) IBOutlet UILabel *state_label;
@property (weak, nonatomic) IBOutlet UILabel *state_value;
@property (weak, nonatomic) IBOutlet UILabel *zip_label;
@property (weak, nonatomic) IBOutlet UILabel *zip_value;
@property (weak, nonatomic) IBOutlet UILabel *apr_label;
@property (weak, nonatomic) IBOutlet UILabel *loan_info_label;
@property (weak, nonatomic) IBOutlet UILabel *down_payment_label;
@property (weak, nonatomic) IBOutlet UILabel *amt_label;
@property (weak, nonatomic) IBOutlet UILabel *term_label;
@property (weak, nonatomic) IBOutlet UITextField *amt_input;
@property (weak, nonatomic) IBOutlet UITextField *payment_input;
@property (weak, nonatomic) IBOutlet UITextField *apr_input;
@property (weak, nonatomic) IBOutlet UITextField *term_input;
@property (weak, nonatomic) IBOutlet UIButton *calculate_btn;
@property (weak, nonatomic) IBOutlet UITextField *result;

@end
