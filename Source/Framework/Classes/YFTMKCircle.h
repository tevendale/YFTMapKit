//
//  MKCircle.h
//  MapKit
//
//  Created by Rick Fillion on 7/12/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreLocation/CoreLocation.h>
#import <YFTMapKit/YFTMKShape.h>
#import <YFTMapKit/YFTMKOverlay.h>
#import <YFTMapKit/YFTMKGeometry.h>

@interface YFTMKCircle : YFTMKShape <YFTMKOverlay> {
    @package
    CLLocationCoordinate2D coordinate;
    CLLocationDistance radius;
}

+ (YFTMKCircle *)circleWithCenterCoordinate:(CLLocationCoordinate2D)coord radius:(CLLocationDistance)radius;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) CLLocationDistance radius;
@property (nonatomic, readonly) YFTMKCoordinateRegion region;

@end
