//
//  RinksViewController.h
//  RinksideDev2
//
//  Created by Dave Fearon on 11-11-01.
//  Copyright (c) 2011 In-touch Survey Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define METERS_PER_MILE 1609.344

@interface RinksViewController : UIViewController <MKMapViewDelegate> {
    BOOL _doneInitialZoom;
    MKMapView *_mapView;
    CLLocationManager *locationManager;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end
