//
//  MKPolygonView.h
//  MapKit
//
//  Created by Rick Fillion on 7/15/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <YFTMapKit/YFTMKPolygon.h>
#import <YFTMapKit/YFTMKOverlayPathView.h>

@interface YFTMKPolygonView : YFTMKOverlayPathView{
    NSArray *path;
    NSArray *interiorPaths;
}

- (id)initWithPolygon:(YFTMKPolygon *)polygon;

@property (nonatomic, readonly) YFTMKPolygon *polygon;

@end

