//
//  MKPolylineView.h
//  MapKit
//
//  Created by Rick Fillion on 7/15/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <YFTMapKit/YFTMKPolyline.h>
#import <YFTMapKit/YFTMKOverlayPathView.h>

@interface YFTMKPolylineView : YFTMKOverlayPathView {
    NSArray *path;
}

- (id)initWithPolyline:(YFTMKPolyline *)polyline;

@property (nonatomic, readonly) YFTMKPolyline *polyline;

@end

