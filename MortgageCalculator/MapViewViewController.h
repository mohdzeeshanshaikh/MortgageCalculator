//
//  MapViewViewController.h
//  MortgageCalculator
//
//  Created by Mohd Zeeshan Shaikh on 4/16/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "Annotation.h"
@interface MapViewViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) NSString *addressQuery;

@property (strong, nonatomic) NSString *locationDetails;
@property (strong, nonatomic) NSString *addressName;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic) NSString *cur_address;
@property (nonatomic) double latt;
@property (nonatomic) double lonn;
@property (nonatomic) NSString *city;

@end
