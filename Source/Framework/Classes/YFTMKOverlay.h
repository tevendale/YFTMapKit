/*
 *  MKOverlay.h
 *  MapKit
 *
 *  Created by Rick Fillion on 7/12/10.
 *  Copyright 2010 Centrix.ca. All rights reserved.
 *
 */

#import <YFTMapKit/YFTMKAnnotation.h>
#import <YFTMapKit/YFTMKTypes.h>
#import <YFTMapKit/YFTMKGeometry.h>


@protocol YFTMKOverlay <YFTMKAnnotation>

@required

// From MKAnnotation, for areas this should return the centroid of the area.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end
