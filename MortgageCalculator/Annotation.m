//
//  Annotation.m
//  MortgageCalculator
//
//  Created by Mohd Zeeshan Shaikh on 4/23/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//


#import "Annotation.h"

@implementation Annotation


- (void)updateDetails:(NSString *)locDetails itm:(MKMapItem *)item an:(NSString *)addressName
{
    _lat=item.placemark.coordinate.latitude;
    _lon=item.placemark.coordinate.longitude;
    _locationDetails=locDetails;
    _nameParam = addressName;
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = _lat;
    theCoordinate.longitude = _lon;
    return theCoordinate;
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return _locationDetails;
}

// optional
- (NSString *)subtitle
{
    return _nameParam;
}

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *returnedAnnotationView =
    [mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([Annotation class])];
    if (returnedAnnotationView == nil)
    {
        returnedAnnotationView =
        [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
        ((MKPinAnnotationView *)returnedAnnotationView).pinColor = MKPinAnnotationColorPurple;
        ((MKPinAnnotationView *)returnedAnnotationView).animatesDrop = YES;
        ((MKPinAnnotationView *)returnedAnnotationView).canShowCallout = YES;
    }
    
    return returnedAnnotationView;
}

@end