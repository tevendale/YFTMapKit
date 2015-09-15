//
//  MKUserLocation.m
//  MapKit
//
//  Created by Rick Fillion on 7/11/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import "YFTMKUserLocation.h"


@implementation YFTMKUserLocation

@synthesize updating, location, title, subtitle;


- (CLLocationCoordinate2D) coordinate
{
    return [location coordinate];
}

@end
