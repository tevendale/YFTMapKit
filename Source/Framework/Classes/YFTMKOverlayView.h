//
//  MKOverlayView.h
//  MapKit
//
//  Created by Rick Fillion on 7/12/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <YFTMapKit/YFTMKOverlay.h>
#import <YFTMapKit/YFTMKView.h>

@interface YFTMKOverlayView : YFTMKView {
    id <YFTMKOverlay> overlay;
}

@property (nonatomic, readonly) id <YFTMKOverlay> overlay;


- (id)initWithOverlay:(id <YFTMKOverlay>)anOverlay;


@end
