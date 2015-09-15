//
//  MKPolygon.h
//  MapKit
//
//  Created by Rick Fillion on 7/15/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <YFTMapKit/YFTMKMultiPoint.h>
#import <YFTMapKit/YFTMKOverlay.h>

@interface YFTMKPolygon : YFTMKMultiPoint <YFTMKOverlay> {
    NSArray *interiorPolygons;
}

@property (readonly) NSArray *interiorPolygons;

+ (YFTMKPolygon *)polygonWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count;
+ (YFTMKPolygon *)polygonWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count interiorPolygons:(NSArray *)interiorPolygons;


@end

