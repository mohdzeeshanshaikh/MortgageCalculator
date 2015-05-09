//
//  Annotation.m
//  MapsCallout
//
//  Created by student on 4/23/15.
//  Copyright (c) 2015 sjsu. All rights reserved.
//


#import "Annotation.h"

//double lat;
//double lon;

@implementation Annotation


- (void)updateDetails:(NSString *)locDetails itm:(MKMapItem *)item an:(NSString *)addressName
{
    NSLog(@"Item in update: %@",item);
    _lat=item.placemark.coordinate.latitude;    //37.34015288;
    _lon=item.placemark.coordinate.longitude; //-121.88096400;
    NSLog(@"Lat in update: %f",_lat);
    NSLog(@"Lon in update: %f",_lon);
    _locationDetails=locDetails;
    NSLog(@"Updating Details: %@",_locationDetails);
    _nameParam = addressName;
    NSLog(@"_nameParam: %@",_nameParam);
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = _lat;
    theCoordinate.longitude = _lon;
    //
    //    NSLog(@"co-Lat: %f",theCoordinate.latitude);
    //    NSLog(@"co-Lon: %f",theCoordinate.longitude);
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
//    return _locationDetails;
//    UILabel *l1=[[UILabel alloc] init];
//    l1.frame=CGRectMake(0, 15, 50, 50);
//    l1.text=@"First line of subtitle";
//    l1.font=[UIFont fontWithName:@"Arial Rounded MT Bold" size:(10.0)];
//    return l1;
    return @"Something Something Something Something Something \n second line here";
}

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation
{
    // try to dequeue an existing pin view first
    MKAnnotationView *returnedAnnotationView =
    [mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([Annotation class])];
    if (returnedAnnotationView == nil)
    {
        returnedAnnotationView =
        [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
        
        ((MKPinAnnotationView *)returnedAnnotationView).pinColor = MKPinAnnotationColorPurple;
        ((MKPinAnnotationView *)returnedAnnotationView).animatesDrop = YES;
//        ((MKPinAnnotationView *)returnedAnnotationView).
        //frame = CGRectMake(0.0, 0.0, 280.0, 340.0);
        ((MKPinAnnotationView *)returnedAnnotationView).canShowCallout = YES;
    }
    
    return returnedAnnotationView;
}



@end