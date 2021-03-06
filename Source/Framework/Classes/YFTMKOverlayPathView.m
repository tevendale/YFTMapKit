//
//  MKOverlayPathView.m
//  MapKit
//
//  Created by Rick Fillion on 7/12/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import "YFTMKOverlayPathView.h"
#import "NSColor+Additions.h"

@implementation YFTMKOverlayPathView

@synthesize fillColor, strokeColor, lineWidth;

- (id)initWithOverlay:(id <YFTMKOverlay>)anOverlay
{
    if (self = [super initWithOverlay:anOverlay])
    {
        self.fillColor = [[NSColor redColor] colorWithAlphaComponent: 0.3];
        self.strokeColor = [NSColor redColor];
        self.lineWidth = 1.0;
    }
    return self;
}


- (NSDictionary *)options
{
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:[super options]];
    
    [options setObject:[NSNumber numberWithFloat:lineWidth] forKey:@"strokeWeight"];
    [options setObject:[NSNumber numberWithBool:NO] forKey:@"clickable"];

    if (fillColor)
    {
        [options setObject:[fillColor hexString] forKey:@"fillColor"];
        [options setObject:[NSNumber numberWithFloat:[fillColor alphaComponent]] forKey:@"fillOpacity"];
    }
    if (strokeColor)
    {
        [options setObject:[strokeColor hexString] forKey:@"strokeColor"];
        [options setObject:[NSNumber numberWithFloat:[strokeColor alphaComponent]] forKey:@"strokeOpacity"];

    }
    
    return [options copy];
}

@end
