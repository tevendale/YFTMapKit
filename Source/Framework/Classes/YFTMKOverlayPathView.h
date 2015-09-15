//
//  MKOverlayPathView.h
//  MapKit
//
//  Created by Rick Fillion on 7/12/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <YFTMapKit/YFTMKOverlayView.h>

@interface YFTMKOverlayPathView : YFTMKOverlayView {
    NSColor *fillColor;
    NSColor *strokeColor;
    CGFloat lineWidth;
}

@property (nonatomic, strong) NSColor *fillColor;
@property (nonatomic, strong) NSColor *strokeColor;
@property (nonatomic, assign) CGFloat lineWidth;

@end
