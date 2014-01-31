//
//  WhereamiViewController.h
//  Whereami
//
//  Created by Krystle on 1/27/14.
//  Copyright (c) 2014 Krystle Kidd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamiViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView * activityIndicator;
    IBOutlet UITextField *locationTitleField;
    
}
-(void) findLocation;
-(void) foundLocation: (CLLocation *) loc;

@end
