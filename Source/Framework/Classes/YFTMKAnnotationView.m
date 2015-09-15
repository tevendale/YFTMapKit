//
//  MKAnnotationView.m
//  MapKit
//
//  Created by Rick Fillion on 7/18/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import "YFTMKAnnotationView.h"
#import <YFTMapKit/YFTMKAnnotation.h>




@implementation YFTMKAnnotationView

@synthesize reuseIdentifier;
@synthesize annotation;
@synthesize imageUrl;
@synthesize centerOffset;
@synthesize calloutOffset;
@synthesize enabled;
@synthesize highlighted;
@synthesize selected;
@synthesize canShowCallout;
@synthesize draggable;
@synthesize dragState;

- (id)initWithAnnotation:(id <YFTMKAnnotation>)anAnnotation reuseIdentifier:(NSString *)aReuseIdentifier
{
    if (self = [super init])
    {
        reuseIdentifier = aReuseIdentifier;
        self.annotation = anAnnotation;
    }
    return self;
}


- (void)prepareForReuse
{
    // Unsupported so far.
}

- (void)setSelected:(BOOL)_selected animated:(BOOL)animated
{
    self.selected = _selected;
}

- (NSString *)viewPrototypeName
{
    return @"AnnotationOverlay";
}

- (NSDictionary *)options
{
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:[super options]];
    
    if (self.imageUrl)
        [options setObject:self.imageUrl forKey:@"imageUrl"];
    
    if (latlngCenter)
        [options setObject:latlngCenter forKey:@"position"];
    
    if ([self.annotation title])
        [options setObject:[self.annotation title] forKey:@"title"];
    
    [options setObject:[NSNumber numberWithBool:draggable] forKey:@"draggable"];
    //NSLog(@"options = %@", options);
    
    return [options copy];
}

- (void)draw:(WebScriptObject *)overlayScriptObject
{
 
    NSString *script = [NSString stringWithFormat:@"new google.maps.LatLng(%f, %f);", self.annotation.coordinate.latitude, self.annotation.coordinate.longitude];
    latlngCenter = (WebScriptObject *)[overlayScriptObject evaluateWebScript:script];
    
    [super draw:overlayScriptObject];
}

@end
