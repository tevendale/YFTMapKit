//
//  MKPolyline.m
//  MapKit
//
//  Created by Rick Fillion on 7/15/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import "YFTMKPolyline.h"

@interface YFTMKPolyline (Private)

- (id)initWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count;

@end


@implementation YFTMKPolyline

+ (YFTMKPolyline *)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count
{
    return [[YFTMKPolyline alloc] initWithCoordinates:coords count:count];
}

- (CLLocationCoordinate2D) coordinate
{
    return [super coordinate];
}

- (void)dealloc
{
    free(coordinates);
}

#pragma mark Private

- (id)initWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count
{
    if (self = [super init])
    {
        coordinates = malloc(sizeof(CLLocationCoordinate2D) * count);
        for (int i = 0; i < count; i++)
        {
            coordinates[i] = coords[i];
        }
        coordinateCount = count;
    }
    return self;
}

@end
