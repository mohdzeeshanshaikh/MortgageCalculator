//
//  Annotation.h
//  MortgageCalculator
//
//  Created by Mohd Zeeshan Shaikh on 4/23/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation;

- (void)updateDetails:(NSString *)locDetails itm:(MKMapItem *)item an:(NSString *)addressName;
@property (nonatomic) double lat;
@property (nonatomic) double lon;
@property (nonatomic) NSString *locationDetails;
@property (nonatomic) NSString *nameParam;

@end
