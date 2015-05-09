//
//  DetailViewController.m
//  MortgageCalculator
//
//  Created by Mohd Zeeshan Shaikh on 4/23/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import "DetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>

//static CLLocationCoordinate2D kPanoramaNear = {40.761388, -73.978133};
//static CLLocationCoordinate2D kMarkerAt = {40.761455, -73.977814};

@interface DetailViewController () <GMSPanoramaViewDelegate>
@end

@implementation DetailViewController{
    GMSPanoramaView *view_;
    BOOL configured_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _kPanoramaNear.latitude = _lat;
    _kPanoramaNear.longitude = _lon;
    _kMarkerAt.latitude = _lat;
    _kMarkerAt.longitude = _lon;
    
    view_ = [GMSPanoramaView panoramaWithFrame:CGRectZero
                                nearCoordinate:_kPanoramaNear];
    view_.backgroundColor = [UIColor grayColor];
    view_.delegate = self;
    self.view = view_;
}

#pragma mark - GMSPanoramaDelegate

- (void)panoramaView:(GMSPanoramaView *)panoramaView
       didMoveCamera:(GMSPanoramaCamera *)camera {
    NSLog(@"Camera: (%f,%f,%f)",
          camera.orientation.heading, camera.orientation.pitch, camera.zoom);
}

- (void)panoramaView:(GMSPanoramaView *)view
   didMoveToPanorama:(GMSPanorama *)panorama {
    if (!configured_) {
        GMSMarker *marker = [GMSMarker markerWithPosition:_kMarkerAt];
        marker.icon = [GMSMarker markerImageWithColor:[UIColor purpleColor]];
        marker.panoramaView = view_;
        
        CLLocationDegrees heading = GMSGeometryHeading(_kPanoramaNear, _kMarkerAt);
        view_.camera =
        [GMSPanoramaCamera cameraWithHeading:heading pitch:0 zoom:1];
        
        configured_ = YES;
    }
}

@end