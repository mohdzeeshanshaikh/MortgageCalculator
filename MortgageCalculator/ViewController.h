//
//  ViewController.h
//  MortgageCalculator
//
//  Created by Sophia Ngo on 4/16/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *add_new_btn;
@property (weak, nonatomic) IBOutlet UIButton *chooseTypeBtn;
@property (weak, nonatomic) IBOutlet UITextField *input_property_type;
@property (weak, nonatomic) IBOutlet UITextField *input_street_add;
@property (weak, nonatomic) IBOutlet UITextField *input_city;
@property (weak, nonatomic) IBOutlet UITextField *input_state;
@property (weak, nonatomic) IBOutlet UITextField *input_zipcode;
@property (weak, nonatomic) IBOutlet UITextField *input_loan_amt;
@property (weak, nonatomic) IBOutlet UITextField *input_down_payment;
@property (weak, nonatomic) IBOutlet UITextField *input_apr;
@property (weak, nonatomic) IBOutlet UITextField *input_term;
@property (weak, nonatomic) IBOutlet UIButton *save_btn;
@property (weak, nonatomic) IBOutlet UIButton *calculate_btn;
@property (weak, nonatomic) IBOutlet UILabel *result_payment;
@property (weak, nonatomic) IBOutlet UITabBarItem *map_tab;

@end

