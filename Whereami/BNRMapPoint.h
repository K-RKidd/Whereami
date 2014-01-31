//
//  BNRMapPoint.h
//  Whereami
//
//  Created by Krystle on 1/30/14.
//  Copyright (c) 2014 Krystle Kidd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface BNRMapPoint : NSObject <MKAnnotation>
{

}
//A new designed initalizer for instances of BNRMapPoint
-(id) initWithCoordinate: (CLLocationCoordinate2D)c title: (NSString *)t;

//This is a required property from MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//This is an optional property from MKAnnotation
@property (nonatomic, copy) NSString *title;

@end
