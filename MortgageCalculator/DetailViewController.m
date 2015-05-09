//
//  DetailViewController.m
//  MapsCallout
//
//  Created by student on 4/23/15.
//  Copyright (c) 2015 sjsu. All rights reserved.
//

#import "DetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>

static CLLocationCoordinate2D kPanoramaNear = {40.761388, -73.978133};
static CLLocationCoordinate2D kMarkerAt = {40.761455, -73.977814};

@interface DetailViewController () <GMSPanoramaViewDelegate>
@end

@implementation DetailViewController{
    GMSPanoramaView *view_;
    BOOL configured_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    view_ = [GMSPanoramaView panoramaWithFrame:CGRectZero
                                nearCoordinate:kPanoramaNear];
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
        GMSMarker *marker = [GMSMarker markerWithPosition:kMarkerAt];
        marker.icon = [GMSMarker markerImageWithColor:[UIColor purpleColor]];
        marker.panoramaView = view_;
        
        CLLocationDegrees heading = GMSGeometryHeading(kPanoramaNear, kMarkerAt);
        view_.camera =
        [GMSPanoramaCamera cameraWithHeading:heading pitch:0 zoom:1];
        
        configured_ = YES;
    }
}

@end