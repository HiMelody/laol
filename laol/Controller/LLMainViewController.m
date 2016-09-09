//
//  LLMainViewController.m
//  laol
//
//  Created by 芳坪梁 on 16/2/1.
//  Copyright © 2016年 芳坪梁. All rights reserved.
//

#import "LLMainViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LLMainViewController () <CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation LLMainViewController


- (void)viewDidLoad{

    [super viewDidLoad];
    [self startStandardUpdates];
    
    NSLog(@"%s",__DATE__);
}



- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == _locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    _locationManager.distanceFilter = 500; // meters
    
    [_locationManager startUpdatingLocation];
}


#pragma mark -- CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    NSLog(@"latitude = %f",locations[0].coordinate.latitude);
    NSLog(@"longitude = %f",locations[0].coordinate.longitude);
}

@end
