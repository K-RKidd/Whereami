//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Krystle on 1/27/14.
//  Copyright (c) 2014 Krystle Kidd. All rights reserved.
//

#import "WhereamiViewController.h"
#import "BNRMapPoint.h"

@interface WhereamiViewController ()

@end

@implementation WhereamiViewController

-(void) findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

-(void) foundLocation:(CLLocation *) loc;
{
    CLLocationCoordinate2D coord =  [loc coordinate];
    
    //Create an instance of BNRMapPoint with the current data
    BNRMapPoint *mp = [[BNRMapPoint alloc]initWithCoordinate:coord title:[locationTitleField text]];
    //Add it to the map view
    [worldView addAnnotation:mp];
    //Zoom the region to this location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];
    //Reset the UI
    [locationTitleField setText:@ ""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //Create location manager object
    locationManager = [[CLLocationManager alloc]init];
    
    [locationManager setDelegate:self];
    
    //Make as accurate as possible
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    //Tell our manager to start looking for its location right away
    [worldView setShowsUserLocation:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250,250);
    [worldView setRegion:region animated:YES];

}

-(void) locationManager: (CLLocationManager *) manager
            didUpdateLocations:(NSArray *)locations{
                CLLocation *newLocation = [locations objectAtIndex:0];
                NSLog(@ "%@", newLocation);
    //How many seconds ago was this new location created?
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    //If the location was made more than 3 min ago ignore it
    if (t<-180) {
        //This is catched data you don't want it, keep looking
        return;
    }
    [self foundLocation:newLocation];
            }
            -(void) locationManager: (CLLocationManager *) manager
            didFailWithError:(NSError *)error
            {
                NSLog(@ "Could not find the location: %@", error);
            }
-(void) dealloc
{
    //Tell the location manager to stop sending us messages
    [locationManager setDelegate:nil];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self findLocation];
    [textField resignFirstResponder];
    return YES;
}

@end
