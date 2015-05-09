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
#import "EditViewController.h"

@interface MapViewViewController ()

@end

Annotation* marker;

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
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    mapView.zoomEnabled = YES;
    mapView.frame = self.view.bounds;
    mapView.autoresizingMask = self.view.autoresizingMask;
    
    DBManager* dbManager = [DBManager getSharedInstance];
    
    NSArray* dbData = [dbManager getData];
    
    [self gotoDefaultLocation];
    
    NSInteger i;
    
    for (i=0; i<dbData.count; i++) {
        
        _addressQuery=@"";
        _locationDetails=@"";
        _addressName=@"";
        
        _addressQuery=[_addressQuery stringByAppendingString:[dbData[i] valueForKey:@"address"]];
        _addressQuery=[_addressQuery stringByAppendingString:@", "];
        _addressQuery=[_addressQuery stringByAppendingString:[dbData[i] valueForKey:@"city"]];
        
        _locationDetails=[_locationDetails stringByAppendingString:[dbData[i] valueForKey:@"mortgageAmount"]];

        _addressName=[_addressName stringByAppendingString:[dbData[i] valueForKey:@"address"]];

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
    newRegion.span.latitudeDelta = 0.8;
    newRegion.span.longitudeDelta = 0.8;
    
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
    
    NSString* tempLoc = _locationDetails;
    NSString* tempName = _addressName;

    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
            NSLog(@"Response: %@",response);
        
        for (MKMapItem *item in response.mapItems)
        {
            Annotation *annotation = [[Annotation alloc] init];
            [annotation  updateDetails:tempLoc itm:item an:tempName];
            _locationDetails=@"";
            
            [mapView addAnnotation:annotation];
            [self gotoDefaultLocation];
        }
    }];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    // here we illustrate how to detect which annotation type was clicked on for its callout
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[Annotation class]])
    {
                NSLog(@"Clicked Annotation");
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *returnedAnnotationView = nil;
    
    // in case it's the user location, we already have an annotation, so just return nil
    if (![annotation isKindOfClass:[MKUserLocation class]])
    {
        if ([annotation isKindOfClass:[Annotation class]])
        {
            returnedAnnotationView = [Annotation createViewAnnotationForMapView:self.mapView annotation:annotation];
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [rightButton setTitle:@"Street" forState:UIControlStateNormal];
            
            rightButton.frame=CGRectMake(0.0, 0.0, 50.0, 40.0);
            [rightButton addTarget:self action:@selector(streetViewMethod) forControlEvents:UIControlEventTouchUpInside];
            ((MKPinAnnotationView *)returnedAnnotationView).rightCalloutAccessoryView = rightButton;
            
            UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [leftButton setTitle:@"Update" forState:UIControlStateNormal];
            
            leftButton.frame=CGRectMake(0.0, 0.0, 60.0, 40.0);
            [leftButton addTarget:self action:@selector(updateMethod) forControlEvents:UIControlEventTouchUpInside];
            ((MKPinAnnotationView *)returnedAnnotationView).leftCalloutAccessoryView = leftButton;
        }
    }
    return returnedAnnotationView;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[Annotation class]]) {
        marker = view.annotation;
        _cur_address = marker.nameParam;
        _latt=marker.lat;
        _lonn=marker.lon;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    DBManager* dbManager = [DBManager getSharedInstance];
    if (buttonIndex == 1) {
        [dbManager deleteData:_cur_address];
        [mapView removeAnnotation:marker];
    }
    else if(buttonIndex==2){
        EditViewController *editViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"EditViewController"];
        editViewController.address_from_map = _cur_address;
        editViewController.data = [dbManager getDataByAddress : _cur_address];
        [self.navigationController pushViewController:editViewController animated:YES];
    }
}


-(void)streetViewMethod{
    DetailViewController *detailViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailViewController.lat=_latt;
    detailViewController.lon=_lonn;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)updateMethod{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"EDIT OPTIONS"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Delete",@"Edit", nil];
    [alert show];
}
@end
