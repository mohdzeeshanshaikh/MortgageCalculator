//
//  MortgageItem.h
//  MortgageCalculator
//
//  Created by Sophia Ngo on 4/17/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MortgageItem : NSObject
@property NSString *property_type;
@property NSString *address;
@property NSString *city;
@property NSString *state;
@property NSNumber *zipcode;
@property NSNumber *loan_amt;
@property NSNumber *down_payment;
@property NSNumber *apr;
@property NSNumber *term;
@end
