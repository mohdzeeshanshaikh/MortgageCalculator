//
//  Annotation.m
//  MapsCallout
//
//  Created by student on 4/23/15.
//  Copyright (c) 2015 sjsu. All rights reserved.
//


#import "Annotation.h"

double lat;
double lon;
NSString *locationDetails;

@implementation Annotation


- (void)updateDetails:(NSString *)locDetails itm:(MKMapItem *)item
{
    lat=item.placemark.coordinate.latitude;    //37.34015288;
    lon=item.placemark.coordinate.longitude; //-121.88096400;
    NSLog(@"Updating Details: %@",locationDetails);
    NSLog(@"Item: %@",item);
    NSLog(@"Lat: %f",lat);
    NSLog(@"Lon: %f",lon);
    locationDetails=locDetails;
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = lat;
    theCoordinate.longitude = lon;
    
    NSLog(@"co-Lat: %f",lat);
    NSLog(@"co-Lon: %f",lon);

    return theCoordinate;
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return @"Zee";
}

// optional
- (NSString *)subtitle
{
    return locationDetails;
}

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation
{
    // try to dequeue an existing pin view first
    MKAnnotationView *returnedAnnotationView =
    [mapView viewForAnnotation:annotation];
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