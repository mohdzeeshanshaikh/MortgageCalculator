//
//  DetailViewController.h
//  MortgageCalculator
//
//  Created by Mohd Zeeshan Shaikh on 4/23/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface DetailViewController : UIViewController

@property (nonatomic) CLLocationCoordinate2D kPanoramaNear;
@property (nonatomic) CLLocationCoordinate2D kMarkerAt;

@property (nonatomic) double lat;
@property (nonatomic) double lon;

@end