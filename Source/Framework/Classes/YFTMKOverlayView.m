//
//  MKOverlayView.m
//  MapKit
//
//  Created by Rick Fillion on 7/12/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import "YFTMKOverlayView.h"

@implementation YFTMKOverlayView

@synthesize overlay;

- (id)initWithOverlay:(id <YFTMKOverlay>)anOverlay
{
    if (self = [super init])
    {
        overlay = anOverlay;
    }
    return self;
}





@end
