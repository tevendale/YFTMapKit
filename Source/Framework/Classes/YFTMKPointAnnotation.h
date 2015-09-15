//
//  MKPointAnnotation.h
//  MapKit
//
//  Created by Rick Fillion on 7/18/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <YFTMapKit/YFTMKShape.h>
#import <CoreLocation/CLLocation.h>

@interface YFTMKPointAnnotation : YFTMKShape {
    @package
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

