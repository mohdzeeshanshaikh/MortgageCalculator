//
//  DBManager.h
//  MortgageCalculator
//
//  Created by Sadhana on 4/25/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL) saveData:(NSString*)propertyType address:(NSString*)address city:(NSString*)city state:(NSString*)state zipCode:(NSString*)zipCode
      loanAmount:(int)loanAmount downPayment:(int)downPayment annualRate:(double)annualRate payYear:(int)payYear mortgageAmount:(NSString*)mortgageAmount;
-(NSArray*) getData;
-(NSArray*) getDataByAddress : (NSString*) inputAddress;
- (NSArray*) updateData : (NSString*) inputAddress : (int) newAmt : (int) newPayment : (double) newApr : (int) newTerm : (NSString*) newResult;
- (NSArray*) deleteData : (NSString*) inputAddress;

@end
