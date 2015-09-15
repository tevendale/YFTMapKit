//
//  MKCircleView.m
//  MapKit
//
//  Created by Rick Fillion on 7/12/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import "YFTMKCircleView.h"
#import <YFTMapKit/YFTMKCircle.h>

@implementation YFTMKCircleView


- (id)initWithCircle:(YFTMKCircle *)aCircle
{
    if (self = [super initWithOverlay:aCircle])
    {
    }
    return self;
}


- (YFTMKCircle *)circle
{
    return [super overlay];
}


- (NSString *)viewPrototypeName
{
    return @"google.maps.Circle";
}

- (NSDictionary *)options
{
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:[super options]];
    
    [options setObject:[NSNumber numberWithFloat:[self circle].radius] forKey:@"radius"];
    
    if (latlngCenter)
        [options setObject:latlngCenter forKey:@"center"];
    
    return [options copy];
}

- (void)draw:(WebScriptObject *)overlayScriptObject
{
    NSString *script = [NSString stringWithFormat:@"new google.maps.LatLng(%f, %f);", self.circle.coordinate.latitude, self.circle.coordinate.longitude];
    latlngCenter = (WebScriptObject *)[overlayScriptObject evaluateWebScript:script];
    [super draw:overlayScriptObject];
}

@end
