//
//  MapViewViewController.m
//  MortgageCalculator
//
//  Created by Mohd Zeeshan Shaikh on 4/16/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import "MapViewViewController.h"
#import "DBManager.h"

@interface MapViewViewController ()

@end

@implementation MapViewViewController
@synthesize mapView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    mapView.zoomEnabled = YES;
    
    _addressQuery=@"";
    
    DBManager* dbManager = [DBManager getSharedInstance];
    
    NSArray* dbData = [dbManager getData];
    
    NSLog(@"dbData: %@",dbData);
    NSLog(@"dbData count: %lu",(unsigned long)dbData.count);
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 37.34015288;
    newRegion.center.longitude = -121.88096400;
    newRegion.span.latitudeDelta = 0.05;//.00032459;
    newRegion.span.longitudeDelta = 0.05;//.00047190;
    
    [self.mapView setRegion:newRegion animated:YES];
    
    NSInteger i;
   // NSLog(@"dbData: %@",[dbData[2] valueForKey:@"address"]);
    
    for (i=0; i<dbData.count; i++) {
        _addressQuery=[_addressQuery stringByAppendingString:[dbData[i] valueForKey:@"address"]];
        _addressQuery=[_addressQuery stringByAppendingString:@", "];
        _addressQuery=[_addressQuery stringByAppendingString:[dbData[i] valueForKey:@"city"]];
//        _addressQuery=[_addressQuery stringByAppendingString:[dbData[i] objectAtIndex:3]];
//        _addressQuery=[_addressQuery stringByAppendingString:[dbData[i] objectAtIndex:4]];
//    _addressQuery=[_addressQuery stringByAppendingString:dbData[2]];
//    _addressQuery=[_addressQuery stringByAppendingString:dbData[3]];
//    _addressQuery=[_addressQuery stringByAppendingString:dbData[4]];
    
    NSLog(@"address query: %@",_addressQuery);
    
    [self locateOnMap];
        _addressQuery=@"";
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.mapView.centerCoordinate = userLocation.location.coordinate;
}

- (void) locateOnMap {
    MKLocalSearchRequest *request =
    [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = self.addressQuery;
    request.region = mapView.region;
    
    [mapView setRegion:request.region animated:YES];
    MKLocalSearch *search =
    [[MKLocalSearch alloc]initWithRequest:request];
    NSLog(@"Search: %@",search);
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
            NSLog(@"Response: %@",response);
            for (MKMapItem *item in response.mapItems)
            {
                MKPointAnnotation *annotation =
                [[MKPointAnnotation alloc]init];
                annotation.coordinate = item.placemark.coordinate;
                annotation.title = item.name;
                
                [mapView addAnnotation:annotation];
            }
    }];
}

//
//- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    NSLog(@"viewForAnnotation");
//
//    MKAnnotationView *returnedAnnotationView = nil;
//    
//    // in case it's the user location, we already have an annotation, so just return nil
//    if (![annotation isKindOfClass:[MKUserLocation class]])
//    {
//       
//            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
//            ((MKPinAnnotationView *)returnedAnnotationView).rightCalloutAccessoryView = rightButton;
//    }
//        return returnedAnnotationView;
//}

@end
