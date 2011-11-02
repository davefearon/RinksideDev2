//
//  RinksViewController.m
//  RinksideDev2
//
//  Created by Dave Fearon on 11-11-01.
//  Copyright (c) 2011 In-touch Survey Inc. All rights reserved.
//

#import "RinksViewController.h"
#import "ASIHTTPRequest.h"
#import "MyLocation.h"
#import "SBJson.h"

@implementation RinksViewController
//@synthesize mapView;

- (void)viewWillAppear:(BOOL)animated {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLHeadingFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    CLLocationCoordinate2D zoomLocation;
    
    zoomLocation.latitude = locationManager.location.coordinate.latitude; //45.421528
    zoomLocation.longitude = locationManager.location.coordinate.longitude; //-75.697174
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    
    [_mapView setRegion:adjustedRegion animated:YES]; 
}

- (void)plotRinkPositions:(NSString *)responseString {
    
    //NSString *testing = "pudding";
    
    //NSLog(@"RESPONSE: %@", responseString);
    
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    NSDictionary *rinks = [responseString JSONValue];
    NSLog(@"dictionary: %@", rinks);
    for (NSDictionary *rink1 in rinks) {
        NSLog(@"dictionary: %@", rink1);
        //NSDictionary *level1 = [rink1 objectForKey:@"rink"];
        //for (NSDictionary *rink2 in level1) {
            //NSDictionary *level2 = [rink2 objectForKey:@"rink"];
            //for (NSDictionary *data in level2) {
                //NSString *rinkName = [data objectForKey:@"name"];
                //NSLog(@"NAME: %@", rinkName);
            //}
        //}
    }
    /*
    
    NSDictionary * root = [responseString JSONValue];
    NSArray *data = [root objectForKey:@"data"];
    
    for (NSArray * row in data) {
        //NSNumber * latitude = [row objectAtIndex:11];
        //NSNumber * longitude = [row objectAtIndex:12];
        
        NSString * address = [row objectAtIndex:0];
        
        NSLog(@"Rink: %@", address);
    }
     */
}

- (IBAction)refreshTapped:(id)sender {
    //MKCoordinateRegion mapRegion = [_mapView region];
    //CLLocationCoordinate2D centerLocation = mapRegion.center;
    
    //DON'T NEED THE 3 LINES BELOW AS I'M NOT PASSING ANYTHING TO THE MAPS CALL
    //NSString *jsonFile = [[NSBundle mainBundle] pathForResource:@"command" ofType:@"json"];
    //NSString *formatString = [NSString stringWithContentsOfFile:jsonFile encoding:NSUTF8StringEncoding error:nil];
    //NSString *json = [NSString stringWithFormat:formatString, centerLocation.latitude, centerLocation.longitude, 0.5*METERS_PER_MILE];
    
    NSURL *url = [NSURL URLWithString:@"http://rinksi.de/home/map.json"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.requestMethod = @"GET";
    
    //DON'T NEED THE LINE BELOW AS I'M NOT PASSING ANYTHING TO THE MAPS CALL
    //[request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setDelegate:self];
    [request setCompletionBlock:^{        
        NSString *responseString = [request responseString];
        //NSLog(@"Response: %@", responseString);
        [self plotRinkPositions:responseString];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    
    [request startAsynchronous];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
