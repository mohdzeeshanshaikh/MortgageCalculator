//
//  MapViewViewController.m
//  MortgageCalculator
//
//  Created by Mohd Zeeshan Shaikh on 4/16/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import "MapViewViewController.h"
#import "DBManager.h"

#import "Annotation.h"
#import "DetailViewController.h"

@interface MapViewViewController ()

@end

NSString* _locationDetails;
NSMutableArray *locations;

@implementation MapViewViewController
@synthesize mapView;


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self viewDidLoad];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    mapView.zoomEnabled = YES;
    
    _addressQuery=@"";
    _locationDetails=@"";
    locations = [[NSMutableArray alloc] init];
    
    DBManager* dbManager = [DBManager getSharedInstance];
    
    NSArray* dbData = [dbManager getData];
    
    NSLog(@"dbData: %@",dbData);
    NSLog(@"dbData count: %lu",(unsigned long)dbData.count);
    [self gotoDefaultLocation];

    
    NSInteger i;
    
    for (i=0; i<dbData.count; i++) {
        
        _addressQuery=@"";
        _locationDetails=@"";
        
        _addressQuery=[_addressQuery stringByAppendingString:[dbData[i] valueForKey:@"address"]];
        _addressQuery=[_addressQuery stringByAppendingString:@", "];
        _addressQuery=[_addressQuery stringByAppendingString:[dbData[i] valueForKey:@"city"]];
        
        NSLog(@"address query: %@",_addressQuery);
        
        
        
        
        _locationDetails=[_locationDetails stringByAppendingString:@"Address: "];
        _locationDetails=[_locationDetails stringByAppendingString:[dbData[i] valueForKey:@"address"]];
        _locationDetails=[_locationDetails stringByAppendingString:@"\nCity: "];
        _locationDetails=[_locationDetails stringByAppendingString:[dbData[i] valueForKey:@"city"]];
        _locationDetails=[_locationDetails stringByAppendingString:@"\nMortgage Amount: "];
        _locationDetails=[_locationDetails stringByAppendingString:[dbData[i] valueForKey:@"mortgageAmount"]];
        _locationDetails=[_locationDetails stringByAppendingString:@"\nProperty Type: "];
        _locationDetails=[_locationDetails stringByAppendingString:[dbData[i] valueForKey:@"propertyType"]];
        NSLog(@"Location Details: %@",_locationDetails);
    
        [self locateOnMap];

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



- (void)gotoDefaultLocation
{
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 37.34015288;
    newRegion.center.longitude = -121.88096400;
    newRegion.span.latitudeDelta = 0.8;//.00032459;
    newRegion.span.longitudeDelta = 0.8;//.00047190;
    
    [self.mapView setRegion:newRegion animated:YES];
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
        unsigned long i;
        i=0;
            for (MKMapItem *item in response.mapItems)
            {
//                MKPointAnnotation *annotation =
//                [[MKPointAnnotation alloc]init];
//                annotation.coordinate = item.placemark.coordinate;
//                annotation.title = item.name;
//                
//                [mapView addAnnotation:annotation];
//                [self gotoDefaultLocation];
                
                NSLog(@"Item %lu: %@",i,item);
                i++;

                Annotation *annotation = [[Annotation alloc] init];
                //annotation.coordinate=item.placemark.coordinate;
                [annotation  updateDetails:_locationDetails itm:item];
                [mapView addAnnotation:annotation];
                [self gotoDefaultLocation];
               // [locations addObject:annotation];
            }
        
    }];
}

//
//- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    NSLog(@"viewForAnnotation");
//
//    MKAnnotationView *returnedAnnotationView = nil;
////    
////    // in case it's the user location, we already have an annotation, so just return nil
////    if (![annotation isKindOfClass:[MKUserLocation class]])
////    {
//    
//            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
//            ((MKPinAnnotationView *)returnedAnnotationView).rightCalloutAccessoryView = rightButton;
////    }
//        return returnedAnnotationView;
//}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    // here we illustrate how to detect which annotation type was clicked on for its callout
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[Annotation class]])
    {
        NSLog(@"clicked annotation");
        
        DetailViewController *detailViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"DetailViewController"];
        
            [self.navigationController pushViewController:detailViewController animated:YES];
        
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *returnedAnnotationView = nil;
    
    // in case it's the user location, we already have an annotation, so just return nil
    if (![annotation isKindOfClass:[MKUserLocation class]])
    {
        // handle our custom annotations
        //
        if ([annotation isKindOfClass:[Annotation class]])
        {
            returnedAnnotationView = [Annotation createViewAnnotationForMapView:self.mapView annotation:annotation];
            
            // add a detail disclosure button to the callout which will open a new view controller page or a popover
            //
            // note: when the detail disclosure button is tapped, we respond to it via:
            //       calloutAccessoryControlTapped delegate method
            //
            // by using "calloutAccessoryControlTapped", it's a convenient way to find out which annotation was tapped
            //
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            ((MKPinAnnotationView *)returnedAnnotationView).rightCalloutAccessoryView = rightButton;
        }
    }
    
    return returnedAnnotationView;
}




@end